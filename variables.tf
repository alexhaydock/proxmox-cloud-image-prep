variable "datastore_images" {
  description = "Datastore to use for image imports"
  type        = string
  default     = "local"
}

variable "datastore_vms" {
  description = "Datastore to use for VM storage"
  type        = string
  default     = "local-zfs"
}

variable "pve_node_name" {
  description = "Name of the Proxmox VE node"
  type        = string
}

variable "pve_url" {
  description = "URL of the Proxmox VE server"
  type        = string
}

variable "template_password" {
  description = "Password to set for template VM user"
  type        = string
  default     = "correct horse battery staple"
}

variable "template_user" {
  description = "Name to use for template VM user"
  type        = string
  default     = "user"
}

variable "template_vlan" {
  description = "Default VLAN to use for template VMs"
  type        = string
  default     = "100"
}
