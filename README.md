# proxmox-cloud-image-prep

Terraform project to prep Proxmox with a set of upstream cloud images ready to clone and use.

## Image definitions
Images are defined in `tf-imagelist.tf` as a set of variables. These are fed to `mod-linux-images.tf` and `mod-linux-vms.tf` which will download the images, and configure template VMs each of them.

## Authentication
Provide Proxmox auth credentials to the shell/Terraform process [as described in the Proxmox provider documentation](https://registry.terraform.io/providers/bpg/proxmox/latest/docs#authentication).

## Configure local datastore for cloud image import
We need to configure the local file-based datastore (called `local` by default) to allow importing `qcow2`-based cloud images.

* Navigate to "Datacenter" in PVE
* Storage > `local` > Edit
* In "Content", add "Import" to the list of enabled content types

## Building/disabling Windows images
To build the Windows images for this project, you can clone my [packer-windows-qemu-ssh](https://github.com/alexhaydock/packer-windows-qemu-ssh) into a directory alongside this project and run the `packer build` command listed in the README.

Alternatively, simply `rm mod-win*` from this directory to disable the Windows image support.

## Copying Windows images notes
Copying Windows images to the Proxmox node uses the `proxmox_virtual_environment_file` resource, which will attempt to connect to the Proxmox node via SSH. Ensure that you have the ability to do this as the `root@pam` user.

Without this ability, the code could be reworked to use `proxmox_virtual_environment_download_file` to download the file _from_ our orchestration host instead. I've avoided this complexity as it requires spinning up a webserver to host our Windows qcow2 file for the Proxmox server to pull.

## Providing variables
You must provide at least `pve_url` and `pve_node_name`. You may also override the default values of any other variables defined in `tf-vars.tf`.

### `yournode.tfvars`
```terraform
pve_node_name = "yournodename"
pve_url       = "https://yournode.example.com:8006"
template_pass = "correct horse battery staple"
template_user = "user"
template_vlan = "100"
```

## Running with your variables
```sh
tofu apply --var-file="yournode.tfvars"
```

## Approach
This approach will download the latest version of each referenced cloud image and create a template of it.

This means we can update all images like this:
```sh
tofu destroy --var-file="yournode.tfvars" && tofu apply --var-file="yournode.tfvars"
```

## Why are Ubuntu/Debian not included in the default imagelist?
Canonical do not ship the QEMU Guest Agent in their cloud images, and [don't seem to have qcow2-based images](https://cloud-images.ubuntu.com/releases/noble/release/).

Debian do not ship the Agent either, and [explain their reasoning here](https://wiki.debian.org/Cloud#Why_isn.27t_the_qemu-guest-agent_package_pre-installed_in_the_cloud_images.3F).
