resource "proxmox_virtual_environment_vm" "vm_templates_windows" {
  depends_on = [proxmox_virtual_environment_file.vm_images_windows]

  name = "win11-25h2"
  tags = ["template"]

  # Loop over values in tf-imagelist.tf
  for_each = var.windows_vm_imagelist

  # Specify node to deploy to, VMID and auto-boot status
  node_name = var.pve_node_name
  vm_id     = each.value.vm_id
  on_boot   = false
  started   = false # Do not start after deploying
  template  = true

  agent {
    enabled = true
  }

  # Invoke the magical incantations to enable Secure Boot
  #
  # This works even on Win 11 25H2+ images now that my patch has been merged upstream:
  #   https://git.proxmox.com/?p=pve-edk2-firmware.git;a=blob;f=debian/patches/OvmfPkg-Expand-EnrollDefaultKeys-with-Microsoft-2023.patch;h=2d0fcd2bcc2605fda5a376d232e93ed171eaa785;hb=714c8a05662580d4553e045b3c404b614dc1ac27
  bios    = "ovmf"
  machine = "q35"
  efi_disk {
    datastore_id      = var.datastore_vms
    type              = "4m"                     # Recommended for Secure Boot
    pre_enrolled_keys = each.value.vm_secureboot # Enables Secure Boot if configured for the VM image
  }

  cpu {
    cores = 4
    type  = "host" # defaults to `qemu64` if we don't specify
  }

  memory {
    dedicated = 8192
    floating  = 8192 # enable ballooning device as per Proxmox docs' recommendation
  }

  boot_order = ["scsi0"]
  disk {
    datastore_id = var.datastore_vms
    import_from  = "${var.datastore_images}:import/${each.value.image_filename}"
    interface    = "scsi0"
    size         = 64
  }

  tpm_state {
    datastore_id = var.datastore_vms
  }

  network_device {
    bridge  = "vmbr0"
    vlan_id = var.template_vlan
  }

  operating_system {
    type = "win11"
  }

  # Use VirtIO for video output
  vga {
    type = "virtio"
  }
}
