# DNS

### **1. DNS (Domain Name System)**

### **1) DNS 등장 배경**

인터넷 표준 프로토콜은 TCP/IP이다.

TCP/IP 프로토콜을 사용하는 네트워크 안에서 Host들을 식별하기 위한 목적으로 IP 주소를 사용한다.

사람의 경우 숫자보다 문자를 사용하는 것이 더 편하기 때문에 도메인 이름을 사용하여 Host들을 식별한다.

도메인 이름을 사용하는 경우에도 최종적으로 IP주소를 알고 있어야 상대방 장비와 연결이 가능하다.

네트워크에서 도메인이나 호스트 이름을 숫자로 된 IP 주소로 해석해 주는 TCP/IP Network Service인 DNS가 등장하였다.

### **2) DNS 포트 번호**

UDP와 TCP 포트 53번을 사용한다.

**UDP**: 일반적인 DNS 조회를 할 경우 사용한다.

**TCP**: Zone Transfer(영역 전송)와 512Byte를 초과하는 DNS패킷을 전송해야 할 경우이다.

================================================================

### 2**. DNS의 구성 요소**

### **1) 도메인 네임 스페이스 (Domain Name Space)**

DNS가 저장,관리하는 계층적 구조를 의미한다.

![DNS%202c9a87a256d44a408dab357d0b4e614f.png](DNS%202c9a87a256d44a408dab357d0b4e614f.png)

최상위에 루트 DNS 서버가 존재하고, 그 하위로 인터넷에 연결된 모든 노드(네모 표시)가 연속해서 이어진계층 구조로 구성되어 있다.

PC에서 사용하는 디렉토리 구조와 유사함을 알 수 있는데, 각 레벨(Top level, Second level 등)의 도메인은 그 하위 도메인 에 관한 정보를 관리하는 구조이다. (계층적 구조)

**도메인(Domain) 이란?**

도메인은 도메인 네임 스페이스의 서브트리이다. 도메인 이름은 서브트리의 맨 상위에있는 노드에 위치한다.

### **2) 네임 서버 (Name Server)**

문자열로 표현된 도메인 이름을 실제 컴퓨터가 통신할 때 사용하는 숫자로 표현된 IP 주소로 변환시켜 주기 위해서는 도메인 네임 스페이스의 트리 구조 에 대한 정보가 필요하며, 이러한 정보를 가지고 있는 서버를 네임 서버라고 한다.

도메인 이름을 IP 주소로 변환하는 것을 네임 서비스라고 한다.

리졸버(Resolver)로부터 요청 받은 도메인 이름에 대한 IP 정보를 다시 리졸버로 전달해주는 역할을 수행한다.

**Primary Name Server**: 는 해당 도메인을 관리하는 주 네임 서버이다.

**Secondary Name Server**: 는 primary 네임 서버 의 고장 등의 이유로 동작하지 못하는 경우 이를 대신하여 네임 서버 역할을 수행하는 서버이고 주기적으로 Primary 네임 서버로부터 정보를 받아와 자신의 정보를 갱신하여 전체 네임 서버의 정보가 일관성 있게 유지 및 관리된다.

### **3) 리졸버 (Resolver)**

웹 브라우저와 같은 DNS 클라이언트의 요청을 네임 서버로 전달하고 네임 서버로부터 정보(도메인 이름과 IP 주소)를 받아 클라이언트에게 제공하는 기능을 수행한다.

하나의 네임 서버 에게 DNS 요청을 전달하고 해당 서버에 정보가 없으면 다른 네임 서버에게 요청을 보내 정보를 받아 온다.

수많은 네임 서버에 접근하여 사용자로부터 요청 받은 도메인의 IP 정보를 조회하는 기능을 수행할 수 있어야 한다.

### **4) 스터브 리졸버(Stub Resolver)**

리졸버의 모든 기능을 PC와 같은 클라이언트 호스트에 구현하는 것은 단말 시스템 자원의 한 계와 같은 제약이 있다.

리졸버의 대부분의 기능을 DNS 서버에 구현하고, 클라이언트 호스트에는 리졸버의 단순한 기능만을 지닌 리졸버 루틴을 구현한것이다.

스터브 리졸버는 수 많은 네임 서버의 구조를 파악할 필요 없이 리졸버가 구현된 네임 서버의 IP 주소만 파악하면 된다.

도메인에 대한 질의를 받은 스터브 리졸버는 설정된 네임 서버로 DNS 질의를 전달하고 네임 서버로부터 최종 결과를 응답 받아 웹 브라우저로 전달하는 인터페이스 기능만을 수행한다.

================================================================

DNS 동작과정

![DNS%202c9a87a256d44a408dab357d0b4e614f.jpg](DNS%202c9a87a256d44a408dab357d0b4e614f.jpg)

**★ DNS 동작과정**

1. DNS Query (from Web Browser to Local DNS) : "제가 원하는 웹 사이트의 IP 주소를 알고 계신가요?" Local DNS 서버에게 전달

2. DNS Query (from Local DNS to Root DNS) : "제가 원하는 웹 사이트의 IP 주소를 알고 계신가요?" Root DNS서버에게 전달

3. DNS Response (from Root DNS to Local DNS) : "저는 모르지만 , Com 도메인을 관리하는 네임서버의 이름과 IP 주소를 알려드릴 테니 거기에 물어보세요"

4. DNS Query (from Local DNS to com NS) : “ 안녕하세요. www. naver. com의 IP 주소를 알고 계신가요?"

5. DNS Response (from com NS to Local DNS) : "저는 모르지만 , Com 도메인을 관리하는 네임서버의 이름과 IP 주소를 알려드릴 테니 거기에 물어보세요"

6. DNS Query (from Local DNS to naver. com NS) : “ 안녕하세요. www. Naver .com의 IP 주소를 알고 계신가요?"

7. DNS Response (from naver .com NS to Local DNS) : "저는 모르지만 해당 웹은 www. g.naver. com이라는 이름으로 통해요. g.naver .com 도메인을 관리하는 네임서버의 이름과 IP 주소를 알려드릴테니 거기에 물어보세요"

8. DNS Query (from Local DNS to g.naver. com NS) : “ 안녕하세요. www. g.naver. com의 IP 주소를 알고 계신가요?"

9. DNS Response (from g.naver .com NS to Local DNS) : " 네 www. g.naver .com의 IP 주소는 222.222.222.22와 333.333.333.33입니다"

10. DNS Response (from Local DNS to Web Browser) : "네 www. naver .com의 IP 주소는 222.222.222.22와 333.333.333.33입니다"

================================================================

### **5. FQDN (Full Qualified Domain Name: 정규화된 도메인 이름)**

네트워크상에서 컴퓨터시스템을 지칭하는 하나의 완전한 이름이다.

DNS의 서버이름을 hostname + domain name으로 표현된다.

Host name : 실제 서버에 주어진 컴퓨터의 이름이다. (www.naver)

Domain name : 논리적인 그룹을 표기한다. (.com)

================================================================

### **6. Zone 파일**

Domain을 소유한 특정 조직의 DNS 서버는 해당 Domain에 대한 Zone 파일(영역 파일)을 갖는다.

해당 Zone 파일에는 Resource Record라고 불리는 Domain 내부 정보가 존재하고, 해당 정보 조회를 허용하여

외부 Client에게 정보를 제공할 수 있다.

### **1) Resource Recode 종류**

SOA: 해당 Domain  관리 권한 및 Zone Transfer(영역 전송)과 관련된 정보가 들어있다.

NS: NameServer의 정보를 갖고 있다.

A(AAAA): 특정 host의 FQDN과 연결된 IP주소 정보를 갖는다.

CNAME: 특정 A레코드에 대한 별칭을 지정한다.

MX: Mail eXchange의 약자로 Mail 서비스에 관련된 정보를 갖고 있다. (해당 Domain의 Mail서버 정보)

PTR: 역방향 조회에 사용되는 레코드, 특정 IP주소에 대한 FQDN 정보를 가지고 있다.

ANY: 도메인에 대한 모든 레코드 질의 시에 주로 이용된다. (DNS 증폭 DRDOS 공격에 악용)

**영역 전송(Zone Transfer)이란?**

마스터에 있는 원본 영역 데이터를 슬레이브가 동기화하는 작업을 의미한다.

### **2) DNS 조회**

정방향 조회 : Domain Name을 사용하여 IP주소를 조회한다.

역방향 조회 : IP주소를 이용하여 Domain Name을 조회한다.

### **3) DNS 조회 절차**

**3.1) 우선순위**

**① 캐싱**

서버가 다른 서버에게 매핑 정보를 요청하고 응답을 수신하면 이 정보를 클라이언트에게 전달하기 위해 캐시 메모리에 저장한다.

주소 해석 속도를 높일 수 있지만 오랫동안 캐싱 정보를 가지고 있다면 클라이언트에게 잘못된 매핑 정보를 제공할 수 있다.

네거티브 캐싱을 지원한다.

**네거티브 캐싱이란?**

잘못된 도메인에 관한 요청을 캐싱하여 불필요한 트래픽과 지연을 줄인다.

**② /etc/hosts**

도메인/호스트명과 IP 주소 매핑정보를 담고있는 파일로 질의하기 이전에 먼저 참조되는 파일이다.

파밍 공격을 하기 위해서 해당 파일을 변조하는 사례가 많으므로 관리가 필요하다.

**③ DNS 서버**

**Recursive DNS 서버**: 동일한 작업을 조건이 만족할때까지 반복적으로 처리한다.

**Authoritative DNS 서버**: 관리/위임받은 도메인을 가지고 있는 네임서버를 말한다. (질의에 대한 응답만 수행)

### **3.2) Client PC에서 DNS 조회**

사용자가 Domain Name을 사용하여 특정 Host와 통신을 원하는 경우 Client PC는 hosts파일을 먼저 보고 DNS Cache(ipcofifg /displaydns에 해당 도메인 정보가 있는지 확인한다.

만약 Hosts 파일 혹은 DNS Cache에 해당 정보가 존재하는 경우 해당 정보를 사용하여 패킷을 전송한다.

패킷이 존재하지 않는 경우에는 자신이 알고 있는 Local DNS 서버에서 DNS Query 메세지를 전송한다.

### **3.3) Recursive Query를 수신한 Local DNS 조회**

해당 DNS Query를 수신한 서버는 자신의 Zone 파일(영역 파일) 정보인지 확인한다.

자신의 Zone 파일 정보가 맞는 경우에는 A레코드에 등록된 IP 주소로 응답한다.

자신의 Zone 파일 정보가 아닌 경우 DNS서버의 Cache 정보를 확인한다.

만약 Cache에 해당 정보가 등록되어 있는 경우 IP 주소를 Client에게 응답한다.

DNS 서버 Cache에 해당 정보가 없는 경우 Root hints를 참고하여 Root DNS 서버에게 Iterative Query를 전송하게 된다.

================================================================

마스터 DNS서버 구축 실습

```
# vi /etc/sysconfig/network-scripts/ifcfg-ens32

IPADDR=192.168.1.100

NETMASK=255.255.255.0

GATEWAY=192.168.1.1

DNS1=192.168.1.100
```

================================================================

**#패키지 다운로드**

```
# yum -y install bind-chroot bind bind-utils bind-libs
```

```
# vi /etc/named.conf

12 options {

13         listen-on port 53 { any; };

14         listen-on-v6 port 53 { none; };

15         directory       "/var/named";

16         dump-file       "/var/named/data/cache_dump.db";

17         statistics-file "/var/named/data/named_stats.txt";

18         memstatistics-file "/var/named/data/named_mem_stats.txt";

19         recursing-file  "/var/named/data/named.recursing";

20         secroots-file   "/var/named/data/named.secroots";

21         allow-query     { any; };
```

================================================================

**#도메인 생성**

```
# vi /etc/named.rfc1912.zones

shift + g를 눌러 맨 아래행으로 이동 도메인 추가

zone   "jh.com" IN {

type master ;

file "jh.com.zone";     //파일 이름

};

zone   "1.168.192.in-addr.arpa" IN {

type master ;

file "jhr.com.zone";    //역방향 파일이름

};

저장 후 종료

# named-checkconf /etc/named.conf    //문제가 없으면 에러가 뜨지 않습니다

#존 파일 생성

[root@localhost ~]# cd /var/named       //경로 이동

[root@localhost named]# ls -la      // 네임드 관련 파일이 네임드 그룹에 속한 것을 확인할 수 있습니다

[root@localhost named]# cp -pv  named.localhost jh.com.zone    // 권한 까지 그대로 복사

[root@localhost named]# cp -pv  named.loopback jh.com.zone
```

**named-checkconf**

- DNS설정시 /etc/named.rfc1912.zones 파일의 Syntax 에러를 점검해 주는 명령어(BIND 9.2 이하버전은 named.conf) 이다
- 사용방법은 [named-checkconf] [conf 파일]

================================================================

**#존파일 설정**

```
# vi jh.com.zone

$TTL 1D
@       IN SOA  @ ns.jh.com. (
                                        0       ; serial
                                        1D      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
        IN      NS      @
        IN      A       192.168.1.100
ns      IN      A       192.168.1.100
www     IN      A       192.168.1.100

# vi jhr.com.zone

$TTL 1D
@       IN SOA  @ ns.jh.com. (
                                        0       ; serial
                                        1D      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
        NS      @
        A       192.168.1.100
100     PTR     ns.jh.com.

```

**SOA(Start Of Authority)**

- **Serial(일련번호)** : 2차 네임서버가 zone 파일의 수정여부를 알 수 있도록 하기 위한 옵션
- **Refresh(새로고침)** : 1차 네임서버의 zone 파일 수정 여부를 2차 네임서버가 검사를 하기 위한 옵션
- **Retry(다시시도간격)** : 2차 네임서버에서 1차 네임서버로 연결이 되지 않을 경우 재 접속을 요구하는 옵션
- **Expire(다음날짜이후에만료)** : Secondary가 Expire에서 지정한 시간 동안 Primary에 연결하지 못 할 경우, 해당 도메인이 유효하지 않다고 보고, 해당 도메인에 대한 정보를 전송하지 않는 것
- **TTL** : DNS캐시에 살아있는 시간을 설정하는 것

================================================================

**#데몬 재시작**

```
# systemctl restart named

# systemcrl enable named

Created symlink from /etc/systemd/system/multi-user.target.wants/named.service to /usr/lib/systemd/system/named.service.
```

================================================================

```
# nslookup

> jh.com
Server:         192.168.1.100
Address:        192.168.1.100#53

Name:   [jh.com](http://jh.com/)
Address: 192.168.1.100

> ns.jh.com
Server:         192.168.1.100
Address:        192.168.1.100#53

Name:   [ns.jh.com](http://ns.jh.com/)
Address: 192.168.1.100
```

================================================================

**#named-checkzone 확인**

```
# named-checkzone jh.com /var/named/jh.com.zone
zone jh.com/IN: loaded serial 0
OK

# named-checkzone jh.com /var/named/jhr.com.zone
zone jh.com/IN: loaded serial 0
OK

named-checkzone
- zone 파일에 Syntax 에러를 점검해 주는 명령어이다.
- 사용방법은 [named-checkzone] [named.rfc1912.zones 파일에 설정된 zone 이름] [zone 파일 경로]
```

================================================================