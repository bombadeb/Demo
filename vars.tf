variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
 default = "ap-southeast-2"
}
variable "AWS_KEY" {
 default = "TEST_KEY"
}

variable "AMIS" {
  type = map(string)
  default = {
    ap-southeast-1 = "ami-0c8e97a27be37adfd"
    ap-southeast-2 = "ami-099c1869f33464fde"
  }
}

