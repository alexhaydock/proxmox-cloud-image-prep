terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

# We specifically configure /var/tmp as our temp dir here rather than /tmp
# because /tmp is not usually very large and this will break when copying
# large images, e.g. Windows VMs
provider "proxmox" {
  endpoint = var.pve_url
  tmp_dir  = "/var/tmp"
}
