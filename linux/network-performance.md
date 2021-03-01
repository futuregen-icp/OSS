### ** TCP Receive Queue and netdev_max_backlog**

TCP 수신 대기열 및 netdev_max_backlog 각 CPU 코어는 네트워크 스택이 처리 할 수 있기 전에 링 버퍼에 여러 패킷을 보유 할 수 있습니다. 버퍼가 TCP 스택이 처리 할 수있는 것보다 빨리 채워지면 삭제 된 패킷 카운터가 증가하고 삭제됩니다. 처리를 위해 대기중인 패킷 수를 최대화하려면 net.core.netdev_max_backlog 설정을 늘려야합니다.



```
# Receive Queue Size per CPU Core, number of packets
# Example server: 8 cores
net.core.netdev_max_backlog = 4096# SYN Backlog Queue, number of half-open connections
net.ipv4.tcp_max_syn_backlog = 32768# Accept Queue Limit, maximum number of established
# connections waiting for accept() per listener.
net.core.somaxconn = 65535# Maximum number of SYN and SYN+ACK retries before
# packet expires.
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1# Timeout in seconds to close client connections in
# TIME_WAIT after receiving FIN packet.
net.ipv4.tcp_fin_timeout = 5# Disable SYN cookie flood protection
net.ipv4.tcp_syncookies = 0
```

### **TCP Backlog Queue and tcp_max_syn_backlog**

> **net.core.netdev_max_backlog = 4096**
> #SYN Backlog Queue, number of half-open connections

수신 대기열에서 선택되어 SYN 백 로그 대기열로 이동되는 모든 SYN 패킷에 대한 연결이 생성됩니다. 연결은 "SYN_RECV"로 표시되고 SYN ACK가 클라이언트로 다시 전송됩니다. 이러한 연결은 해당 ACK가 수신 및 처리 될 때까지 수락 큐로 이동되지 않습니다. 대기열의 최대 연결 수는 net.ipv4.tcp_max_syn_backlog 커널 설정에서 설정됩니다.



**SYN Cookies**

> **net.ipv4.tcp_syncookies = 0**

SYN 쿠키가 활성화되지 않은 경우 클라이언트는 SYN 패킷 전송을 다시 시도합니다. SYN 쿠키가 활성화 된 경우 (net.ipv4.tcp_syncookies) 연결이 생성되지 않고 SYN 백 로그에 저장되지 않지만 SYN + ACK 패킷이 마치 클라이언트로 전송됩니다. SYN 쿠키는 정상적인 트래픽에서 유용 할 수 있지만 대용량 버스트 트래픽 중에 일부 연결 세부 정보가 손실되고 연결이 설정 될 때 클라이언트에 문제가 발생합니다. 



**SYN+ACK Retries**
> **net.ipv4.tcp_synack_retries = 1**
> #Timeout in seconds to close client connections in

SYN + ACK가 전송되었지만 응답 ACK 패킷을받지 못하면 어떻게됩니까? 이 경우 서버의 네트워크 스택은 SYN + ACK 전송을 다시 시도합니다. 시도 사이의 지연은 서버 복구를 위해 계산됩니다. 서버가 SYN을 수신하고 SYN + ACK를 보내고 ACK를 수신하지 않는 경우 재시도 시간은 지수 백 오프 알고리즘을 따르므로 해당 시도에 대한 재시도 카운터에 따라 달라집니다. SYN + ACK 재시도 횟수를 정의하는 커널 설정은 net.ipv4.tcp_synack_retries이며 기본 설정은 5입니다. 이것은 첫 번째 시도 후 1 초, 3 초, 7 초, 15 초, 31 초 간격으로 재 시도합니다. 마지막 재 시도는 첫 번째 시도가 이루어진 후 약 63 초 후에 시간 초과됩니다. 이는 재시도 횟수가 6 인 경우 다음 시도가 이루어진시기에 해당합니다. 이것만으로도 SYN 패킷을 SYN 백 로그에 60 초 이상 유지할 수 있습니다. 패킷 시간이 초과되기 전에. SYN 백 로그 대기열이 작은 경우 네트워크 스택에서 증폭 이벤트를 발생시키는 데 많은 양의 연결이 필요하지 않습니다. 여기서 반 개방 연결이 완료되지 않고 연결을 설정할 수 없습니다. 고성능 서버에서이 동작을 방지하려면 SYN + ACK 재시도 횟수를 0 또는 1로 설정하십시오



**SYN Retries**

> **net.ipv4.tcp_syn_retries = 1** 
> #packet expires.

SYN 재 시도는 클라이언트가 SYN + ACK를 기다리는 동안 SYN 전송을 재 시도하는 횟수를 나타내지 만 프록시 연결을 만드는 고성능 서버에도 영향을 미칠 수 있습니다. 트래픽 급증으로 인해 백엔드 서버에 수십 개의 프록시 연결을 만드는 nginx 서버는 짧은 기간 동안 백엔드 서버의 네트워크 스택에 과부하를 줄 수 있으며 재 시도는 수신 대기열과 SYN 백 로그 대기열 모두에서 백엔드에 증폭을 생성 할 수 있습니다. . 이는 차례로 제공되는 클라이언트 연결에 영향을 미칠 수 있습니다. SYN 재 시도에 대한 커널 설정은 net.ipv4.tcp_syn_retries이며 배포에 따라 기본값은 5 또는 6입니다. 63–130 초 이상 재 시도하는 대신 SYN 재시도 횟수를 0 또는 1로 제한하십시오

### **TCP Accept Queue and somaxconn**

애플리케이션은“backlog”매개 변수를 지정하여 listen ()을 호출 할 때 리스너 포트를 열 때 수락 큐를 생성해야합니다. Linux 커널 v2.2부터이 매개 변수는 소켓이 보유 할 수있는 최대 불완전 연결 수를 허용 대기중인 최대 연결 수로 변경되었습니다. 위에서 설명한대로 이제 최대 불완전 연결 수는 커널 설정 net.ipv4.tcp_max_syn_backlog로 설정됩니다.

**Accept Queue Default**

> **net.ipv4.tcp_max_syn_backlog = 32768**	
> #Accept Queue Limit, maximum number of established
> #connections waiting for accept() per listener.
>
> **net.core.somaxconn = 65535**
> #Maximum number of SYN and SYN+ACK retries before.

net.core.somaxconn의 기본값은 SOMAXCONN 상수에서 가져옵니다.이 상수는 v5.3까지의 Linux 커널에서 128로 설정되는 반면, SOMAXCONN은 v5.4에서 4096으로 증가되었습니다. 그러나 v5.4는이 글을 쓰는 시점에서 가장 최신 버전이며 아직 널리 채택되지 않았으므로 net.core.somaxconn을 수정하지 않은 많은 프로덕션 시스템에서 수락 대기열이 128로 잘립니다.



### TCP Reverse Proxy Connections in TIME_WAIT

대용량 버스트 트래픽에서 "TIME_WAIT"에 멈춰있는 프록시 연결은 긴밀한 연결 핸드 셰이크 동안 많은 리소스를 묶을 수 있습니다. 이 상태는 클라이언트가 서버 (또는 업스트림 작업자)로부터 최종 FIN 패킷을 수신했으며 제대로 처리하기 위해 지연된 비행 중 패킷에 보관되고 있음을 나타냅니다. 기본적으로 "TIME_WAIT"에 연결이 존재하는 시간은 2 x MSL (최대 세그먼트 길이), 즉 2 x 60 초입니다. 대부분의 경우 이는 정상이며 예상되는 동작이며 기본값 인 120 초가 허용됩니다. 그러나 "TIME_WAIT"상태의 연결 볼륨이 높으면 응용 프로그램에서 클라이언트 소켓에 연결할 수있는 임시 포트가 부족해질 수 있습니다. 이 경우 FIN 타임 아웃을 줄여서 이러한 타임 아웃을 더 빠르게하십시오.

이 시간 제한을 제어하는 커널 설정은 net.ipv4.tcp_fin_timeout이며 고성능 서버에 적합한 설정은 5 ~ 7 초입니다.

> net.ipv4.tcp_fin_timeout = 5
> #Disable SYN cookie flood protection



### Connections and File Descriptors
system limit 
cat /proc/sys/fs/file-nr
10944   0       1198496

fs.file-max =1198496  (max.  3261780)

user limit 
nproc = 4096  (max. 65536)
nofile = 1024  (max. 65536)

/etc/security/limits.d/21-testc.conf
test soft nofile 64000
test hard nofile 64000
test soft nproc 64000
test hard nproc 64000


kernel.threads-max = 3261780

```
# /etc/sysctl.d/00-network.conf
# Receive Queue Size per CPU Core, number of packets
# Example server: 8 cores
net.core.netdev_max_backlog = 4096
# SYN Backlog Queue, number of half-open connections
net.ipv4.tcp_max_syn_backlog = 32768
# Accept Queue Limit, maximum number of established
# connections waiting for accept() per listener.
net.core.somaxconn = 65535
# Maximum number of SYN and SYN+ACK retries before
# packet expires.
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
# Timeout in seconds to close client connections in
# TIME_WAIT after receiving FIN packet.
net.ipv4.tcp_fin_timeout = 5
# Disable SYN cookie flood protection
net.ipv4.tcp_syncookies = 0
# Maximum number of threads system can have, total.
# Commented, may not be needed. See user limits.
#kernel.threads-max = 3261780
# Maximum number of file descriptors system can have, total.
# Commented, may not be needed. See user limits.
#fs.file-max = 3261780
The following user limit settings were discussed in this article:
# /etc/security/limits.d/nginx.conf
nginx soft nofile 64000
nginx hard nofile 64000
nginx soft nproc 64000
nginx hard nproc 64000
```

