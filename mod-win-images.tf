resource "proxmox_virtual_environment_file" "vm_images_windows" {
  content_type = "import"
  datastore_id = var.datastore_images
  node_name    = var.pve_node_name

  # Loop over values in tf-imagelist.tf
  for_each = var.windows_vm_imagelist

  source_file {
    path = each.value.path
  }
}
