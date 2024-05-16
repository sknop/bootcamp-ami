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

# Hint 

You can ignore the warnings and error messages with respect to `apt` and `debconf` 


