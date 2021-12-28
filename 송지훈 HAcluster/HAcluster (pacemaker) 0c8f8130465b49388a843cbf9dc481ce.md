# HAcluster (pacemaker)

## **[HA란?](https://honglab.tistory.com/126#HA%EB%-E%--%-F)**

- **High Availability (고가용성)**
- 즉 애플리케이션의 다운타임을 최소화하는 것이다
- 이를 구현하려면 2개 이상의 호스트들을 묶어서(Clustering) 하나의 호스트가 죽을 시 다른 호스트가 그 역할을 대신 이어나가야 한다
- 즉 [이중화 구성](https://run-it.tistory.com/41)을 하는 것
- 윈도우같은 경우는 MSCS를 통해 GUI로 구현 가능

    ![HAcluster%20(pacemaker)%200c8f8130465b49388a843cbf9dc481ce/Snap22-1.jpg](HAcluster%20(pacemaker)%200c8f8130465b49388a843cbf9dc481ce/Snap22-1.jpg)

## **[Pacemaker란?](https://honglab.tistory.com/126#Pacemaker%EB%-E%--%-F)**

- 리눅스의 이중화 도구
- 오픈소스 **HA Cluster Resource Manager**
- 즉, 여러 대의 호스트들을 Cluster로 묶고 그 호스트들의 자원을 관리한다
- 클러스터 용어에서 서비스는 리소스 이다

## 주요기능

- 노드 및 서비스 수준 장애 감지 및 복구

- 공유 스토리지에 대한 요구 사항 없음(어떠한 스토리지도 사용 가능)

- resource에 의존하지 않고 스크립팅 할 수 있는 모든 것을 클러스터링 가능

- 데이터 무결성 보장을 위한 펜싱 지원(Pacemaker에서는 STONITH라는 용어로 사용)

- 크고 작은 클러스터 지원(2 node 이상)

- Quorate, Resource-dirven 클러스터 모두 지원

- 모든 중복 구성 지원

- 모든 노드에서 변경된 설정 자동 업데이트

- 클러스터 전체의 서비스 순서, colocation 및 anti-colocation 지정 가능

- 고급 서비스 유형 지원

- Clones: 여러 노드에서 활성화 되어야 하는 서비스

- Multi-state: 여러 모드(ex. Master/ Slave, Primary/Secondary)가 있는 서비스의 경우

- Unified, Scriptable 가능한 클러스터 관리 도구

## **[Pacemaker의 내부 구성 요소](https://honglab.tistory.com/126#Pacemaker%EC%-D%--%--%EB%--%B-%EB%B-%--%--%EA%B-%AC%EC%--%B-%--%EC%-A%--%EC%--%-C)**

![https://blog.kakaocdn.net/dn/cy5oEB/btq2krn8SDb/beREUklSVGOkV6wHEeiQV0/img.png](https://blog.kakaocdn.net/dn/cy5oEB/btq2krn8SDb/beREUklSVGOkV6wHEeiQV0/img.png)

- **CRMd (Cluster Resource Management daemon)**
    - main controlling process
    - 모든 리소스 작업 라우팅

- **CIB (Cluster Information Base)**
    - 설정 정보 관리 데몬 - XML 파일로 설정

- **PEngine (PE, Policy Engine)**
    - 현재 클러스터 상태 및 구성을 기반으로 다음 상태 결정

- **LRMd (Local Resource Management daemon)**
    - CRMd와 각 리소스 사이의 인터페이스 역할 / CRMd의 명령을 agent에 전달
    - CRM이 수행되어 보고된 결과에 따라 start/stop/monitor 동작

- **STONITHd (Shoot The Other Node In The Head daemon)**
    - 그대로 번역한다면 **"다른 노드의 머리를 쏜다"**
    - 즉, 오류가 발생한 호스트(노드)나 리소스를 비활성화 시키는 **Fencing 기능** 수행
    - 다른 노드의 서비스 이상이나 Power-off 등이 감지되면 해당 노드나 서비스를 재시작한다
    - 서비스가 중복으로 실행되어 충돌나는것을 방지

![https://blog.kakaocdn.net/dn/dJ5rOO/btq2gXWrqGv/ktqqklEMr3NQ3cHmsfwfHk/img.png](https://blog.kakaocdn.net/dn/dJ5rOO/btq2gXWrqGv/ktqqklEMr3NQ3cHmsfwfHk/img.png)

## **[CoroSync](https://honglab.tistory.com/126#CoroSync)**

- Pacemaker가 현재 호스트에서 서비스들이 잘 동작하고 있는지 확인하는 역할이라면

      Corosync는 호스트간에 메시지를 주고받는 역할을 수행

- Pacemaker는 Resource Manager / Corosync는 **Messaging Layer**

## **[Heartbeat](https://honglab.tistory.com/126#Heartbeat)**

- Corosync랑 비슷한 역할이긴 하나 조금 다른듯해서 쓴다
- 클라이언트에 클러스터 인프라(통신 및 멤버십) 서비스를 제공하는 데몬
- 이를 통해 클라이언트는 다른 호스트에서의 서비스 이상 등을 감지할 수 있고 메시지를 쉽게 교환할 수 있다고 한다

## **[RA (Resource Agent)](https://honglab.tistory.com/126#RA%---Resource%--Agent-)**

- Pacemaker가 서비스를 관리할 수 있는 추상 개념
- local resource의 start/stop/monitor 스크립트 제공
- LRM에 의해서 호출됨
- Pacemaker 제공 RA 지원 타입
    - LSB : Linux Standard Base "init scripts"
    - **OCF : Open Cluster Framework**
    - etc...

## **[Pacemaker 클러스터 유형](https://honglab.tistory.com/126#Pacemaker%--%ED%--%B-%EB%-F%AC%EC%-A%A-%ED%--%B-%--%EC%-C%A-%ED%--%--)**

![https://blog.kakaocdn.net/dn/xv2Vr/btq2hY1kZZl/hHtcKUk53xTyXakgpUuSk1/img.png](https://blog.kakaocdn.net/dn/xv2Vr/btq2hY1kZZl/hHtcKUk53xTyXakgpUuSk1/img.png)

![https://blog.kakaocdn.net/dn/bBWAFL/btq2kDoF1en/9dMYD4BhKSpMtNdWKnIzX1/img.png](https://blog.kakaocdn.net/dn/bBWAFL/btq2kDoF1en/9dMYD4BhKSpMtNdWKnIzX1/img.png)

![https://blog.kakaocdn.net/dn/1XwWc/btq2h2W2OuG/hrDLsIOh6hPRosGX6x6FHk/img.png](https://blog.kakaocdn.net/dn/1XwWc/btq2h2W2OuG/hrDLsIOh6hPRosGX6x6FHk/img.png)

## **[pcs (pacemaker configuration system)](https://honglab.tistory.com/126#pcs%---pacemaker%--configuration%--system-)**

- Pacemaker, Corosync, Heartbeat 등의 데몬들 제어하는 CLI 명령어 도구
- pcs <parameter1> <parameter2> .. 이런 식으로 쓰인다
- parameter : **cluster, resource, stonith, constraints, property, status, config**

## **[DRBD (Distributed Replicated Block Device)](https://honglab.tistory.com/126#DRBD%---Distributed%--Replicated%--Block%--Device-)**

- HA 클러스터를 구성하기 위해 **Block 단위로 분산 복제하는 장치**
- Active 상태의 서버 disk에 데이터를 저장하면서 네트워크를 통해 standby 서버에 미러링하는 방식으로 이중화
- 즉, 네트워크를 통한 디스크 미러링!

![https://blog.kakaocdn.net/dn/vDZgT/btq2INep8NN/t2wOsJO6WvWTJLkKjXBZz0/img.png](https://blog.kakaocdn.net/dn/vDZgT/btq2INep8NN/t2wOsJO6WvWTJLkKjXBZz0/img.png)

================================================================ 

HA 구성(CentOS7, corosync, pacemaker 이용)

corosync와 pacemaker를 이용하여 리눅스 HA 클러스터를 구성한다.

Corosync – 클러스터의 저수준 인프라를 제공하며, 클러스터에 대한 쿼럼정보, 멤버쉽, 안정적인 메시징을 제공. 비슷한 프로젝트로는 heartbeat가 있음.Pacemaker – 클러스터의 리소스 관리자. 클러스터 상태에 따른 자원이동, 노드 정지등을 담당함.

corosync와 pacemaker의 역할이 다르므로 보통 두가지를 같이 사용하여 HA 클러스터를 구성한다.

1. 설치전 확인사항(양쪽 노드)각 노드의 ip 주소를 설정하며, /etc/hosts화일에 각 노드를 등록해준다. /etc/hosts화일에 아래 내용을 등록.

```
# cat /etc/hosts

211.183.3.104   node1
211.183.3.105   node2
211.183.3.106   vip
```

2. corosync, pacemaker 설치(양쪽 노드)corosync, pacemaker를 양쪽 노드 모두 설치해준다. 여기서는 yum을 이용해 rpm 패키지로 설치한다.

```
# yum install -y pacemaker corosync pcs psmisc policycoreutils-python
```

3. selinux, 방화벽(iptables)설정

selinux와 방화벽은 사용하지 않음으로 미리 설정했다. 혹시 방화벽을 사용한다면, TCP 포트 2224, 3121, 21064 그리고 UDP 포트 5405를 열어주어야 한다.

```
firewall-cmd --zone=public --permanent --add-port=2224/tcp
firewall-cmd --zone=public --permanent --add-port=3121/tcp
firewall-cmd --zone=public --permanent --add-port=5403/tcp
firewall-cmd --zone=public --permanent --add-port=21064/tcp
firewall-cmd --zone=public --permanent --add-port=9929/tcp
firewall-cmd --zone=public --permanent --add-port=9929/udp
firewall-cmd --zone=public --permanent --add-port=5405/udp
firewall-cmd --zone=public --permanent --add-port=5404/udp
firewall-cmd --add-service=high-availability
firewall-cmd --permanent --add-service=high-availability
firewall-cmd --reload
firewall-cmd --zone=public --list-all
```

4. 설정양쪽 노드 모두에서 pcs 데몬을 실행한다. (참고로, 옛날버전에서는 crm을 사용했었다) 이 데몬은 pcs 커맨드라인 인터페이스와 함께 모든 클러스터 노드에서 구성을 동기화하는 일을 한다.

양쪽노드에서 pcsd를 실행하고, 

(재부팅시 자동으로 실행되도록) 서비스를 enable 시킨다.

```
# systemctl start pcsd.service
# systemctl enable pcsd.service
Created symlink from /etc/systemd/system/multi-user.target.wants/pcsd.service to /usr/lib/systemd/system/pcsd.service.
```

양쪽노드에서, (자동으로 생성된) hscluster 계정의 비밀번호를 양쪽 동일하게 설정한다.

```
# passwd hacluster
hacluster 사용자의 비밀 번호 변경 중 
새  암호:
새  암호 재입력:
passwd: 모든 인증 토큰이 성공적으로 업데이트 되었습니다.
```

corosync를 설정한다.

한쪽 노드에서 아래 커맨드로 hacluster 사용자로 인증한다.

```
# pcs cluster auth node1 node2

Username: hacluster
Password:
node1: Authorized
node2: Authorized
```

한쪽 노드에서 아래 커맨드로 corosync를 구성하고 다른 노드와 동기화한다.

```
# pcs cluster setup --name song_cluster node1 node2
Destroying cluster on nodes: node1, node2...
node1: Stopping Cluster (pacemaker)...
node2: Stopping Cluster (pacemaker)...
node2: Successfully destroyed cluster
node1: Successfully destroyed cluster

Sending cluster config files to the nodes...
node1: Succeeded
node2: Succeeded

Synchronizing pcsd certificates on nodes node1, node2...
node1: Success
node2: Success

Restarting pcsd on the nodes in order to reload the certificates...
node1: Success
node2: Success
```

5. 클러스터 실행과 상태 확인

아래 커맨드로 클러스터를 실행한다.

```
# pcs cluster start --all

node1: Starting Cluster...
node2: Starting Cluster...
```

클러스터 통신을 확인한다.

```
# corosync-cfgtool -s
Printing ring status.
Local node ID 1
RING ID 0
	id	= 211.183.3.104
	status	= ring 0 active with no faults
```

멤버쉽과 쿼럼을 확인한다.

```
# corosync-cmapctl | egrep -i members

runtime.totem.pg.mrp.srp.members.1.config_version (u64) = 0

runtime.totem.pg.mrp.srp.members.1.ip (str) = r(0) ip(211.183.3.104)

runtime.totem.pg.mrp.srp.members.1.join_count (u32) = 1

runtime.totem.pg.mrp.srp.members.1.status (str) = joined

runtime.totem.pg.mrp.srp.members.2.config_version (u64) = 0

runtime.totem.pg.mrp.srp.members.2.ip (str) = r(0) ip(211.183.3.105)

runtime.totem.pg.mrp.srp.members.2.join_count (u32) = 1

runtime.totem.pg.mrp.srp.members.2.status (str) = joined

```

```
# pcs status corosync

Membership information

----------------------

Nodeid      Votes Name

1          1 node1 (local)

2          1 node2
```

```
# pcs status

Membership information

----------------------

Nodeid      Votes Name

1          1 node1 (local)

2          1 node2**

# pcs status
Cluster name: song_cluster
WARNING: no stonith devices and stonith-enabled is not false
Stack: corosync
Current DC: wolf1 (version 1.1.15-11.el7_3.2-e174ec8) - partition with quorum
Last updated: Mon Jul 22 15:28:40 2021		Last change: Mon Jul 22 15:28:40 2021 by hacluster via crmd on node1

2 nodes and 0 resources configured

Online: [ node1 node2 ]

No resources

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
  pcsd: active/enabled
```

6. Active/Passive 클러스터 생성

클러스터 설정을 변경하기 전에 아래처럼 crm_verify 명령어로 유효성을 확인해 두는 것이 좋다. STONITH 부분에서 오류가 발생한다.

```
# crm_verify -L -V   

error: unpack_resources:	Resource start-up disabled since no STONITH resources have been defined

error: unpack_resources:	Either configure some or disable STONITH with the stonith-enabled option

error: unpack_resources:	NOTE: Clusters with shared data need STONITH to ensure data integrity Errors found during check: config not valid
```

데이타의 무결성을 확보하기 위해 기본으로 STONITH가 활성화되어 있는데 이것을 비활성하고 다시 확인해보면 아무런 오류가 발생하지 않는다.

```
# pcs property set stonith-enabled=false

# crm_verify -L
```

가상 IP 리소스 생성

아래 명령어로 가상아이피를 리소스로 추가한다. 가상아이피는 노드가 다운되면 다른 노드로 이동하며, 실제로 서비스에 이용되는 IP 주소로 이용한다.

```
# pcs resource create VirtualIP ocf:heartbeat:IPaddr2 ip=211.183.3.106 cidr_netmask=24 op monitor interval=30s
```

클러스터 상태를 확인해 보면, 리소스리스트에 VirtualIP가 추가된 것을 볼 수 있고, ip 주소를 확인해보면, 설정한 아이피주소가 나타남을 확인 할 수 있다.

```
# pcs status

Cluster name: song_cluster
Stack: corosync
Current DC: node2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Mon Jul 26 16:01:27 2021
Last change: Mon Jul 26 15:13:14 2021 by root via cibadmin on node1

2 nodes configured
2 resource instances configured

Online: [ node1 node2 ]

Full list of resources:

VirtualIP      (ocf::heartbeat:IPaddr2):       Started node1

Daemon Status:
corosync: active/disabled
pacemaker: active/disabled
pcsd: active/enabled
```

```
# ip addr

ens32: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:42:6a:dc brd ff:ff:ff:ff:ff:ff
    inet 211.183.3.104/24 brd 211.183.3.255 scope global noprefixroute ens32
       valid_lft forever preferred_lft forever
    inet 211.183.3.106/24 brd 211.183.3.255 scope global secondary ens32
       valid_lft forever preferred_lft forever
    inet6 fe80::1105:a4cd:9c77:cf17/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
```

위에서 추가한 리소스 VirtualIP는 세 부분 ocf:heartbeat:IPaddr2 의 형태로 구분했다. 여기에서, 첫번째 필드는 resource standard 두번째 필드는 표준에 따라 다르며 세번째 필드는 리소스 스크립트의 이름이다.

리소스 standard는 다음 명령어로 확인 가능하다.

```
# pcs resource standards
ocf
lsb
service
systemd
```

위 결과에서 각각의 의미는 다음과 같다.

ocf – Open cluster Framework

lsb – Linux standard base (보통 init scripts)

service – Based on Linux “service” command.

systemd – systemd based service Management

stonith – Fencing Resource standard.

두번째 필드인 ocf의 리소스 프로바이더는 아래 커맨드로 확인가능하다

```
# pcs resource providers
heartbeat
openstack
pacemaker
```

세번째 필드인 리소스 스크립트는 아래처럼 확인 가능하다.

```
# pcs resource agents ocf:heartbeat
aliyun-vpc-move-ip
apache
aws-vpc-move-ip
aws-vpc-route53
awseip
awsvip
azure-events
azure-lb
clvm
conntrackd
CTDB
db2
Delay
dhcpd
docker
Dummy
ethmonitor
exportfs
Filesystem
galera
garbd
iface-vlan
IPaddr
IPaddr2
IPsrcaddr
iSCSILogicalUnit
iSCSITarget
LVM
LVM-activate
lvmlockd
MailTo
mysql
nagios
named
nfsnotify
nfsserver
nginx
NodeUtilization
oraasm
oracle
oralsnr
pgsql
portblock
postfix
rabbitmq-cluster
redis
Route
rsyncd
SendArp
slapd
Squid
sybaseASE
symlink
tomcat
vdo-vol
VirtualDomain
Xinetd
```

이제, node1 을 정지시켜 failover를 확인해본다.

```
# pcs cluster stop node1
node1: Stopping Cluster (pacemaker)...
node1: Stopping Cluster (corosync)...

# pcs status
Error: cluster is not currently running on this node
```

node2 에서 클러스터 상태를 확인해 보면,

```
# pcs status

2 nodes and 1 resource configured

Online: [ node2 ]

OFFLINE: [ node1 ]

Full list of resources:

VirtualIP	(ocf::heartbeat:IPaddr2):	Started node2

Daemon Status:

corosync: active/disabled

pacemaker: active/disabled

pcsd: active/enabled
```

wolf1에서 클러스터를 다시 실행해도, 리소스는 wolf1으로 돌아오지 않는다.

```
# pcs cluster start node1

node1: Starting Cluster..

2 nodes and 1 resource configured

Online: [ node1 node2 ]

Full list of resources:

VirtualIP	(ocf::heartbeat:IPaddr2):	Started node2

Daemon Status:

corosync: active/disabled

pacemaker: active/disabled

pcsd: active/enabled
```

resource stickniess – 자원의 이동에는 대부분 가동중지 시간이 필요하며, 데이타베이스처럼 복잡한 서비스는 이 시간이 길어질 수 있다. 이 문제를 해결하기위해서 pacemaker에서 제공하는 개념이 리소스 stickiness. 기본값은 0 이지만, 이 숫자를 늘여서 서비스가 이동하는 것을 제어할 수 있다.

```
# pcs resource defaults

No defaults set

# pcs resource defaults resource-stickiness=60

# pcs resource defaults

resource-stickiness: 60
```

7. 클러스터 서비스로 아파치 웹서버 등록하기

설치는 양쪽 노드에 아래 커맨드로 설치한다. wget은 서비스 상태를 모니터링하기 위해 설치한다.

```
# yum -y install httpd wget

# ssh root@211.183.3.105 yum install -y httpd wget
```

설치를 마친후 /var/www/html/index.html 화일을 만든다.

/etc/httpd/conf.d/status.conf 화일에 아래 내용을 입력한다(양쪽 노드 모두).

```
# cat /etc/httpd/conf.d/status.conf

<Location /server-status>

SetHandler server-status

Require local

</Location>
```

아래 커맨드로 리소스를 등록한하고 확인한다.

```
# pcs resource create WebService ocf:heartbeat:apache configfile=/etc/httpd/conf/httpd.conf statusurl="http://localhost/server-status" op monitor interval=1min
# pcs status
Cluster name: song_cluster
Stack: corosync
Current DC: node2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Mon Jul 26 16:08:57 2021
Last change: Mon Jul 26 15:13:14 2021 by root via cibadmin on node1
2 nodes configured
2 resource instances configured

Online: [ node1 node2 ]

Full list of resources:

VirtualIP      (ocf::heartbeat:IPaddr2):       Started node1
WebService     (ocf::heartbeat:apache):        Started node2

Daemon Status:
corosync: active/disabled
pacemaker: active/disabled
pcsd: active/enabled
```

위의 상태를 보면, 가상ip주소는 wolf1에, 웹서비스는 wolf2에서 실행되고 있음을 볼 수 있다. 이 문제는 colocation constraint 두 리소스를 묶어줌으로써 해결된다.

```
# pcs constraint

Location Constraints:

Ordering Constraints:

Colocation Constraints:

Ticket Constraints:

# pcs constraint colocation add WebService with VirtualIP INFINITY

# pcs constraint

Location Constraints:

Ordering Constraints:

Colocation Constraints:

WebService with VirtualIP (score:INFINITY)

Ticket Constraints:
```

이제 확인해보면 두 리소스 VirtualIP, WebService가 같은 노드에서 실행되고 있음을 볼 수 있다.

```
# pcs status
Cluster name: song_cluster
Stack: corosync
Current DC: node2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Mon Jul 26 16:08:57 2021
Last change: Mon Jul 26 15:13:14 2021 by root via cibadmin on node1
2 nodes configured
2 resource instances configured

Online: [ node1 node2 ]

Full list of resources:

VirtualIP      (ocf::heartbeat:IPaddr2):       Started node1
WebService     (ocf::heartbeat:apache):        Started node1

Daemon Status:
corosync: active/disabled
pacemaker: active/disabled
pcsd: active/enabled
```

만약 어떤 서비스가 먼저 실행되고 난 이후 서비스가 실행되어야 할 필요가 있을때는 아래와 같은 방법을 사용한다. 아래는 VirtualIP가 먼저 실행된 후 WebService가 실행되도록 한다.

```
# pcs constraint

Location Constraints:

Ordering Constraints:

Colocation Constraints: 

WebService with VirtualIP (score:INFINITY)

Ticket Constraints:

# pcs constraint order VirtualIP then WebService

Adding VirtualIP WebService (kind: Mandatory) (Options: first-action=start then-action=start)

# pcs constraint

Location Constraints:

Ordering Constraints:  start VirtualIP then start WebService (kind:Mandatory)

Colocation Constraints:  WebService with VirtualIP (score:INFINITY)

Ticket Constraints:
```

Pacemaker는 두 노드의 하드웨어사양이 동일할 필요가 없기 때문에, 보다 강력한 노드에서 서비스를 실행하도록 하는 것이 가능하다. 이는 constraint location을 지정함으로써 가능하다.

```
# pcs constraint

Location Constraints:

Resource: WebService

Enabled on: node2 (score:50)

Ordering Constraints:

start VirtualIP then start WebService (kind:Mandatory

Colocation Constraints:

WebService with VirtualIP (score:INFINITY)

Ticket Constraints:
```

8. 수동으로 리소스 강제 이동하기

리소스를 강제로 다른 노드로 이동하기 위해서는 constraint location의 스코어를 INFINITY로 변경하면된다. 아래는 WebService 리소스를 node2 노드로 강제 이동하는 명령어이다.

```
# pcs constraint

Location Constraints:

Resource: WebService

Enabled on: node1 (score:50)

Ordering Constraints:

start VirtualIP then start WebService (kind:Mandatory)

Colocation Constraints:

WebService with VirtualIP (score:INFINITY)

Ticket Constraints:

# pcs constraint location WebService prefers node2=INFINITY

# pcs constraint
Location Constraints:
  Resource: WebService
    Enabled on: node2 (score:INFINITY)
Ordering Constraints:
  start VirtualIP then start WebService (kind:Mandatory)
Colocation Constraints:
  WebService with VirtualIP (score:INFINITY)
Ticket Constraints:

# pcs status

Cluster name: song_cluster
Stack: corosync
Current DC: node2 (version 1.1.23-1.el7_9.1-9acf116022) - partition with quorum
Last updated: Mon Jul 26 16:39:33 2021
Last change: Mon Jul 26 15:13:14 2021 by root via cibadmin on node1

2 nodes configured
2 resource instances configured

Online: [ node1 node2 ]

Full list of resources:

 VirtualIP      (ocf::heartbeat:IPaddr2):       Started node2
 WebService     (ocf::heartbeat:apache):        Started node2

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
  pcsd: active/enabled
```

constraint location 삭제는 아래와 같이 할 수 있다.

현재의 constraint를 확인하고,

```
# pcs constraint
Location Constraints:
Resource: WebService
Enabled on: node1 (score:INFINITY)
Disabled on: node2 (score:-INFINITY)
Ordering Constraints:
start VirtualIP then start WebService (kind:Mandatory)
Colocation Constraints:
WebService with VirtualIP (score:INFINITY)
```

id를 확인하고, remove 한다.

```
# pcs status --full
Location Constraints:
Resource: WebService
Enabled on: node1 (score:INFINITY) (id:location-WebService-node1-INFINITY)
Disabled on: node2 (score:-INFINITY) (id:location-WebService-node2--INFINITY)
Ordering Constraints:
start VirtualIP then start WebService (kind:Mandatory) (id:order-VirtualIP-WebService-mandatory)
Colocation Constraints:
WebService with VirtualIP (score:INFINITY) (id:colocation-WebService-VirtualIP-INFINITY)
Ticket Constraints:

# pcs constraint remove location-WebService-node2--INFINITY
```

webservice stoped , ,failed 뜰때 pid 위치가 달라서 뜬다

아래의 명령어로 환경변수를 주면 된다.

```
/bin/sed -i '/s/RUNDIR\/${httpd_basename}.pid/RUNDIR\/${httpd_basename}\/${httpd_basename}.pid/g' /usr/lib/ocf/lib/heartbeat/apache-conf.sh
```

중요한 내용을 한번 더 언급한다. 위처럼 PCS Resource 로 관리되는 항목은 systemctl 로 중복 실행되면 안된다. Volume Group 을 PCS 클러스터만이 활성화할 수 있게 설정한 거랑 동일하다고 생각하면 된다. 이렇게 하지 않으면 systemctl 로도 Resource 가 실행되고 PCS클러스터가 또 실행하려고 하면서 오류가 발생할 수 있다.

위 Resource들 중에서 mysql 과 httpd 의 경우 enable 되어있으면 PC 부팅 시 자동으로 실행되기 때문에 해당 옵션을 제거한다.

# 펜싱(fencing) or STONITH

리눅스 HA 구성을 하다보면 Fencing이라는 용어를 접한다.

Fencing이란, 오류가 발생한 호스트(노드)나 리소스(디스크 등)를 비활성화 시키는 것을 의미한다.

그리고 Pacemaker에서 이러한 Fencing 기능을 해주는 것이 STONITH 이다.

STONITH는 다른 노드의 **서비스 이상**이나 노드의 **Power-off** 등이 감지되면 그 서비스나 노드를 **재시작**한다.  

STONITH는 Shoot-The-Other-Node-In-The-Head의 약어로, "다른 노드의 머리를 쏜다" 라는 의미이다.

STONITH를 통해 서비스가 중복으로 실행되서, Corruption(충돌)이 발생하는 것을 방지한다.

## CLI 펜싱 구성

# PaceMaker 클러스터 관리 명령어

리소스가 실패한 경우 클러스터 상태를 표시할 때 실패 메시지가 나타난다. 

해당 리소스를 해결하는 경우 `pcs resource cleanup`명령을 사용하여 해당 실패 상태를 지울 수 있다 . 

이 명령은 리소스 상태를 재설정하고 `failcount`클러스터에 리소스의 작업 기록을 잊어버리고 현재 상태를 다시 감지하도록 지시한다.

```
pcs resource cleanup resource_id
```

*resource_id 를* 지정하지 않으면 이 명령 `failcount`은 모든 리소스에 대해 리소스 상태를 재설정한다 .

Red Hat Enterprise Linux 7.5부터 `pcs resource cleanup`명령은 실패한 작업으로 표시되는 리소스만 검색한다. 모든 노드의 모든 리소스를 조사하려면 다음 명령을 입력할 수 있다.

```
pcs resource refresh
```

기본적으로 이 pcs resource refresh명령은 리소스 상태가 알려진 노드만 검색한다. 상태를 알 수 없는 경우에도 모든 리소스를 검색하려면 다음 명령을 입력한다.

```
pcs resource refresh --full
```

클러스터 노드 상태를 보기 위한 PaceMaker 클러스터 명령.

```
# pcs cluster status
```

- 클러스터 노드 및 리소스의 자세한 상태를 보려면 PaceMaker 클러스터 명령을 사용한다.

```
# pcs status --full
```

- 클러스터 노드 및 리소스의 상태를 보려면 PaceMaker 클러스터 명령을 사용한다.

```
# crm_mon -r1
```

- 클러스터 노드 및 리소스의 실시간 상태를 보기 위한 PaceMaker 클러스터 명령.

```
# crm_mon r
```

- 모든 클러스터 리소스 및 리소스 그룹의 상태를 보기 위한 PaceMaker 클러스터 명령.

```
# pcs resource show
```

- 클러스터 노드를 대기 모드로 전환하는 PaceMaker 클러스터 명령.

```
# pcs cluster standby <Cluster node name>
```

- 대기 모드에서 클러스터 노드를 제거하는 PaceMaker 클러스터 명령.

```
# pcs cluster unstandby <Cluster node name>:
```

- 한 노드에서 다른 노드로 클러스터 리소스를 이동하는 PaceMaker 클러스터 명령.

```
# pcs resource move <resource name> <node name>
```

- 실행 중인 노드에서 클러스터 리소스를 다시 시작하는 PaceMaker 클러스터 명령.

```
# pcs resource restart <resource name>
```

- 현재 노드에서 클러스터 리소스를 시작하는 PaceMaker 클러스터 명령.

```
# pcs resource enable <resource name>
```

- 실행 중인 노드에서 클러스터 리소스를 중지하는 PaceMaker 클러스터 명령.

```
# pcs resource disable <resource name>
```

- 디버그 클러스터 리소스를 시작하는 PaceMaker 클러스터 명령. `-full`더 자세한 출력을 위해 스위치 를 사용할 수 있다 .

```
# pcs resource debug-start <Resource Name>
```

- 클러스터 리소스 디버깅을 중지하는 PaceMaker 클러스터 명령. `-full`더 자세한 출력을 위해 스위치 를 사용할 수 있다 .

```
# pcs resource debug-stop <Resource Name>
```

- 클러스터 리소스 디버깅을 모니터링하는 PaceMaker 클러스터 명령. `-full`더 자세한 출력을 위해 스위치 를 사용할 수 있다 .

```
# pcs resource debug-monitor <Resource Name>
```

- 사용 가능한 클러스터 리소스 에이전트를 나열하는 PaceMaker 클러스터 명령.

```
# pcs resource agents
```

- PaceMaker 클러스터 명령을 사용하여 추가 정보와 함께 사용 가능한 클러스터 리소스 에이전트를 나열한다.

```
# pcs resource list
```

- 클러스터 리소스 에이전트 및 해당 구성 또는 설정에 대한 자세한 정보를 보려면 PaceMaker 클러스터 명령을 사용한다.

```
# pcs resource describe <Resource Agents Name>
```

- PaceMaker 클러스터 명령을 사용하여 클러스터 리소스를 생성한다.

```
# pcs resource create <Reource Name> <Reource Agent Name> options
```

- 특정 리소스의 클러스터 구성 설정을 보기 위한 PaceMaker 클러스터 명령.

```
# pcs resource show <Resource Name>
```

- 특정 클러스터 리소스 구성을 업데이트하는 PaceMaker 클러스터 명령.

```
# pcs resource update <Resource Name> options
```

- 특정 클러스터 리소스를 삭제하는 PaceMaker 클러스터 명령.

```
# pcs resource delete <Resource Name>
```

- 특정 클러스터 리소스를 정리하는 PaceMaker 클러스터 명령.

```
# pcs resource cleanup <Resource Name>
```

- 사용 가능한 클러스터 펜스 에이전트를 나열하는 PaceMaker 클러스터 명령.

```
# pcs stonith list
```

- PaceMaker 클러스터 명령은 펜스 에이전트에 대한 세부 클러스터 구성 설정을 본다.

```
# pcs stonith describe <Fence Agent Name>
```

- PaceMaker 클러스터 명령은 PaceMaker 클러스터 stonith 에이전트를 생성한다.

```
# pcs stonith create <Stonith Name> <Stonith Agent Name> options
```

- stonith 에이전트의 PaceMaker 클러스터 구성 설정을 표시한다.

```
# pcs stonith show <Stonith Name>
```

- PaceMaker 클러스터 stonith 구성을 업데이트한다.

```
# pcs stonith update <Stonith Name> options
```

- stonith 에이전트를 삭제하는 PaceMaker 클러스터 명령.

```
# pcs stonith delete <Stonith Name>
```

- stonith 에이전트 오류를 정리하기 위한 PaceMaker 클러스터 명령.

```
# pcs stonith cleanup <Stonith Name>
```

- 클러스터 구성을 확인하는 PaceMaker 클러스터 명령.

```
# pcs config
```

- 클러스터 속성을 확인하는 PaceMaker 클러스터 명령.

```
# pcs property list
```

- 클러스터 속성에 대한 자세한 정보를 얻으려면 PaceMaker 클러스터 명령을 사용한다.

```
# pcs property list --all
```

- XML 형식으로 클러스터 구성을 확인하는 PaceMaker 클러스터 명령.

```
# pcs cluster cib
```

- 클러스터 노드 상태를 확인하는 PaceMaker 클러스터 명령.

```
# pcs status nodes
```

- 현재 노드에서 클러스터 서비스를 시작하는 PaceMaker 클러스터 명령.

```
# pcs cluster start
```

- 모든 노드에서 클러스터 서비스를 시작하는 PaceMaker 클러스터 명령.

```
# pcs cluster start --all
```

- 현재 노드에서 클러스터 서비스를 중지하는 PaceMaker 클러스터 명령.

```
# pcs cluster stop
```

- 모든 노드에서 클러스터 서비스를 중지하는 PaceMaker 클러스터 명령.

```
# pcs cluster stop --all
```

- `corosync.conf`파일 을 동기화하는 PaceMaker 클러스터 명령 .

```
# pcs cluster sync
```

- PaceMaker 클러스터 명령은 클러스터를 없앤다.

```
# pcs cluster destroy <Cluster Name>
```

- PaceMaker 클러스터 명령을 사용하여 새 클러스터 구성 파일을 생성한다.
- 이 파일은 현재 위치에 생성되며 이 구성 파일에 여러 클러스터 리소스를 추가하고 `cib-push`명령 을 사용하여 적용할 수 있다 .

```
# pcs cluster cib <new config name>
```

- PaceMaker 클러스터 명령은 구성 파일에서 생성된 리소스를 클러스터에 적용한다.

```
# pcs cluster cib-push <new config name>
```

- 클러스터 리소스 그룹 목록을 보려면 PaceMaker 클러스터 명령.

```
# pcs resource group list
```

- corosync 구성 출력을 보기 위한 PaceMaker 클러스터 명령.

```
# pcs cluster corosync
```

- 클러스터 리소스 순서를 확인하는 PaceMaker 클러스터 명령.

```
# pcs constraint list
```

- 쿼럼 정책을 무시하는 PaceMaker 클러스터 명령.

```
# pcs property set no-quorum-policy=ignore
```

- stonith를 비활성화하는 PaceMaker 클러스터 명령.

```
# pcs property set stonith-enabled=false
```

- 클러스터 기본 고정 값을 설정하는 PaceMaker 클러스터 명령.

```
# pcs resource defaults resource-stickiness=100
```

### **펜싱 기록 정리**

`pcs stonith history cleanup [<node>]`명령을 사용하여 지정된 노드의 펜싱 기록을 지우거나 노드가 지정되지 않은 경우 모든 노드의 펜싱 기록을 지운다.

```
# pcs stonith history cleanup 
cleaning up fencing-history for node rhel-8-0-2

# pcs stonith history
We failed to reboot node rhel-8-0-1 on behalf of stonith_admin.2369 from rhel-8-0-2 at Wed Feb  6 18:59:53 2019

# pcs stonith history cleanup
cleaning up fencing-history for node *

# pcs stonith history
```

STONITH resource list

[13.3. Differences of STONITH Resources](https://clusterlabs.org/pacemaker/doc/deprecated/en-US/Pacemaker/1.1/html/Pacemaker_Explained/_differences_of_stonith_resources.html)

================================================================

[리눅스 HA(corosync, pacemaker, DRBD) - Part 2](https://blog.boxcorea.com/wp/archives/2660)

[DRBD / HeartBeat / NFS](https://dupont3031.tistory.com/entry/HA-LVS-MON)

[DB이중화 DRBD 와 headrbeat 설치](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=parminho&logNo=220750075277)

DRBD

Pacemaker 는 고 가용성을 위해 클러스터를 구성 및 관리를 할 수 있는 클러스터 리소스 관리자의 역활을 해주는 오픈소스 입니다. 예를 들어 마스터와 백업 서버가 하나의 클러스터로 묶여 있는 상태에서 마스터 노드에 장애 발생 시 백업 서버로 서비스를 넘겨주는 방식입니다.

이 서비스를 DRBD 와 함께 사용한다면 DRBD 는 데이터 복제를 담당하고 Pacemaker(이하 페이스메이커) 는 장애 인지 후 백업 서버로 서비스를 전환해 주는 역활을 담당하여 최소한의 다운타임으로 서비스 연속성을 유지할 수 있는 것입니다. 이 방법은 Active-Standby 방식이며, 페이스메이커에서는 Active-Active 방식도 지원 됩니다.

싱크중에는 primary 먼저 중지 하고 secondary 중지 해야됨

restart나 네트웍 재연결시 0%에서 다시 싱크됨

테스트시 secondary 를 primary로 바꾼후 마운트 해야됨

싱크중 drbdadm primary r0 가능

# vi /etc/sysctl.conf

net.ipv4.ip_nonlocal_bind = 1

net.ipv4.conf.all.forwarding = 1

net.ipv4.conf.all.arp_ignore = 1

net.ipv4.conf.all.arp_announce = 2