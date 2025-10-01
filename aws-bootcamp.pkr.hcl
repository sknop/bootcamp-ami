packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.15"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

data "amazon-ami" "ubuntu-image" {
  filters = {
    architecture                       = "x86_64"
    "block-device-mapping.volume-type" = "gp3"
    name                               = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    root-device-type                   = "ebs"
    virtualization-type                = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
  region      = var.region
}

locals {
  keep_until = formatdate("YYYY-MM-DD", timeadd(timestamp(),"24h"))
}

source "amazon-ebs" "bootcamp" {
  ami_name      = "bootcamp-CP-${var.cp-version}-${local.timestamp}"
  instance_type = "t3.micro"  # t2.micro not available for ap-south-2
  region        = var.region
  source_ami    = "${data.amazon-ami.ubuntu-image.id}"
  ssh_username  = "ubuntu"
  # If you do not have a default VPC and subnet, you can hardcode them here
  #  vpc_id        = "vpc-054059f7559b6f110"
  #  subnet_id     = "subnet-007008728fed45f02"

  ami_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = 20
  }
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = 20
  }
  tags = {
    os_version = "ubuntu"
    cp_version = var.cp-version
    owner_name = var.owner_name
    owner_email = var.owner_email
    cflt_partition = var.cflt_partition
    cflt_managed_by	= var.cflt_managed_by
    cflt_managed_id	= var.cflt_managed_id
    cflt_service      = var.cflt_service
    cflt_environment  = var.cflt_environment
    cflt_keep_until   = local.keep_until
  }
}

build {
  name = "bootcamp-base-image"
  sources = [
    "source.amazon-ebs.bootcamp"
  ]

  provisioner "shell" {
    inline = ["echo 'Sleeping for 30 seconds to give Ubuntu enough time to initialize (otherwise, packages may fail to install).'", "sleep 30", "sudo apt-get update"]
  }

  provisioner "file" {
    destination = "/tmp/"
    source      = "./install-tools.sh"
  }

  provisioner "shell" {
    inline = ["/tmp/install-tools.sh ${var.cp-version}"]
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
