# 실습

- disk 추가

```jsx
[root@node1 ~]# lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   32G  0 disk
├─sda1            8:1    0    1G  0 part /boot
└─sda2            8:2    0   31G  0 part
├─centos-root 253:0    0 27.8G  0 lvm  /
└─centos-swap 253:1    0  3.2G  0 lvm  [SWAP]
sdb               8:16   0    8G  0 disk
sr0              11:0    1 1024M  0 rom
[root@node2 ~]# lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   32G  0 disk
├─sda1            8:1    0    1G  0 part /boot
└─sda2            8:2    0   31G  0 part
  ├─centos-root 253:0    0 27.8G  0 lvm  /
  └─centos-swap 253:1    0  3.2G  0 lvm  [SWAP]
sdb               8:16   0    8G  0 disk
sr0              11:0    1  973M  0 rom
////////
[root@node1 ~]# fdisk /dev/sdb
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0x6414a247.

Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1):
First sector (2048-16777215, default 2048):
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-16777215, default 16777215):
Using default value 16777215
Partition 1 of type Linux and of size 8 GiB is set

Command (m for help): l

 0  Empty           24  NEC DOS         81  Minix / old Lin bf  Solaris
 1  FAT12           27  Hidden NTFS Win 82  Linux swap / So c1  DRDOS/sec (FAT-
 2  XENIX root      39  Plan 9          83  Linux           c4  DRDOS/sec (FAT-
 3  XENIX usr       3c  PartitionMagic  84  OS/2 hidden C:  c6  DRDOS/sec (FAT-
 4  FAT16 <32M      40  Venix 80286     85  Linux extended  c7  Syrinx
 5  Extended        41  PPC PReP Boot   86  NTFS volume set da  Non-FS data
 6  FAT16           42  SFS             87  NTFS volume set db  CP/M / CTOS / .
 7  HPFS/NTFS/exFAT 4d  QNX4.x          88  Linux plaintext de  Dell Utility
 8  AIX             4e  QNX4.x 2nd part 8e  Linux LVM       df  BootIt
 9  AIX bootable    4f  QNX4.x 3rd part 93  Amoeba          e1  DOS access
 a  OS/2 Boot Manag 50  OnTrack DM      94  Amoeba BBT      e3  DOS R/O
 b  W95 FAT32       51  OnTrack DM6 Aux 9f  BSD/OS          e4  SpeedStor
 c  W95 FAT32 (LBA) 52  CP/M            a0  IBM Thinkpad hi eb  BeOS fs
 e  W95 FAT16 (LBA) 53  OnTrack DM6 Aux a5  FreeBSD         ee  GPT
 f  W95 Ext'd (LBA) 54  OnTrackDM6      a6  OpenBSD         ef  EFI (FAT-12/16/
10  OPUS            55  EZ-Drive        a7  NeXTSTEP        f0  Linux/PA-RISC b
11  Hidden FAT12    56  Golden Bow      a8  Darwin UFS      f1  SpeedStor
12  Compaq diagnost 5c  Priam Edisk     a9  NetBSD          f4  SpeedStor
14  Hidden FAT16 <3 61  SpeedStor       ab  Darwin boot     f2  DOS secondary
16  Hidden FAT16    63  GNU HURD or Sys af  HFS / HFS+      fb  VMware VMFS
17  Hidden HPFS/NTF 64  Novell Netware  b7  BSDI fs         fc  VMware VMKCORE
18  AST SmartSleep  65  Novell Netware  b8  BSDI swap       fd  Linux raid auto
1b  Hidden W95 FAT3 70  DiskSecure Mult bb  Boot Wizard hid fe  LANstep
1c  Hidden W95 FAT3 75  PC/IX           be  Solaris boot    ff  BBT
1e  Hidden W95 FAT1 80  Old Minix

Command (m for help): p

Disk /dev/sdb: 8589 MB, 8589934592 bytes, 16777216 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x6414a247

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1            2048    16777215     8387584   83  Linux

Command (m for help):
Command (m for help):
Command (m for help):
Command (m for help):
Command (m for help): w
The partition table has been altered!
[root@node1 ~]# parted -l
Model: VMware Virtual disk (scsi)
Disk /dev/sda: 34.4GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  1075MB  1074MB  primary  xfs          boot
 2      1075MB  34.4GB  33.3GB  primary               lvm

Model: VMware Virtual disk (scsi)
Disk /dev/sdb: 8590MB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  8590MB  8589MB  primary

Model: Linux device-mapper (linear) (dm)
Disk /dev/mapper/centos-swap: 3435MB
Sector size (logical/physical): 512B/512B
Partition Table: loop
Disk Flags:

Number  Start  End     Size    File system     Flags
 1      0.00B  3435MB  3435MB  linux-swap(v1)

Model: Linux device-mapper (linear) (dm)
Disk /dev/mapper/centos-root: 29.8GB
Sector size (logical/physical): 512B/512B
Partition Table: loop
Disk Flags:

Number  Start  End     Size    File system  Flags
 1      0.00B  29.8GB  29.8GB  xfs

[root@node1 ~]# rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
[root@node1 ~]# ll
합계 4
-rw-------. 1 root root 1257  7월 27 16:50 anaconda-ks.cfg
[root@node1 ~]# rpm -ivh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm(을)를 복구합니다
http://elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm(을)를 복구합니다
준비 중...                         ################################# [100%]
Updating / installing...
   1:elrepo-release-7.0-4.el7.elrepo  ################################# [100%]
[root@node1 ~]# ll /etc/yum.repos.d/
합계 44
-rw-r--r--. 1 root root 1664 11월 24  2020 CentOS-Base.repo
-rw-r--r--. 1 root root 1309 11월 24  2020 CentOS-CR.repo
-rw-r--r--. 1 root root  649 11월 24  2020 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  630 11월 24  2020 CentOS-Media.repo
-rw-r--r--. 1 root root 1331 11월 24  2020 CentOS-Sources.repo
-rw-r--r--. 1 root root 8515 11월 24  2020 CentOS-Vault.repo
-rw-r--r--. 1 root root  314 11월 24  2020 CentOS-fasttrack.repo
-rw-r--r--. 1 root root  616 11월 24  2020 CentOS-x86_64-kernel.repo
-rw-r--r--. 1 root root 1901  7월 16  2019 elrepo.repo
[root@node1 ~]#
////////////////////////노드 2도 똑같이 ...
[root@node2 ~]# fdisk /dev/sdb
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0xc5c16992.

Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1):
First sector (2048-16777215, default 2048):
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-16777215, default 16777215):
Using default value 16777215
Partition 1 of type Linux and of size 8 GiB is set

Command (m for help): l

 0  Empty           24  NEC DOS         81  Minix / old Lin bf  Solaris
 1  FAT12           27  Hidden NTFS Win 82  Linux swap / So c1  DRDOS/sec (FAT-
 2  XENIX root      39  Plan 9          83  Linux           c4  DRDOS/sec (FAT-
 3  XENIX usr       3c  PartitionMagic  84  OS/2 hidden C:  c6  DRDOS/sec (FAT-
 4  FAT16 <32M      40  Venix 80286     85  Linux extended  c7  Syrinx
 5  Extended        41  PPC PReP Boot   86  NTFS volume set da  Non-FS data
 6  FAT16           42  SFS             87  NTFS volume set db  CP/M / CTOS / .
 7  HPFS/NTFS/exFAT 4d  QNX4.x          88  Linux plaintext de  Dell Utility
 8  AIX             4e  QNX4.x 2nd part 8e  Linux LVM       df  BootIt
 9  AIX bootable    4f  QNX4.x 3rd part 93  Amoeba          e1  DOS access
 a  OS/2 Boot Manag 50  OnTrack DM      94  Amoeba BBT      e3  DOS R/O
 b  W95 FAT32       51  OnTrack DM6 Aux 9f  BSD/OS          e4  SpeedStor
 c  W95 FAT32 (LBA) 52  CP/M            a0  IBM Thinkpad hi eb  BeOS fs
 e  W95 FAT16 (LBA) 53  OnTrack DM6 Aux a5  FreeBSD         ee  GPT
 f  W95 Ext'd (LBA) 54  OnTrackDM6      a6  OpenBSD         ef  EFI (FAT-12/16/
10  OPUS            55  EZ-Drive        a7  NeXTSTEP        f0  Linux/PA-RISC b
11  Hidden FAT12    56  Golden Bow      a8  Darwin UFS      f1  SpeedStor
12  Compaq diagnost 5c  Priam Edisk     a9  NetBSD          f4  SpeedStor
14  Hidden FAT16 <3 61  SpeedStor       ab  Darwin boot     f2  DOS secondary
16  Hidden FAT16    63  GNU HURD or Sys af  HFS / HFS+      fb  VMware VMFS
17  Hidden HPFS/NTF 64  Novell Netware  b7  BSDI fs         fc  VMware VMKCORE
18  AST SmartSleep  65  Novell Netware  b8  BSDI swap       fd  Linux raid auto
1b  Hidden W95 FAT3 70  DiskSecure Mult bb  Boot Wizard hid fe  LANstep
1c  Hidden W95 FAT3 75  PC/IX           be  Solaris boot    ff  BBT
1e  Hidden W95 FAT1 80  Old Minix

Command (m for help): p

Disk /dev/sdb: 8589 MB, 8589934592 bytes, 16777216 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0xc5c16992

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1            2048    16777215     8387584   83  Linux

Command (m for help):
Command (m for help):
Command (m for help):
Command (m for help):
Command (m for help): w
The partition table has been altered!
[root@node2 ~]# parted -l
Model: VMware Virtual disk (scsi)
Disk /dev/sda: 34.4GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  1075MB  1074MB  primary  xfs          boot
 2      1075MB  34.4GB  33.3GB  primary               lvm

Model: VMware Virtual disk (scsi)
Disk /dev/sdb: 8590MB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  8590MB  8589MB  primary

Model: Linux device-mapper (linear) (dm)
Disk /dev/mapper/centos-swap: 3435MB
Sector size (logical/physical): 512B/512B
Partition Table: loop
Disk Flags:

Number  Start  End     Size    File system     Flags
 1      0.00B  3435MB  3435MB  linux-swap(v1)

Model: Linux device-mapper (linear) (dm)
Disk /dev/mapper/centos-root: 29.8GB
Sector size (logical/physical): 512B/512B
Partition Table: loop
Disk Flags:

Number  Start  End     Size    File system  Flags
 1      0.00B  29.8GB  29.8GB  xfs

Warning: Unable to open /dev/sr0 read-write (읽기전용 파일 시스템).  /dev/sr0 has been
opened read-only.
Model: NECVMWar VMware SATA CD00 (scsi)
Disk /dev/sr0: 1020MB
Sector size (logical/physical): 2048B/2048B
Partition Table: msdos
Disk Flags:

Number  Start  End     Size    Type     File system  Flags
 2      909kB  37.0MB  36.0MB  primary

//////////////////drbd 패키지 설치 (node1 , node2 ) 
[root@node2 ~]# rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
[root@node2 ~]# ll
합계 4
-rw-------. 1 root root 1257  7월 27 16:50 anaconda-ks.cfg
[root@node2 ~]# rpm -ivh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm(을)를 복구합니다
http://elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm(을)를 복구합니다
준비 중...                         ################################# [100%]
Updating / installing...
   1:elrepo-release-7.0-4.el7.elrepo  ################################# [100%]
[root@node2 ~]# ll /etc/yum.repos.d/
합계 44
-rw-r--r--. 1 root root 1664 11월 24  2020 CentOS-Base.repo
-rw-r--r--. 1 root root 1309 11월 24  2020 CentOS-CR.repo
-rw-r--r--. 1 root root  649 11월 24  2020 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  630 11월 24  2020 CentOS-Media.repo
-rw-r--r--. 1 root root 1331 11월 24  2020 CentOS-Sources.repo
-rw-r--r--. 1 root root 8515 11월 24  2020 CentOS-Vault.repo
-rw-r--r--. 1 root root  314 11월 24  2020 CentOS-fasttrack.repo
-rw-r--r--. 1 root root  616 11월 24  2020 CentOS-x86_64-kernel.repo
-rw-r--r--. 1 root root 1901  7월 16  2019 elrepo.repo
[root@node2 ~]# yum install -y kmod-drbd84 drbd84-utils
```

- 모듈 로드

```jsx
[root@node1 ~]# lsmod | grep drbd
[root@node1 ~]# modprobe drbd
[root@node1 ~]# lsmod | grep drbd
drbd                  397041  0
libcrc32c              12644  4 xfs,drbd,nf_nat,nf_conntrac

[root@node2 ~]# lsmod | grep drbd
[root@node2 ~]# modprobe drbd
[root@node2 ~]# lsmod | grep drbd
drbd                  397041  0
libcrc32c              12644  4 xfs,drbd,nf_nat,nf_conntrack
[root@node2 ~]#
```

- drbd 설정 ( node1 ,node2 )

```jsx
////etc/drbd.d/global_common.conf 에서 네트워크 프로토콜을 설정한다. 
/// 프로토콜 부분을 찾아서 아래 내용을 추가한다.
[root@node1 ~]# mv /etc/drbd.d/global_common.conf /etc/drbd.d/global_common.conf.org
[root@node1 ~]#
[root@node1 ~]#
[root@node1 ~]# vi /etc/drbd.d/global_common.conf.org

net {
		# protocol timeout max-epoch-size max-buffers
		# connect-int ping-int sndbuf-size rcvbuf-size ko-count
		# allow-two-primaries cram-hmac-alg shared-secret after-sb-0pri
		# after-sb-1pri after-sb-2pri always-asbp rr-conflict
		# ping-timeout data-integrity-alg tcp-cork on-congestion
		# congestion-fill congestion-extents csums-alg verify-alg
		# use-rle
		protocol C;
	}
///양쪽 노두 모두에서, /etc/drbd.d/cluster_disk.res 화일을 생성하고, 아래와 같이 작성한다
[root@node1 ~]# vi /etc/drbd.d/cluster_disk.res
resource disk_drbd {
        on node1 {
                device /dev/drbd0;
                disk /dev/sdb1;
                address 192.168.6.41:7789;
                meta-disk internal;
        }
        on node2 {
                device /dev/drbd0;
                disk /dev/sdb1;
                address 192.168.6.42:7789;
                meta-disk internal;
        }
}
[root@node1 ~]# firewall-cmd --permanent --add-port=7789/tcp
success
[root@node1 ~]# yum install -y heartbeat*
```

- 옵션값
    - resource : 임의의 리소스 이름을 넣으면 된다.
    - protocol : 동기화 방식인데, A는 비동기 방식으로 속도는 빠르나 데이터 손실의 위험이 있다. B는 메모리 까지만 동기화 방식으로 속도가 A보다는 느리지만 꽤빠른편이고 데이터 손실 위험은 A보다 적다. C는 동기 방식으로 primary 에서의 연산이 secondary에서도 완료되어야 작업이 완료되는 방식으로 속도는 제일 느리나 데이터 신뢰성을 높다. 데이터의 안정성은 C가 제일 좋다.
    - on : 노드를 구분한다. hostname을 써주면 된다.
    - device : drbd 논리 디바이스 이름이다. 해당 이름은 임의로 주면 drbd 동작시 해당 이름의 논리 디바이스를 만든다. 전통적으로는 drbd0, drbd1 이런 식으로 이름짓는다.
    - disk : 실제 디바이스 이름을 넣는다.
    - address : ip와 port를 넣는다.
    - meta-disk : drbd 가 동작하기 위한 메타데이터 저장 공간이며 디바이스를 따로 지정할 수 도 있지만 internal로 지정하면 disk 항복에 지정된 실제 디바이스의 공간중 128MB를 이용하여 메타 데이터용으로 쓴다.
- 메타디스크 생성 (매타데이터 블록 생성)

```jsx
[root@node1 ~]# drbdadm create-md disk_drbd                                    
  --==  Thank you for participating in the global usage survey  ==--
The server's response is:

you are the 678300th user to install this version
initializing activity log
initializing bitmap (256 KB) to all zero
Writing meta data...
New drbd meta data block successfully created.
success
[root@node1 ~]#
[root@node2 ~]# drbdadm create-md disk_drbd
--==  Thank you for participating in the global usage survey  ==--
The server's response is:

you are the 678301th user to install this version
initializing activity log
initializing bitmap (256 KB) to all zero
Writing meta data...
New drbd meta data block successfully created.
success
```

- systemctl start drbd
- 상태확인

```jsx
[root@node1 ~]# drbdadm role disk_drbd
Secondary/Secondary
[root@node2 ~]# drbdadm role disk_drbd
Secondary/Secondary // 두 node 가 세컨더리로 되어있음 
[root@node1 ~]# drbdadm status
disk_drbd role:Secondary
  disk:UpToDate
  peer role:Primary
    replication:Established peer-disk:UpToDate
[root@node2 ~]# drbdadm status
disk_drbd role:Primary
  disk:UpToDate
  peer role:Secondary
    replication:Established peer-disk:UpToDate
```

- primary 장비 ( node1 ) 에서 명령 실행

```jsx
[root@node1 ~]# drbdadm primary disk_drbd
[root@node1 ~]# drbdadm role disk_drbd
Secondary/Primary
[root@node1 ~]# drbdadm status
disk_drbd role:Secondary
  disk:UpToDate
  peer role:Primary
    replication:Established peer-disk:UpToDate
```

- secondary 장비 (node2) 에서 실행

```jsx
[root@node2 ~]# drbdadm secondary drbd
[root@node2 ~]# drbdadm role disk_drbd
Primary/Secondary
[root@node2 ~]# drbdadm status
disk_drbd role:Primary
  disk:UpToDate
  peer role:Secondary
    replication:Established peer-disk:UpToDate
```

```jsx
[root@node1 ~]# cp /etc/drbd.d/global_common.conf /etc/drbd.d/global_common.conf.org
[root@node1 ~]#
[root@node1 ~]#
[root@node1 ~]# vi /etc/drbd.d/global_common.conf.org
```

```jsx
pcs resource agents ocf:linbit
```

```jsx
[root@node1 ~]# drbdadm primary disk_drbd
[root@node1 ~]# drbdadm role disk_drbd
Primary/Secondary
[root@node1 ~]# drbdadm status
disk_drbd role:Primary
  disk:UpToDate
  peer role:Secondary
    replication:SyncSource peer-disk:Inconsistent done:84.60

[root@node1 ~]#
[root@node1 ~]#
[root@node1 ~]#
[root@node1 ~]#
[root@node1 ~]#
[root@node1 ~]#
[root@node1 ~]# drbdadm up disk_drbd
Device '0' is configured!
Command 'drbdmeta 0 v08 /dev/sdb internal apply-al' terminated with exit code 20
[root@node1 ~]# drbdadm status
disk_drbd role:Primary
  disk:UpToDate
  peer role:Secondary
    replication:SyncSource peer-disk:Inconsistent done:87.42

[root@node1 ~]# mkfs.xfs -f /dev/drbd0
Discarding blocks...Done.
meta-data=/dev/drbd0             isize=512    agcount=4, agsize=524270 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=2097079, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[root@node1 ~]#
[root@node1 ~]#
[root@node1 ~]#
[root@node1 ~]# parted -l
Model: VMware Virtual disk (scsi)
Disk /dev/sda: 34.4GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  1075MB  1074MB  primary  xfs          boot
 2      1075MB  34.4GB  33.3GB  primary               lvm

Model: VMware Virtual disk (scsi)
Disk /dev/sdb: 8590MB
Sector size (logical/physical): 512B/512B
Partition Table: loop
Disk Flags:

Number  Start  End     Size    File system  Flags
 1      0.00B  8590MB  8590MB  xfs

Model: Linux device-mapper (linear) (dm)
Disk /dev/mapper/centos-swap: 3435MB
Sector size (logical/physical): 512B/512B
Partition Table: loop
Disk Flags:

Number  Start  End     Size    File system     Flags
 1      0.00B  3435MB  3435MB  linux-swap(v1)

Model: Linux device-mapper (linear) (dm)
Disk /dev/mapper/centos-root: 29.8GB
Sector size (logical/physical): 512B/512B
Partition Table: loop
Disk Flags:

Number  Start  End     Size    File system  Flags
 1      0.00B  29.8GB  29.8GB  xfs

Warning: Unable to open /dev/sr0 read-write (Read-only file system).  /dev/sr0
has been opened read-only.
Model: NECVMWar VMware SATA CD00 (scsi)
Disk /dev/sr0: 1020MB
Sector size (logical/physical): 2048B/2048B
Partition Table: msdos
Disk Flags:

Number  Start  End     Size    Type     File system  Flags
 2      909kB  37.0MB  36.0MB  primary

Model: Unknown (unknown)
Disk /dev/drbd0: 8590MB
Sector size (logical/physical): 512B/512B
Partition Table: loop
Disk Flags:

Number  Start  End     Size    File system  Flags
 1      0.00B  8590MB  8590MB  xfs

[root@node1 ~]# mount /dev/drbd0 /mnt
[root@node1 ~]# drbdadm status
disk_drbd role:Primary
  disk:UpToDate
  peer role:Secondary
    replication:Established peer-disk:UpToDate
```

동기화 확인 

```jsx
[root@node1 ~]# cat /proc/drbd
version: 8.4.11-1 (api:1/proto:86-101)
GIT-hash: 66145a308421e9c124ec391a7848ac20203bb03c build by mockbuild@, 2020-04-05 02:58:18
 0: cs:Connected ro:Primary/Secondary ds:UpToDate/UpToDate C r-----
    ns:1204982 nr:0 dw:8400954 dr:1197783 al:34 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:0
[root@node1 ~]#
```

- failover 노드 1 다운

```jsx
[root@node1 /]# mount /dev/drbd0 /mnt
[root@node1 /]# cd /mnt/
[root@node1 mnt]# touch test1
[root@node1 mnt]# touch test2
[root@node1 mnt]# touch test3
[root@node1 mnt]# touch test4
[root@node1 mnt]# ll
total 0
-rw-r--r--. 1 root root 0 Jul 29 16:12 test
-rw-r--r--. 1 root root 0 Jul 29 16:26 test1
-rw-r--r--. 1 root root 0 Jul 29 16:26 test2
-rw-r--r--. 1 root root 0 Jul 29 16:26 test3
-rw-r--r--. 1 root root 0 Jul 29 16:26 test4
[root@node1 ~]# init 0
```

```jsx
[root@node2 ~]# drbdadm primary disk_drbd
[root@node2 ~]# drbdadm status disk_drbd
disk_drbd role:Primary
  disk:UpToDate
  peer connection:Connecting

[root@node2 ~]# mount /dev/dr
drbd/  drbd0  dri/
[root@node2 ~]# mount /dev/drbd0 /mnt
[root@node2 ~]# ll /mnt/
합계 0
-rw-r--r--. 1 root root 0  7월 29 16:12 test
-rw-r--r--. 1 root root 0  7월 29 16:26 test1
-rw-r--r--. 1 root root 0  7월 29 16:26 test2
-rw-r--r--. 1 root root 0  7월 29 16:26 test3
-rw-r--r--. 1 root root 0  7월 29 16:26 test4
[root@node2 ~]#
```

- 장애원복

```jsx
[root@node2 ~]# umount /mnt

[root@node1 /]# drbdadm primary disk_drbd
[root@node1 /]# drbdadm role disk_drbd
Primary/Secondary
[root@node1 /]# cat /proc/drbd
version: 8.4.11-1 (api:1/proto:86-101)
GIT-hash: 66145a308421e9c124ec391a7848ac20203bb03c build by mockbuild@, 2020-04-05 02:58:18
 0: cs:Connected ro:Primary/Secondary ds:UpToDate/UpToDate C r-----
    ns:0 nr:0 dw:0 dr:2128 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:0
[root@node1 /]# drbdadm status disk_drbd
disk_drbd role:Primary
  disk:UpToDate
  peer role:Secondary
    replication:Established peer-disk:UpToDate
[root@node1 /]# mount /dev/drbd0 /mnt
[root@node1 /]# cd /mnt/
[root@node1 mnt]# touch test1
[root@node1 mnt]# touch test2
[root@node1 mnt]# touch test3
[root@node1 mnt]# touch test4
[root@node1 mnt]# ll

[root@node2 ~]# drbdadm secondary disk_drbd
[root@node2 ~]# drbdadm status
disk_drbd role:Secondary
  disk:UpToDate
  peer role:Secondary
    replication:Established peer-disk:UpToDate

[root@node2 ~]#
```

리소스 생성 /// 마스터 노드에서만

```jsx
// drbd 리소스를 클러스터에 통합하기 위해서 아래 명령어를 실행한다. push 하기 전까지는 현 디렉토리에 drbd_cfg 파일에 저장된다. cib(Cluster Information Base) 옵션은 cib로부터 raw xml화일을 생성한다.
# pcs cluster cib drbd_cfg  

// Drbd Data 리소스를 생성한다.
# pcs -f drbd_cfg resource create Data ocf:linbit:drbd drbd_resource=disk_drbd op monitor timeout="30s" interval="20s" role="Slave" op monitor timeout="30s" interval="10s" role="Master"
// Drbd Clone 리소스를 생성한다.
# pcs -f drbd_cfg resource master DataSync Data master-max=1 master-node-max=1 clone-max=2 clone-node-max=1 notify=true

# pcs -f drbd_cfg resource create storage Filesystem device="/dev/drbd0" directory="/mnt" fstype="xfs"

이제 작성한 cib를 라이브 CIB로 push한다
# pcs cluster cib-push drbd_cfg
CIB updated
```