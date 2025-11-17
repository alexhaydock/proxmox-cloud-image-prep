# Here, we import the "Cloud" versions of relevant images, so we can
# post-provision them using cloud-init and SSH. The "Default" versions
# do not ship SSH or cloud-init.
variable "lxc_imagelist" {
  type = map(object({
    image_filename = string
    image_url      = string
  }))
  default = {
    alpine322 = {
      image_filename = "alpine-3.22.tar.xz"
      image_url      = "https://images.linuxcontainers.org/images/alpine/3.22/amd64/cloud/20251116_13:00/rootfs.tar.xz"
    }
    centos10 = {
      image_filename = "centos-10.tar.xz"
      image_url      = "https://images.linuxcontainers.org/images/centos/10-Stream/amd64/cloud/20251116_07:08/rootfs.tar.xz"
    }
    fedora43 = {
      image_filename = "fedora-43.tar.xz"
      image_url      = "https://images.linuxcontainers.org/images/fedora/43/amd64/cloud/20251116_20:33/rootfs.tar.xz"
    }
  }
}

variable "linux_vm_imagelist" {
  type = map(object({
    image_filename = string
    image_url      = string
    vm_id          = number
    vm_name        = string
    vm_secureboot  = string
  }))
  default = {
    centos10 = {
      image_filename = "CentOS-Stream-GenericCloud-10-latest.x86_64.qcow2"
      image_url      = "https://cloud.centos.org/centos/10-stream/x86_64/images/CentOS-Stream-GenericCloud-10-latest.x86_64.qcow2"
      vm_id          = 1000
      vm_name        = "centos10"
      vm_secureboot  = "true"
    }
    fedora43 = {
      image_filename = "Fedora-Cloud-Base-Generic-43-1.6.x86_64.qcow2"
      image_url      = "https://ask4.mm.fcix.net/fedora/linux/releases/43/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-43-1.6.x86_64.qcow2"
      vm_id          = 1001
      vm_name        = "fedora43"
      vm_secureboot  = "true"
    }
  }
}

# To build the Windows image used here, please see my `packer-windows-qemu-ssh` project:
#   https://github.com/alexhaydock/packer-windows-qemu-ssh
variable "windows_vm_imagelist" {
  type = map(object({
    # Path specifies the *local* path to the Windows qcow2 files
    # to be copied to the remote Proxmox instance
    image_filename = string
    path           = string
    vm_id          = number
    vm_name        = string
    vm_secureboot  = string
  }))
  default = {
    win11-25h2 = {
      image_filename = "win11_25h2.qcow2"
      path           = "../packer-windows-qemu-ssh/output-win11_25h2/win11_25h2.qcow2"
      vm_id          = 1002
      vm_name        = "win11-25h2"
      vm_secureboot  = "true"
    }
  }
}
