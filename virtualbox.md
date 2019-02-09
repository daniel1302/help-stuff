## Headless


```
VBoxManage createvm --name Linux1 --ostype Linux_64 --register

VBoxManage showvminfo Linux1

VBoxManage modifyvm Linux1 --cpus 1 --memory 2000 --vram 12

VBoxManage modifyvm Linux1 --nic1 bridged --bridgeadapter1 eno2

VBoxManage createhd --filename /home/daniel/vm-disks/Linux1.vdi --size 30000 --variant Standard 

VBoxManage storagectl Linux1 --name "SATA Controller" --add sata --bootable on

VBoxManage storageattach Linux1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /home/daniel/vm-disks/Linux1.vdi

VBoxManage storagectl Linux1 --name "IDE Controller" --add ide

VBoxManage storageattach Linux1 --storagectl "IDE Controller" --port 0  --device 0 --type dvddrive --medium /home/daniel/linux-images/ubuntu.iso

VBoxManage showvminfo Linux1 | grep "IDE Controller"

VBoxManage modifyvm Linux1 --vrde on 

VBoxManage showvminfo Linux1 | grep VRDE

VBoxManage startvm Linux1 --type headless

```
