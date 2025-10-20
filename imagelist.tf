variable "lxc_imagelist" {
  type = map(object({
    image_filename = string
    image_url      = string
  }))
  default = {
    centos9 = {
      image_filename = "centos-9-stream-default_20240828_amd64.tar.xz"
      image_url      = "http://download.proxmox.com/images/system/centos-9-stream-default_20240828_amd64.tar.xz"
    }
    fedora42 = {
      image_filename = "fedora-42-default_20250428_amd64.tar.xz"
      image_url      = "http://download.proxmox.com/images/system/fedora-42-default_20250428_amd64.tar.xz"
    }
  }
}

variable "vm_imagelist" {
  type = map(object({
    image_filename = string
    image_url      = string
    vm_id          = number
    vm_name        = string
    vm_secureboot  = string
  }))
  default = {
    centos9 = {
      image_filename = "CentOS-Stream-GenericCloud-x86_64-9-latest.x86_64.qcow2"
      image_url      = "https://cloud.centos.org/centos/9-stream/x86_64/images/CentOS-Stream-GenericCloud-x86_64-9-latest.x86_64.qcow2"
      vm_id          = 1000
      vm_name        = "centos9"
      vm_secureboot  = "true"
    }
    fedora42 = {
      image_filename = "Fedora-Cloud-Base-Generic-42-1.1.x86_64.qcow2"
      image_url      = "https://ask4.mm.fcix.net/fedora/linux/releases/42/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-42-1.1.x86_64.qcow2"
      vm_id          = 1001
      vm_name        = "fedora42"
      vm_secureboot  = "true"
    }
  }
}
