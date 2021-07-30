# ha cluster 실습

[pacemaker 명령어 정리](ha%20cluster%20%E1%84%89%E1%85%B5%E1%86%AF%E1%84%89%E1%85%B3%E1%86%B8%20f3d2721c73d64dda9cd8ffd72905ac4a/pacemaker%20%E1%84%86%E1%85%A7%E1%86%BC%E1%84%85%E1%85%A7%E1%86%BC%E1%84%8B%E1%85%A5%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%85%E1%85%B5%20c1f9c445dc944345a6cacbe23dbf3f48.md)

구성 환경* 

- 노드1호스트네임 :

worker1 ip주소 : 192.168.100.31(eth1), 172.16.1.31(eth0)

OS : CentOS 7 minimal version

- 노드2호스트네임 :

worker2 2ip주소 : 192.168.100.32(eth1), 172.16.1.32(eth0)

OS : CentOS 7 minimal version

- 가상 IP주소 : 192.168.100.30 (eth0)

corosync 2.4, 

pacemaker 1.1.15OS 

disk : vda

Shared disk : vdb

```jsx
/// 설치전 양쪽 노드 etc/hosts 파일에 각 노드 등록 //
vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.222.31  worker1
192.168.222.32  worker2
192.168.222.30  worker
/// 두개 노드 동일하게 설정 // 
[root@worker1 ~]# yum install -y pacemaker corosync pcs psmisc policycoreutils-python // corosync, pacemaker 설치(양쪽 노드)
[root@worker1 ~]# systemctl start pcsd.service 
[root@worker1 ~]# systemctl enable pcsd.service

// 클러스터 계정 설정 // 
[root@worker1 ~]# passwd hacluster
Changing password for user hacluster.
New password:
Retype new password:
passwd: all authentication tokens updated successfully.

// hacluster 를 클러스터의 각 노드에 대한 인증 /// 

[root@worker1 ~]# pcs cluster auth worker1 worker2
Username: hacluster
Password:
worker1: Authorized
Error: Unable to communicate with worker2
// 에러 발생 // 
```

![ha%20cluster%20%E1%84%89%E1%85%B5%E1%86%AF%E1%84%89%E1%85%B3%E1%86%B8%20f3d2721c73d64dda9cd8ffd72905ac4a/Untitled.png](ha%20cluster%20%E1%84%89%E1%85%B5%E1%86%AF%E1%84%89%E1%85%B3%E1%86%B8%20f3d2721c73d64dda9cd8ffd72905ac4a/Untitled.png)

```jsx

// 방화벽 설정 //
firewall-cmd --permanent --add-service=high-availability
firewall-cmd --zone=public --permanent --add-port=2224/tcp
firewall-cmd --zone=public --permanent --add-port=3121/tcp
firewall-cmd --zone=public --permanent --add-port=5403/tcp
firewall-cmd --zone=public --permanent --add-port=21064/tcp
firewall-cmd --zone=public --permanent --add-port=9929/tcp
firewall-cmd --zone=public --permanent --add-port=9929/udp
firewall-cmd --zone=public --permanent --add-port=5405/udp
firewall-cmd --zone=public --permanent --add-port=5404/udp
firewall-cmd --reload
firewall-cmd --zone=public --list-all

   10  systemctl enable pcsd.service
   11  systemctl status pcsd.service
   12  passwd hacluster
   13  pcs cluster auth worker1 worker2

Jul 26 19:40:50 worker1 systemd[1]: Stopped firewalld - dynamic firewall daemon.
Jul 26 19:40:50 worker1 systemd[1]: Starting firewalld - dynamic firewall daemon...
Jul 26 19:40:50 worker1 systemd[1]: Started firewalld - dynamic firewall daemon.
Jul 26 19:40:50 worker1 firewalld[8319]: WARNING: AllowZoneDrifting is enabled. This is considered an insecure configuration option. It will be ...g it now.
Jul 26 23:21:32 worker1 systemd[1]: Current command vanished from the unit file, execution of the command list won't be resumed.
Hint: Some lines were ellipsized, use -l to show in full.

[root@worker1 ~]# firewall-cmd --zone=public --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: ens33 ens37
  sources:
  services: dhcpv6-client ssh
  ports: 2224/tcp 3121/tcp 5403/tcp 21064/tcp 9929/tcp 9929/udp 5405/udp 5404/udp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

[root@worker1 ~]#
[root@worker1 ~]#
[root@worker1 ~]#
[root@worker1 ~]# pcs cluster auth worker1 worker2
Username: hacluster
Password:
worker1: Authorized
worker2: Authorized
// 클러스터 생성 // 
[root@worker1 ~]# pcs cluster setup --name baek_cluster worker1 worker2
Destroying cluster on nodes: worker1, worker2...
worker1: Stopping Cluster (pacemaker)...
worker2: Stopping Cluster (pacemaker)...
worker1: Successfully destroyed cluster
worker2: Successfully destroyed cluster

Sending 'pacemaker_remote authkey' to 'worker1', 'worker2'
worker1: successful distribution of the file 'pacemaker_remote authkey'
worker2: successful distribution of the file 'pacemaker_remote authkey'
Sending cluster config files to the nodes...
worker1: Succeeded
worker2: Succeeded

Synchronizing pcsd certificates on nodes worker1, worker2...
worker1: Success
worker2: Success
Restarting pcsd on the nodes in order to reload the certificates...
worker1: Success
worker2: Success
[root@worker1 ~]#
[root@worker1 ~]#
[root@worker1 ~]#
// 클러스터 실행 // 
[root@worker1 ~]# pcs cluster start --all
worker1: Starting Cluster (corosync)...
worker2: Starting Cluster (corosync)...
worker1: Starting Cluster (pacemaker)...
worker2: Starting Cluster (pacemaker)...

[root@worker1 ~]# systemctl enable corosync
[root@worker1 ~]# systemctl enable pacemaker
[root@worker1 ~]# corosync-cfgtool -s // 멤버쉽과 퀴럼을 확인
Printing ring status.
Local node ID 1
RING ID 0
        id      = 192.168.222.31
        status  = ring 0 active with no faults
[root@worker1 ~]# corosync-cmapctl | egrep -i members // corosync 상태확인
runtime.totem.pg.mrp.srp.members.1.config_version (u64) = 0
runtime.totem.pg.mrp.srp.members.1.ip (str) = r(0) ip(192.168.222.31)
runtime.totem.pg.mrp.srp.members.1.join_count (u32) = 1
runtime.totem.pg.mrp.srp.members.1.status (str) = joined
runtime.totem.pg.mrp.srp.members.2.config_version (u64) = 0
runtime.totem.pg.mrp.srp.members.2.ip (str) = r(0) ip(192.168.222.32)
runtime.totem.pg.mrp.srp.members.2.join_count (u32) = 1
runtime.totem.pg.mrp.srp.members.2.status (str) = joined
[root@worker1 ~]# pcs status corosync// 클러스터 상태 확인

Membership information
----------------------
    Nodeid      Votes Name
         1          1 worker1 (local)
         2          1 worker2
[root@worker1 ~]# pcs status
Cluster name: baek_cluster

WARNINGS:
No stonith devices and stonith-enabled is not false

Stack: corosync
Current DC: worker1 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Mon Jul 26 23:53:07 2021
Last change: Mon Jul 26 23:41:32 2021 by hacluster via crmd on worker1

2 nodes configured
0 resource instances configured

Online: [ worker1 worker2 ]

No resources

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
  pcsd: active/enabled
[root@worker1 ~]#
```

6. Active/Passive 클러스터 생성

클러스터 설정을 변경하기 전에 아래처럼 crm_verify 명령어로 유효성을 확인해 두는 것이 좋다. STONITH 부분에서 오류가 발생한다.

```jsx
[root@worker1 ~]# crm_verify -L -V
   error: unpack_resources:     Resource start-up disabled since no STONITH resources have been defined
   error: unpack_resources:     Either configure some or disable STONITH with the stonith-enabled option
   error: unpack_resources:     NOTE: Clusters with shared data need STONITH to ensure data integrity
Errors found during check: config not valid
[root@worker1 ~]# pcs property set stonith-enabled=false
[root@worker1 ~]# crm_verify -L
[root@worker1 ~]# crm_verify -L -V
```

데이타의 무결성을 확보하기 위해 기본으로 STONITH가 활성화되어 있는데 이것을 비활성하고 다시 확인해보면 아무런 오류가 발생하지 않는다.

```jsx
**# pcs property set stonith-enabled=false**

**# crm_verify -L**
```

가상 IP 리소스 생성아래 명령어로 가상아이피를 리소스로 추가한다. 가상아이피는 노드가 다운되면 다른 노드로 이동하며, 실제로 서비스에 이용되는 IP 주소로 이용한다.

```jsx
[root@worker1 ~]# pcs resource create VirtualIP ocf:heartbeat:IPaddr2 ip=192.168.222.30 cidr_netmask=24 op monitor interval=30s
```

```jsx
[root@worker1 ~]# pcs status
Cluster name: baek_cluster
Stack: corosync
Current DC: worker1 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Mon Jul 26 23:57:01 2021
Last change: Mon Jul 26 23:56:14 2021 by root via cibadmin on worker1

2 nodes configured
1 resource instance configured

Online: [ worker1 worker2 ]

Full list of resources:

 VirtualIP      (ocf::heartbeat:IPaddr2):       Started worker1

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
  pcsd: active/enabled

[root@worker1 ~]# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:97:66:6e brd ff:ff:ff:ff:ff:ff
    inet 192.168.222.31/24 brd 192.168.222.255 scope global noprefixroute ens33
       valid_lft forever preferred_lft forever
    inet 192.168.222.30/24 brd 192.168.222.255 scope global secondary ens33
       valid_lft forever preferred_lft forever
    inet6 fe80::e036:8c9c:dc4:836a/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
3: ens37: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:97:66:78 brd ff:ff:ff:ff:ff:ff
    inet 172.16.1.31/24 brd 172.16.1.255 scope global noprefixroute ens37
       valid_lft forever preferred_lft forever
    inet6 fe80::db36:7897:cc06:37cd/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
[root@worker1 ~]#

```

위에서 추가한 리소스 VirtualIP는 세 부분 ocf:heartbeat:IPaddr2 의 형태로 구분했다. 여기에서, 첫번째 필드는 resource standard 두번째 필드는 표준에 따라 다르며 세번째 필드는 리소스 스크립트의 이름이다.리소스 standard는 다음 명령어로 확인 가능하다.

```jsx
**# pcs resource standards**

**ocf**

**lsb**

**service**

**systemd**
```

위 결과에서 각각의 의미는 다음과 같다.

```jsx
ocf – Open cluster Framework
lsb – Linux standard base (보통 init scripts)
service – Based on Linux “service” command.
systemd – systemd based service Management
stonith – Fencing Resource standard.
```

두번째 필드인 ocf의 리소스 프로바이더는 아래 커맨드로 확인가능하다

```jsx
# pcs resource providers

heartbeat

openstack

pacemaker
세번째 필드인 리소스 스크립트는 아래처럼 확인 가능하다.
```

```jsx

# pcs resource agents ocf:heartbeat
CTDB
Delay
Dummy
Filesystem
IPaddr
IPaddr2
IPsrcaddr
LVM
MailTo
Route
SendArp
Squid
VirtualDomain
Xinetd
apache
clvm
conntrackd
db2
dhcpd
docker
ethmonitor
exportfs
galera
garbd
iSCSILogicalUnit
iSCSITarget
iface-vlan
mysql
nagios
named
nfsnotify
nfsserver
nginx
oracle
oralsnr
pgsql
portblock
postfix
rabbitmq-cluster
redis
rsyncd
slapd
symlink
tomcat
```

이제, worker1 을 정지시켜 failover를 확인해본다.

```jsx
[root@worker1 ~]# pcs cluster stop worker1
worker1: Stopping Cluster (pacemaker)...
worker1: Stopping Cluster (corosync)...
[root@worker1 ~]# pcs status
Error: cluster is not currently running on this node
[root@worker1 ~]#
[root@worker1 ~]#
[root@worker1 ~]#

[root@worker1 ~]# pcs cluster start worker1
worker1: Starting Cluster (corosync)...
worker1: Starting Cluster (pacemaker)...
[root@worker2 ~]# ip addr // worker 2 에서 확인시 넘어옴
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:66:49:76 brd ff:ff:ff:ff:ff:ff
    inet 192.168.222.32/24 brd 192.168.222.255 scope global noprefixroute ens33
       valid_lft forever preferred_lft forever
    inet 192.168.222.30/24 brd 192.168.222.255 scope global secondary ens33
       valid_lft forever preferred_lft forever
    inet6 fe80::4f63:af36:2c04:88c0/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
3: ens37: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:66:49:80 brd ff:ff:ff:ff:ff:ff
    inet 172.16.1.32/24 brd 172.16.1.255 scope global noprefixroute ens37
       valid_lft forever preferred_lft forever
    inet6 fe80::7b2d:83d5:d04f:71ef/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
[root@worker2 ~]# pcs status
Cluster name: baek_cluster
Stack: corosync
Current DC: worker2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Mon Jul 26 23:59:30 2021
Last change: Mon Jul 26 23:56:14 2021 by root via cibadmin on worker1

2 nodes configured
1 resource instance configured

Online: [ worker2 ]
OFFLINE: [ worker1 ]

Full list of resources:

 VirtualIP      (ocf::heartbeat:IPaddr2):       Started worker2

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
  pcsd: active/enabled
[root@worker2 ~]#

/////
[root@worker1 ~]# pcs status
Cluster name: baek_cluster
Stack: corosync
Current DC: worker2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Tue Jul 27 00:04:44 2021
Last change: Mon Jul 26 23:56:14 2021 by root via cibadmin on worker1

2 nodes configured
1 resource instance configured

Online: [ worker1 worker2 ]

Full list of resources:

 VirtualIP      (ocf::heartbeat:IPaddr2):       Started worker2

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
  pcsd: active/enabled
[root@worker1 ~]# ip add
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:97:66:6e brd ff:ff:ff:ff:ff:ff
    inet 192.168.222.31/24 brd 192.168.222.255 scope global noprefixroute ens33
       valid_lft forever preferred_lft forever
    inet6 fe80::e036:8c9c:dc4:836a/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
3: ens37: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:97:66:78 brd ff:ff:ff:ff:ff:ff
    inet 172.16.1.31/24 brd 172.16.1.255 scope global noprefixroute ens37
       valid_lft forever preferred_lft forever
    inet6 fe80::db36:7897:cc06:37cd/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
[root@worker1 ~]#
```

worker 1에서 클러스터를 다시 실행해도, 리소스는 wolf1으로 돌아오지 않는다.

resource stickniess – 자원의 이동에는 대부분 가동중지 시간이 필요하며, 데이타베이스처럼 복잡한 서비스는 이 시간이 길어질 수 있다. 이 문제를 해결하기위해서 pacemaker에서 제공하는 개념이 리소스 stickiness. 기본값은 0 이지만, 이 숫자를 늘여서 서비스가 이동하는 것을 제어할 수 있다.

```jsx
[root@worker1 ~]# pcs resource defaults
No defaults set
[root@worker1 ~]# pcs resource defaults resource-stickiness=60
Warning: Defaults do not apply to resources which override them with their own defined values
[root@worker1 ~]# pcs resource defaults
resource-stickiness=60
[root@worker1 ~]#
// 클러스터 서비스로 아파치 웹서버 등록하기
// 설치는 양쪽 노드에 아래 커맨드로 설치한다. wget은 서비스 상태를 모니터링하기 위해 설치한다.
[root@worker1 ~]# yum install httpd wget
[root@worker1 ~]# ssh root@192.168.222.32 yum install -y httpd wget
The authenticity of host '192.168.222.32 (192.168.222.32)' can't be established.
ECDSA key fingerprint is SHA256:jgLLhGbv4UjJ3YzPfb4Kn6u5q+6poVJE3I4oubginwE.
ECDSA key fingerprint is MD5:e6:e3:29:79:a2:dc:d0:9c:33:7b:6b:2c:62:fa:ba:a8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.222.32' (ECDSA) to the list of known hosts.
root@192.168.222.32's password:
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.navercorp.com
 * extras: mirror.navercorp.com
 * updates: ftp.kaist.ac.kr
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-97.el7.centos will be installed
--> Processing Dependency: httpd-tools = 2.4.6-97.el7.centos for package: httpd-2                                                                           .4.6-97.el7.centos.x86_64
--> Processing Dependency: /etc/mime.types for package: httpd-2.4.6-97.el7.centos                                                                           .x86_64
--> Processing Dependency: libaprutil-1.so.0()(64bit) for package: httpd-2.4.6-97                                                                           .el7.centos.x86_64
--> Processing Dependency: libapr-1.so.0()(64bit) for package: httpd-2.4.6-97.el7                                                                           .centos.x86_64
---> Package wget.x86_64 0:1.14-18.el7_6.1 will be installed
--> Running transaction check
---> Package apr.x86_64 0:1.4.8-7.el7 will be installed
---> Package apr-util.x86_64 0:1.5.2-6.el7 will be installed
---> Package httpd-tools.x86_64 0:2.4.6-97.el7.centos will be installed
---> Package mailcap.noarch 0:2.1.41-2.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package           Arch         Version                     Repository     Size
================================================================================
Installing:
 httpd             x86_64       2.4.6-97.el7.centos         updates       2.7 M
 wget              x86_64       1.14-18.el7_6.1             base          547 k
Installing for dependencies:
 apr               x86_64       1.4.8-7.el7                 base          104 k
 apr-util          x86_64       1.5.2-6.el7                 base           92 k
 httpd-tools       x86_64       2.4.6-97.el7.centos         updates        93 k
 mailcap           noarch       2.1.41-2.el7                base           31 k

Transaction Summary
================================================================================
Install  2 Packages (+4 Dependent packages)

Total download size: 3.6 M
Installed size: 12 M
Downloading packages:
--------------------------------------------------------------------------------
Total                                              8.8 MB/s | 3.6 MB  00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : apr-1.4.8-7.el7.x86_64                                       1/6
  Installing : apr-util-1.5.2-6.el7.x86_64                                  2/6
  Installing : httpd-tools-2.4.6-97.el7.centos.x86_64                       3/6
  Installing : mailcap-2.1.41-2.el7.noarch                                  4/6
  Installing : httpd-2.4.6-97.el7.centos.x86_64                             5/6
  Installing : wget-1.14-18.el7_6.1.x86_64                                  6/6
  Verifying  : mailcap-2.1.41-2.el7.noarch                                  1/6
  Verifying  : apr-1.4.8-7.el7.x86_64                                       2/6
  Verifying  : apr-util-1.5.2-6.el7.x86_64                                  3/6
  Verifying  : httpd-2.4.6-97.el7.centos.x86_64                             4/6
  Verifying  : httpd-tools-2.4.6-97.el7.centos.x86_64                       5/6
  Verifying  : wget-1.14-18.el7_6.1.x86_64                                  6/6

Installed:
  httpd.x86_64 0:2.4.6-97.el7.centos        wget.x86_64 0:1.14-18.el7_6.1

Dependency Installed:
  apr.x86_64 0:1.4.8-7.el7                     apr-util.x86_64 0:1.5.2-6.el7
  httpd-tools.x86_64 0:2.4.6-97.el7.centos     mailcap.noarch 0:2.1.41-2.el7

Complete!
[root@worker1 ~]#
```

```jsx
// 설치를 마친후 /var/www/html/index.html 화일을 만든다.
// /etc/httpd/conf.d/status.conf 화일에 아래 내용을 입력한다(양쪽 노드 모두).
[root@worker1 ~]# vi /etc/httpd/conf.d/
autoindex.conf  README          status.conf     userdir.conf    welcome.conf
[root@worker1 ~]# cat /etc/httpd/conf.d/status.conf
 <Location /server-status>
    SetHandler server-status
    Require local
 </Location>
[root@worker1 ~]# touch /var/www/html/index.html
[root@worker1 ~]# vi /var/www/html/index.html
[root@worker1 ~]# cat /var/www/html/index.html
<p> hello world <p>
[root@worker1 ~]#
[root@worker1 ~]#

// 리소스 등록 및 확인 .
[root@worker1 ~]# pcs resource create WebService ocf:heartbeat:apache configfile=/etc/httpd/conf/httpd.conf statusurl="http://localhost/server-status" op monitor interval=1min
[root@worker1 ~]# pcs resource op defaults
No defaults set
[root@worker1 ~]# pcs resource op defaults timeout=60s
Warning: Defaults do not apply to resources which override them with their own defined values
[root@worker1 ~]# pcs resource op defaults
timeout=60s
[root@worker1 ~]# pcs status
Cluster name: baek_cluster
Stack: corosync
Current DC: worker2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Tue Jul 27 00:15:02 2021
Last change: Tue Jul 27 00:14:54 2021 by root via cibadmin on worker1

2 nodes configured
2 resource instances configured

Online: [ worker1 worker2 ]

Full list of resources:

 VirtualIP      (ocf::heartbeat:IPaddr2):       Started worker2
 WebService     (ocf::heartbeat:apache):        Started worker1

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
```

위의 상태를 보면, 가상ip주소는 worker2 에, 웹서비스는 worker1 에서 실행되고 있음을 볼 수 있다. 이 문제는 colocation constraint 두 리소스를 묶어줌으로써 해결된다.

```jsx
[root@worker1 ~]# pcs constraint
Location Constraints:
Ordering Constraints:
Colocation Constraints:
Ticket Constraints:
[root@worker1 ~]# pcs constraint colocation add WebService with VirtualIP INFINITY
[root@worker1 ~]# pcs constraint
Location Constraints:
Ordering Constraints:
Colocation Constraints:
  WebService with VirtualIP (score:INFINITY)
Ticket Constraints:
[root@worker1 ~]# pcs status
Cluster name: baek_cluster
Stack: corosync
Current DC: worker2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Tue Jul 27 00:17:25 2021
Last change: Tue Jul 27 00:17:06 2021 by root via cibadmin on worker1

2 nodes configured
2 resource instances configured

Online: [ worker1 worker2 ]

Full list of resources:

 VirtualIP      (ocf::heartbeat:IPaddr2):       Started worker2
 WebService     (ocf::heartbeat:apache):        Started worker2

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
  pcsd: active/enabled
[root@worker1 ~]#
```

이제 확인해보면 두 리소스 VirtualIP, WebService가 같은 노드에서 실행되고 있음을 볼 수 있다.

만약 어떤 서비스가 먼저 실행되고 난 이후 서비스가 실행되어야 할 필요가 있을때는 아래와 같은 방법을 사용한다. 아래는 VirtualIP가 먼저 실행된 후 WebService가 실행되도록 한다.

```jsx
[root@worker2 ~]# pcs constraint
Location Constraints:
Ordering Constraints:
Colocation Constraints:
  WebService with VirtualIP (score:INFINITY)
Ticket Constraints:
[root@worker2 ~]# pcs constraint order VirtualIP then WebService
Adding VirtualIP WebService (kind: Mandatory) (Options: first-action=start then-action=start)
[root@worker2 ~]# pcs constraint
Location Constraints:
Ordering Constraints:
  start VirtualIP then start WebService (kind:Mandatory)
Colocation Constraints:
  WebService with VirtualIP (score:INFINITY)
Ticket Constraints:
[root@worker2 ~]#
```

Pacemaker는 두 노드의 하드웨어사양이 동일할 필요가 없기 때문에, 보다 강력한 노드에서 서비스를 실행하도록 하는 것이 가능하다. 이는 constraint location을 지정함으로써 가능하다.

```jsx
[root@worker2 ~]# pcs constraint location WebService prefers worker2=50
[root@worker2 ~]# pcs constraint
Location Constraints:
  Resource: WebService
    Enabled on: worker2 (score:50)
Ordering Constraints:
  start VirtualIP then start WebService (kind:Mandatory)
Colocation Constraints:
  WebService with VirtualIP (score:INFINITY)
Ticket Constraints:
[root@worker2 ~]#
```

수동으로 리소스 강제 이동하기

리소스를 강제로 다른 노드로 이동하기 위해서는 constraint location의 스코어를 INFINITY로 변경하면된다. 아래는 WebService 리소스를 wolf2 노드로 강제 이동하는 명령어이다.

```jsx
Location Constraints:
  Resource: WebService
    Enabled on: worker2 (score:50)
Ordering Constraints:
  start VirtualIP then start WebService (kind:Mandatory)
Colocation Constraints:
  WebService with VirtualIP (score:INFINITY)
Ticket Constraints:
[root@worker2 ~]# pcs constraint location WebService prefers worker2=INFINITY
[root@worker2 ~]# pcs constraint
Location Constraints:
  Resource: WebService
    Enabled on: worker2 (score:INFINITY)
Ordering Constraints:
  start VirtualIP then start WebService (kind:Mandatory)
Colocation Constraints:
  WebService with VirtualIP (score:INFINITY)
Ticket Constraints:
[root@worker2 ~]# pcs status
Cluster name: baek_cluster
Stack: corosync
Current DC: worker2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Tue Jul 27 00:25:19 2021
Last change: Tue Jul 27 00:24:27 2021 by root via cibadmin on worker2

2 nodes configured
2 resource instances configured

Online: [ worker1 worker2 ]

Full list of resources:

 VirtualIP      (ocf::heartbeat:IPaddr2):       Started worker2
 WebService     (ocf::heartbeat:apache):        Started worker2

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
  pcsd: active/enabled
```

constraint location 삭제는 아래와 같이 할 수 있다.

현재의 constraint를 확인하고,

```jsx
# pcs constraint
Location Constraints:
  Resource: WebService
    Enabled on: wolf1 (score:INFINITY)
    Disabled on: wolf2 (score:-INFINITY)
Ordering Constraints:
  start VirtualIP then start WebService (kind:Mandatory)
Colocation Constraints:
  WebService with VirtualIP (score:INFINITY)
```

id를 확인하고, remove 한다.

```jsx
# pcs constraint --full
Location Constraints:
  Resource: WebService
    Enabled on: wolf1 (score:INFINITY) (id:location-WebService-wolf1-INFINITY)
    Disabled on: wolf2 (score:-INFINITY) (id:location-WebService-wolf2--INFINITY)
Ordering Constraints:
  start VirtualIP then start WebService (kind:Mandatory) (id:order-VirtualIP-WebService-mandatory)
Colocation Constraints:
  WebService with VirtualIP (score:INFINITY) (id:colocation-WebService-VirtualIP-INFINITY)
Ticket Constraints:
 
# pcs constraint remove location-WebService-wolf2--INFINITY
```

pcs status : 현재 구성된 cluster 상태를 확인합니다.

pcs cluster start -–all : pcsd 데몬을 통하여 모든 node에 pacemaker와 corosync를 기동하여 줍니다.

- pcs cluster start 는 해당 명령어를 입력하는 node에만 pacemaker와 corosync를 기동합니다.

pcs cluster stop -–all : pcsd 데몬을 통하여 모든 node에 pacemaker와 corosync를 정지

[Chapter 3. The pcs Command Line Interface Red Hat Enterprise Linux 7 | Red Hat Customer Portal](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/high_availability_add-on_reference/ch-pcscommand-haar)

[root@worker1 ~]# pcs constraint
Location Constraints:
Ordering Constraints:
Colocation Constraints:
Ticket Constraints:
[root@worker1 ~]# pcs constraint colocation add WebService with VirtualIP INFINITY
[root@worker1 ~]# pcs constraint
Location Constraints:
Ordering Constraints:
Colocation Constraints:
WebService with VirtualIP (score:INFINITY)
Ticket Constraints:
[root@worker1 ~]# pcs status
Cluster name: baek_cluster
Stack: corosync
Current DC: worker2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Tue Jul 27 00:17:25 2021
Last change: Tue Jul 27 00:17:06 2021 by root via cibadmin on worker1

2 nodes configured
2 resource instances configured

Online: [ worker1 worker2 ]

Full list of resources:

VirtualIP      (ocf::heartbeat:IPaddr2):       Started worker2
WebService     (ocf::heartbeat:apache):        Started worker2

Daemon Status:
corosync: active/disabled
pacemaker: active/disabled
pcsd: active/enabled
[root@worker1 ~]#

## 아파치 실행 안될때

```jsx
/bin/sed -i '/s/RUNDIR\/${httpd_basename}.pid/RUNDIR\/${httpd_basename}\/${httpd_basename}.pid/g' /usr/lib/ocf/lib/heartbeat/apache-conf.sh
```

/