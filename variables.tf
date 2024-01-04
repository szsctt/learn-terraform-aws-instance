variable "cidr_vpc" {
    description = "CIDR block for the VPC"
    type = string
    default = "10.1.0.0/16"
}
variable "cidr_subnet" {
    description = "CIDR block for the subnet"
    type = string
    default = "10.1.0.0/24"
}
variable "availability_zone" {
    description = "Availability zone for the subnet"
    type = string
    default = "us-west-2a"
}
variable "public_key_path" {
    description = "Path to the public key used for SSH access"
    type = string
    default = "~/.ssh/id_ed25519.pub"
}
variable "instance_name" {
    description = "Value of the Name tage for the EC2 instance"
    type = string
    default = "ExampleAppServerInstance"
}
variable "instance_ami" {
    description = "AMI to use for the instance"
    type = string
    default = "ami-008fe2fc65df48dac"
}
variable "instance_type" {
    description = "Type of instance to launch"
    type = string
    default = "t2.micro"
}
