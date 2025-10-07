variable "imagelist" {
  type = map(object({
    vm_id          = number
    vm_name        = string
    image_filename = string
    image_url      = string
  }))
  default = {
    centos9 = {
      vm_id          = 1000
      vm_name        = "centos9"
      image_filename = "CentOS-Stream-GenericCloud-x86_64-9-latest.x86_64.qcow2"
      image_url      = "https://cloud.centos.org/centos/9-stream/x86_64/images/CentOS-Stream-GenericCloud-x86_64-9-latest.x86_64.qcow2"
    }
    fedora42 = {
      vm_id          = 1001
      vm_name        = "fedora42"
      image_filename = "Fedora-Cloud-Base-Generic-42-1.1.x86_64.qcow2"
      image_url      = "https://ask4.mm.fcix.net/fedora/linux/releases/42/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-42-1.1.x86_64.qcow2"
    }
    ubuntu2404 = {
      vm_id          = 1002
      vm_name        = "ubuntu2404"
      image_filename = "ubuntu-24.04-server-cloudimg-amd64.qcow2" # Renames file to qcow2 for import
      image_url      = "https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
    }
  }
}
