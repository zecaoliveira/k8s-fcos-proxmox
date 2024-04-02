## Deploying Kubernetes VMs in Proxmox with Terraform 

> Nota sobre a mudança dos rótulos.
> De "master" para "controller" e de "worker" para "node":
> https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#urgent-upgrade-notes
_____________________________________________________________________________________________
> Nota sobre formatação de texto no GitHub:
> https://docs.github.com/pt/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax

----------------------------------------------------------------------------------------------
> O Tutorial que estou usando é do James Turland:
> https://github.com/JamesTurland/JimsGarage/tree/main/Kubernetes/Cloud-Init. No momento em que o Turland fez o vídeo a versão 23.04 KVM ainda estava disponível. Eu estou usando a 22.04 LTS.
> 
> 23.04 - LUNAR - Download the ISO using the GUI (tested on https://cloud-images.ubuntu.com/lunar/current/lunar-server-cloudimg-amd64-disk-kvm.img)

Download the ISO using the GUI: https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img

Create the VM via CLI:
```
qm create 5000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
cd /var/lib/vz/template/iso/
qm importdisk 5000 lunar-server-cloudimg-amd64-disk-kvm.img <YOUR STORAGE HERE>
qm set 5000 --scsihw virtio-scsi-pci --scsi0 <YOUR STORAGE HERE>:vm-5000-disk-0
qm set 5000 --ide2 <YOUR STORAGE HERE>:cloudinit
qm set 5000 --boot c --bootdisk scsi0
qm set 5000 --serial0 socket --vga serial0
```
Expand the VM disk size to a suitable size (suggested 10 GB)
Create the Cloud-Init template
Deploy new VMs by cloning the template (full clone)



