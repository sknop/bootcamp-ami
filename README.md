# bootcamp-ami
Packer configuration file to create AWS Ami with java 17 and Confluent CP Enterprise installed based on Ubuntu 20.04

# Instructions

* Install packer
* Clone this repository
* Copy variables.auto.pkrvars.hcl.template to variables.auto.pkrvars.hcl
* Configure AWS to point to your desired region (in variables.auto.pkrvars.hcl)
* Initialize packer

        packer init .

* Run 

        packer build .
    
* If successful, the script will return with the AMI Id you can use in your terraform scripts

Build takes around 15 min

The AMI name can also be found in the generated manifeset.json file under builds.artifact_id.

# Hints

You can ignore the warnings and error messages with respect to `apt` and `debconf` 

Occasionally, Packer will fail to create the AMI because the default VPC in AWS 
is either not available or not correctly configured. In this case, modify the script 

    aws-bootcamp.pkr.hcl 

You will find these lines in the file.

    # If you do not have a default VPC and subnet, you can hardcode them here
    #  vpc_id        = "vpc-054059f7559b6f110"
    #  subnet_id     = "subnet-007008728fed45f02"

Replace the vpc_id and (public) subnet_id with values from the VPC you created via 
bootcamp-vpc.

