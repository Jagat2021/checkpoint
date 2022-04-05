# VPC Variables
variable "vpc_cidr" {
  type    = string
  default = "192.168.1.0/24"
}
variable "instance_tenancy" {
  type    = string
  default = "default"
}
variable "enable_dns_hostnames" {
  type    = bool
  default = true
}
variable "vpc_tags" {
  type = map(string)
  default = {
    Name = "checkpoint-vpc"
    Dept = "dev"
  }
}

#Subnet Variabled
variable "public-subnet-1" {
  type    = string
  default = "192.168.1.0/26"
}
variable "public-subnet-1-tags" {
  type = map(string)
  default = {
    Name = "public-subnet-1"
  }
}
variable "public-subnet-2" {
  type    = string
  default = "192.168.1.64/26"
}
variable "public-subnet-2-tags" {
  type = map(string)
  default = {
    Name = "public-subnet-2"
  }
}



variable "private-subnet-1" {
  type    = string
  default = "192.168.1.128/26"
}
variable "private-subnet-1-tags" {
  type = map(string)
  default = {
    Name = "private-subnet-1"
  }
}
variable "private-subnet-2" {
  type    = string
  default = "192.168.1.192/26"
}
variable "private-subnet-2-tags" {
  type = map(string)
  default = {
    Name = "private-subnet-2"
  }
}

# Availability Zones
variable "az_us_east_1a" {
  type    = string
  default = "us-east-1a"
}
variable "az_us_east_1b" {
  type    = string
  default = "us-east-1b"
}
