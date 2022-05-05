# confluent-ami-creator
Packer configuration file to create AWS Ami with java 11 and confluent enterprise installed based on Ubuntu 20.04

# Instructions

* Install packer
* Clone this repository
* Configure AWS to point to your desired region
* Initialize packer

        packer init
* Run 

        packer build aws-bootcamp.pkr.hcl
    
* If successful, the script will return with the AMI Id you can use in your terraform scripts

Build takes around 15 min

# Hint 

You can ignore the warnings and error messages with respect to `apt` and `debconf` 


