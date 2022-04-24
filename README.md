# confluent-ami-creator
Packer configuration file to create AWS Ami with java 11 and confluent enterprise installed based on Ubuntu 20.04

# Instructions

* Install packer
* Clone this repostitory
* Configure AWS to point to your desired region
* Run 

        packer build -var 'ami_name_prefix=confluent-base' template.json
    
* If successful, the script will return with the AMI Id you can use in your terraform scripts

Build takes around 15 min

