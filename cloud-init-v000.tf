resource "proxmox_vm_qemu" "cloudinit-k8s-controller" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "srvpve01"
    desc = "Controller Node 01 - Kubernetes Cluster - Homelab Cloud"
    count = 1
    onboot = true
    vmid = "400${count.index + 1}"

    # The template name to clone this vm from
    clone = "fedora-coreos-tmplt"

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 2
    sockets = 2
    numa = true
    vcpus = 0
    cpu = "host"
    memory = 8096
    name = "controller0${count.index + 1}"

    cloudinit_cdrom_storage = "local-lvm"
    scsihw   = "virtio-scsi-single" 
    bootdisk = "scsi0"

    disks {
        scsi {
            scsi0 {
                disk {
                storage = "local-lvm"
                size = 32
                }
            }
        }
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=172.16.0.3${count.index + 1}/24,gw=172.16.0.1"
}

resource "proxmox_vm_qemu" "cloudinit-k8s-nodes" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "srvpve01"
    desc = "Nodes Kubernetes Cluster - Homelab Cloud"
    count = 2
    onboot = true
    vmid = "410${count.index + 1}"

    # The template name to clone this vm from
    clone = "fedora-coreos-tmplt"

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 2
    sockets = 2
    numa = true
    vcpus = 0
    cpu = "host"
    memory = 8096
    name = "node0${count.index + 1}"

    cloudinit_cdrom_storage = "local-lvm"
    scsihw   = "virtio-scsi-single" 
    bootdisk = "scsi0"

    disks {
        scsi {
            scsi0 {
                disk {
                storage = "local-lvm"
                size = 32
                }
            }
        }
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=172.16.0.4${count.index + 1}/24,gw=172.16.0.1"
}

