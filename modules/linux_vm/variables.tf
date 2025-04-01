variable "name" {
  description = "The name for the virtual machine"
}

variable "nic_name" {
  description = "The name for the VMs nic"
  default     = "vnic1"
}


variable "ip_name" {
  description = "The name of the resource group to create"
  default     = "vnic1_ip"
}


variable "region" {
  description = "The Azure region in which to create the resource group"
  default     = "Canada Central"
}

variable "resource_group" {
  description = "The name of the resource group to use for this virtual network"
}

variable "subnet" {
  description = "The subnet that the VM's network interface should use"
}


variable "vm_size" {
  description = "The Azure VM size to use to create this VM"
}


variable "root_user" {
  description = "The username for the root user for this VM"
}

variable "root_user_pub_key" {
  description = "The Public Key of an SSH key pair to use for the root user for this VM.  Set this via the terraform workspace variables."
}

variable "hostname" {
  description = "The hostname to set for the VM you create"
}

variable "custom_data" {
  description = "Base 64 encoded Custom Data instructions to pass to cloud-init and run on the VM at first boot."
}

// Variables to set tag fields for all resources that will use them. Should be set from the top level main.tf
variable "tag-owner" {}
variable "tag-project" {}
variable "tag-lifetime" {}
