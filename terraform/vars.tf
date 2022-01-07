variable "REGION" {
  default = "us-east-2"
}

variable "AMI_MAP" {
  type = map(string)
  default = {
    us-east-2 = "ami-002068ed284fb165b"
  }
}

variable "A_ZONE_MAP" {
  type = map(string)
  default = {
    us-east-2 = "us-east-2a"
  }
}

variable "KEY_PRIVATE_PATH" {
  default = "files/key"
}

variable "KEY_PUBLIC_PATH" {
  default = "files/key.pub"
}

variable "USER" {
  default = "ec2-user"
}
