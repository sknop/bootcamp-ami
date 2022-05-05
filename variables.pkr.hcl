//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

variable "region" {
  type = string
  default = "eu-west-1"
}

variable "cp-version" {
  type = string
  default = "7.1"
}
