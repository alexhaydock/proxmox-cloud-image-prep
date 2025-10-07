# proxmox-cloud-image-prep

Terraform project to prep Proxmox with a set of upstream cloud images ready to clone and use.

## Image definitions
Images are defined in `imagelist.tf` as a set of variables. These are fed to `mod-images.tf` and `mod-vms.tf` which will download the images, and configure template VMs each of them.

## Authentication
Provide Proxmox auth credentials to the shell/Terraform process [as described in the Proxmox provider documentation](https://registry.terraform.io/providers/bpg/proxmox/latest/docs#authentication).

## Configure local datastore for cloud image import
We need to configure the local file-based datastore (called `local` by default) to allow importing `qcow2`-based cloud images.

* Navigate to "Datacenter" in PVE
* Storage > `local` > Edit
* In "Content", add "Import" to the list of enabled content types

## Providing variables
You must provide at least `pve_url` and `pve_node_name`. You may also override the default values of any other variables defined in `variables.tf`.

### `yournode.tfvars`
```terraform
pve_url="https://pvenode.yourdomain.com:8006"
pve_node_name="yournodename"
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
