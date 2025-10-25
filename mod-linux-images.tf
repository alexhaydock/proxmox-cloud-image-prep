resource "proxmox_virtual_environment_download_file" "lxc_images" {
  content_type = "vztmpl"
  datastore_id = var.datastore_images
  node_name    = var.pve_node_name

  # Loop over values in tf-imagelist.tf
  for_each = var.lxc_imagelist

  file_name = each.value.image_filename
  url       = each.value.image_url
}

resource "proxmox_virtual_environment_download_file" "vm_images_linux" {
  content_type = "import"
  datastore_id = var.datastore_images
  node_name    = var.pve_node_name

  # Loop over values in linux_vm_imagelist.tf
  for_each = var.linux_vm_imagelist

  file_name = each.value.image_filename
  url       = each.value.image_url
}
