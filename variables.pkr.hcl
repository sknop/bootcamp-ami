//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

variable "region" {
  type = string
  default = "eu-west-1"
}

variable "cp-version" {
  type = string
  default = "7.3"
}

variable "owner_name" {
  type = string
  default = ""
}

variable "owner_email" {
  type = string
  default = ""
}

variable "cflt_environment" {
  default = "devel"
}

variable "cflt_partition" {
  default = "onprem"
}

variable "cflt_managed_by" {
  default = "user"
}

variable "cflt_managed_id" {
  default = "sven"
}

variable "cflt_service" {
  description = "This is the theatre of operation, like EMEA or APAC"
  type = string
  default = "CTG"
}
