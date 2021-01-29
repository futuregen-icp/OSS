# GPU shareing을 위한 host server 설정 

## intall 과정 

### 1. OS graphic driver 버전 확인

   ```
   lspci -vnn | grep VGA
   ```

### 2. driver download 

   [NVIDIA driver](https://www.nvidia.com/en-us/drivers/unix/) 

### 3.  드라이버 설치 전 필요 패키지 설치

   ```
   dnf groupinstall "Server with GUI" "base-x" "Legacy X Window System Compatibility" "Development Tools"
   dnf install libglvnd-devel elfutils-libelf-devel
   ```

### 4. 기존 드라이버 nouveau 비활성화

   ```
    grub2-editenv — set “$(grub2-editenv — list | grep kernelopts) nouveau.modeset=0”
    dracut --force
   ```

### 5.  nouveau 비활성화 시 cui 환경으로 전환

   ```
   systemctl set-default multi-user.target
   reboot
   ```

### 6. 드라이버 다운받은 경로롤 진입 후 설치 진행

   ```
   bash NVIDIA-Linux-x86_64-*
   ```

### 7. 드라이버 설치 완료 후 gui 모드로 변경

   ```
   systemctl set-default graphical.target
   systemctl restart systemd-logind
   grub2-mkconfig
   reboot
   ```

### 8. 설치 확인 

   ```
   nvidia-persistenced
   nvidia-smi
   ```

   

## gpu sharing 을 위한 vfio 설정 

### 1. iommu 설정 

   ```
   # vi /etc/default/grub
   ...
   GRUB_CMDLINE_LINUX="nofb splash=quiet console=tty0 ... intel_iommu=on
   ...
   
   or 
   
   # vi /etc/default/grub
   ...
   GRUB_CMDLINE_LINUX="nofb splash=quiet console=tty0 ... amd_iommu=on
   ...
   ```

### 2. vfio 설정 

   ```
   /etc/modprobe.d/vfio-pci.conf
   
   ...
   options vfio_iommu_type1 allow_unsafe_interrupts=1
   ...
   ```

   ```
   a.sh
   #!/bin/bash
   shopt -s nullglob
   for g in `find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V`; do
       echo "IOMMU Group ${g##*/}:"
       for d in $g/devices/*; do
           echo -e "\t$(lspci -nns ${d##*/})"
       done;
   done;
   
   
   sh a.sh 
   
   ...
   
           2c:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
   IOMMU Group 25:
           22:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Black 2018/PC SN720 NVMe SSD [15b7:5002]
   IOMMU Group 26:
           26:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062 Serial ATA Controller [1b21:0612] (rev 02)
   IOMMU Group 27:
           27:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)
   IOMMU Group 28:
           29:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8822BE 802.11a/b/g/n/ac WiFi adapter [10ec:b822]
   IOMMU Group 29:
           2d:00.0 VGA compatible controller [0300]: NVIDIA Corporation GP107 [GeForce GTX 1050 Ti] [10de:1c82] (rev a1)
           2d:00.1 Audio device [0403]: NVIDIA Corporation GP107GL High Definition Audio Controller [10de:0fb9] (rev a1)
   
   ...
   ```

   ```
   /etc/modprobe.d/vfio-pci.conf
   options vfio-pci ids=10de:1c82,10de:0fb9
   options vfio_iommu_type1 allow_unsafe_interrupts=1
   ```

### 3. 적용

   ```
   dracut --force
   grub2-mkconfig
   reboot
   ```

### 4. 확인

   ```
   lspci -k
   ...
   2d:00.0 VGA compatible controller: NVIDIA Corporation GP107 [GeForce GTX 1050 Ti] (rev a1)
           Subsystem: NVIDIA Corporation Device 11bf
           Kernel driver in use: vfio-pci
           Kernel modules: nouveau, nvidia_drm, nvidia
   2d:00.1 Audio device: NVIDIA Corporation GP107GL High Definition Audio Controller (rev a1)
           Subsystem: NVIDIA Corporation Device 11bf
           Kernel driver in use: vfio-pci
           Kernel modules: snd_hda_intel
   ...
   ```

   

> **KVM에서 pci passthru를 이용하여 gpu sharing 가능** 
>
> **OS 설치 이후  nvidia drive를 설치 해야 정상적인 사용 가능** 

### 5. Guest OS

설졍 변경을 해야 pci passthru가 정상적으로 동작함 

```
 virsh edit gworker

  <features>
    <acpi/>
    <apic/>
    **<kvm>**
      **<hidden state='on'/>**
    **</kvm>**
    <vmport state='off'/>
  </features>
```

