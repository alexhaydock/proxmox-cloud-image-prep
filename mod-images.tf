resource "proxmox_virtual_environment_download_file" "images" {
  content_type = "import"
  datastore_id = var.datastore_images
  node_name    = var.pve_node_name

  # Loop over values in imagelist.tf
  for_each = var.imagelist

  file_name = each.value.image_filename
  url       = each.value.image_url
}
