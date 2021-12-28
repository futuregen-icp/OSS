# master DNS 서버

**DNS(Domain Name System)**

- hosts파일의 해결책/대안
- 서버가 IP주소와 관련된 모든 데이터를 가지고 있고 클라이언트의 질의가 있을때 응답한다.
- 계층적인 Tree 구조 (상위,하위 구조)
- 53번 포트 이용

> 일반질의 - udp 53

> 영역전송(Zone Transfer) - tcp 53

**Name Space 구조**

- Root Domain -> 최상위 도메인 -> 2차 도메인 -> 서브 도메인 -> ......
- 표준 관리기관은 **IANA**
- 우리나라는 KISA -> KRNIC

![https://blog.kakaocdn.net/dn/ckycI7/btqAYHqqaEd/uXrd7Rql5LJZpngR2hjpzK/img.png](https://blog.kakaocdn.net/dn/ckycI7/btqAYHqqaEd/uXrd7Rql5LJZpngR2hjpzK/img.png)

**1) Root Domain**

- Root Domain은 하위 계층(1단계)의 정보만 가지고 있다.
- 이름 해석의 출발지 역할
- **전 세계 13개의 원본 root 서버 존재**

우리나라는 4대의 mirror서버 운영중

: F루트 (KISA), J루트 (KT), M루트 (KINX), L루트 (KISA)

2020년 현재는 미러서버 7대 운영중

**2) 최상위 도메인(TLD : Top Level Domain)**

- 지정학적으로 분류하거나, 기관 유형 분류에 사용
- Root Domain에 TLD로 등록되어야한다.

[www.iana.org](http://www.iana.org/)/domains/root/db

- 국가코드 최상위 도메인 (country code TLD = ccTLD)

: .kr .jp .cn .us .uk 등

- 일반 최상위 도메인 (generic TLC = gTLD)

: Generic gTLD (.net .com .org 등)

: Sponsored gTLD (.edu .gov 등)

**3) 2차 도메인 (Second Level Domain , Sub Domain)**

- TLD 하위에서 관리되는 서브 도메인
- **국가 도메인** 하위에 기관 유형별로 분류된다.

: .co(일반회사), .ac(교육기관) .re(연구기관) .go (정부기관) .nm (네트워크관리)

**4) 서브 도메인**

- 상위 도메인에 속한 각 기관 또는 회사별 도메인
- 하위 도메인으로 호스트, 내부조직 도메인 등이 구성될 수 있다.

: google , naver , daum 등

![https://blog.kakaocdn.net/dn/bVwyUv/btqAYqvHDe5/N4z3FxbpjSwwbqNYwmzvIK/img.png](https://blog.kakaocdn.net/dn/bVwyUv/btqAYqvHDe5/N4z3FxbpjSwwbqNYwmzvIK/img.png)

### DNS - Resolver

**리졸버 (Resolver)**

- OS 내부적으로 만들어져있는 프로그램
- **도메인 주소 해석 수행**
- 사용자 요청에 대한 이름 해석 방법 : **1)** **hosts 파일 2) DNS 질의 3) DNS Cache(임시 저장)**
- 순서

**: DNS cache -> DNS 질의**

(hosts파일에 있는 내용은 DNS Cache에도 있어서 잘 안쓰인다.)

**# DNS Cache**

- DNS Cache가 지워지는 시간은 TTL에 따라 다르다.
- 강제 삭제 : ipconfig /flushdns

(hosts파일 값은 지워지지않는다)

**# 네임서버 (Name Server)**

- 클라이언트의 요청에 대한 이름해석 결과를 전달하는 시스템
- Domain 정보 데이터베이스 : **Zone File**
- **종류**

1) 마스터 네임 서버 (Master Name Server, Primary Name Server)

- Zone Database 직접 구축하는 서버
- Zone Database에 권한을 가지고 있는 서버이다.

2) 보조 네임 서버 (Slave Name Server, Secondary Name Server)

- 마스터 네임 서버의 Zone 정보를 복사하여 Database 구성
- 단, 마스터 네임 서버의 **백업 서버가 아니다.**

**(마스터 서버와 동시에 서비스하지만 Zone에 대한 정보만 동기화 받을 뿐이다)**

(주기적으로 동기화하여 마스터 서버와 동일한 정보를 유지한다)

3) 전달자(forward)

**#  설정 방법**

환경설정 파일

1) /etc/named.conf

- BIND 데몬의 동작에 관련된 설정파일

2) /etc/named.rfc1912.zones

- 네임서버가 해석을 지원할 수 있는 zone을 등록하는 파일

3) /var/named/정방향 zone파일

- 이름 -> IP

**환경설정 순서**

1) dns 서버의 동작환경 설정 (/etc/named.conf)

2) zone 등록 및 서버 역할 설정 (/etc/named.rfc1912.zones)

3) zone 파일 생성 (/var/named)

4) 서비스 재시작

**1) vim /etc/named.conf**

![https://blog.kakaocdn.net/dn/AGLhV/btqAWb7HwgH/upiWuum9BGN2UrMK6NmEE0/img.png](https://blog.kakaocdn.net/dn/AGLhV/btqAWb7HwgH/upiWuum9BGN2UrMK6NmEE0/img.png)

- listen-on-v6는 쓰지 않으므로 주석화 한다.
- DNS 요청에 대한 응답 서버로 listen-on port 53 { 20.20.75.10; };로 IP를 변경한다.
- allow-query 값을 any로 변경한다. ( 어떤 클라이언트에 대해 질의를 허용할것인가 )
- dnssec-enable, dnssec-validation 값을 no로 변경한다. (인증서가 없이 실습하기 때문, 허용하면 질의가 안된다.)
- /etc/named.root.key 값을 주석화

**# DNS SERVER 구성**

1) zone의 가장 처음은 **SOA 레코드로 시작**

2) SQA 레코드 다음으로 **NS 레코드 명시**

3) 다음 레코드부터는 정책에 맞게 구성

![https://blog.kakaocdn.net/dn/eVKtOE/btqAXhmrFvM/uHf2BEwLq20rukX4zC9g01/img.png](https://blog.kakaocdn.net/dn/eVKtOE/btqAXhmrFvM/uHf2BEwLq20rukX4zC9g01/img.png)

- Name : 요청 받을 정보 (레코드 데이터를 구분할 이름)
- TTL : 서버가 클라이언트에게 Cache 되는 시간을 정해서 준다.
- Class : 동작할 네트워크 환경 - 보통 IN이 들어간다. (internet 환경)
- Record Type : 리소스 레코드 종류 식별
- option : 레코드 종류에 따라 필요한 값
- data : 응답해줄 실제 값

리소스 레코드 (RR)

![https://blog.kakaocdn.net/dn/cv0u93/btqAWyPxEjp/OkL5lv7yMQqzOGMSKBxSrk/img.png](https://blog.kakaocdn.net/dn/cv0u93/btqAWyPxEjp/OkL5lv7yMQqzOGMSKBxSrk/img.png)

SOA 레코드

![https://blog.kakaocdn.net/dn/pqGTF/btqAYoZveXx/xtigG2oCo511YLdWAcDWc1/img.png](https://blog.kakaocdn.net/dn/pqGTF/btqAYoZveXx/xtigG2oCo511YLdWAcDWc1/img.png)

- [ ](대괄호) : 생략 가능

**# /var/named/poopoo.zone**

![https://blog.kakaocdn.net/dn/bHojUr/btqAYqbXxeM/WDqhzy0wQ91TQWgXl9Bf61/img.png](https://blog.kakaocdn.net/dn/bHojUr/btqAYqbXxeM/WDqhzy0wQ91TQWgXl9Bf61/img.png)

- $ 표시는 환경변수
- D,H,W

D(DAY) : 시간정보

H(Hour) : 시간

W(Week) : 주

- $TTL 1D (하루) : TTL을 생략하면 이 디폴트값(1D)으로 설정됨.

## **작성할때 SOA레코드 타입으로 시작해야 함.**

**SOA 레코드**

![https://blog.kakaocdn.net/dn/pqGTF/btqAYoZveXx/xtigG2oCo511YLdWAcDWc1/img.png](https://blog.kakaocdn.net/dn/pqGTF/btqAYoZveXx/xtigG2oCo511YLdWAcDWc1/img.png)

![https://blog.kakaocdn.net/dn/dXXLNd/btqAZOpDFdr/ZqoZj9Kccu0SSfICh4aE6k/img.png](https://blog.kakaocdn.net/dn/dXXLNd/btqAZOpDFdr/ZqoZj9Kccu0SSfICh4aE6k/img.png)

![https://blog.kakaocdn.net/dn/CgLL2/btqAVHsEdwL/PgvkJV5caG1TKvSK2w8ua0/img.png](https://blog.kakaocdn.net/dn/CgLL2/btqAVHsEdwL/PgvkJV5caG1TKvSK2w8ua0/img.png)

data - 동기화 설정값

- **@[TTL] IN(Class) SOA(RR) FQDN(네임서버도메인주소/관리자이메일주소)**

**예) @        IN          SOA        ns1.poopoo.com. (루트)  admin.poopoo.com. (루트) {**

2020010800 ;serial(data)

- @ 기호로 rfc1912.zones의 도메인이름 poopoo.com.zone을 읽어온다.
- FQDN(보통 웹서비스 담당은 **WWW** 이름을,

네임서버 중에서 주 DNS서버는 **NS1** 이름을 붙인다.)

- type은 SOA
- FQDN은 네임서버 도메인주소 / 관리자 이메일주소 둘다 기록
- data : 동기화설정값

---

![https://blog.kakaocdn.net/dn/b6o4a7/btqAYpqyWel/X4kKOQ6x7qhXC2tm5TdbT0/img.png](https://blog.kakaocdn.net/dn/b6o4a7/btqAYpqyWel/X4kKOQ6x7qhXC2tm5TdbT0/img.png)

리소스레코드의 TTL값은 생략가능하지만

환경변수의 TTL

레코드의 TTL

DATA의 TTL 이 있다면

**1) 레코드의 TTL**

**2) 환경변수의 TTL**

**3) DATA의 TTL**

**순차 대로 TTL이 적용된다**

---

- **현재 도메인의 네임서버의 이름을 알려주는 레코드를 만들어보자.**

![https://blog.kakaocdn.net/dn/cv0u93/btqAWyPxEjp/OkL5lv7yMQqzOGMSKBxSrk/img.png](https://blog.kakaocdn.net/dn/cv0u93/btqAWyPxEjp/OkL5lv7yMQqzOGMSKBxSrk/img.png)

![https://blog.kakaocdn.net/dn/bmTqJc/btqAYHkdTxO/FXzYxxuKhBnPa7NZ9kY781/img.png](https://blog.kakaocdn.net/dn/bmTqJc/btqAYHkdTxO/FXzYxxuKhBnPa7NZ9kY781/img.png)

![https://blog.kakaocdn.net/dn/bb0vpk/btqAYoZwZLo/6QSkbcwQozN2i6TxE7KUI1/img.png](https://blog.kakaocdn.net/dn/bb0vpk/btqAYoZwZLo/6QSkbcwQozN2i6TxE7KUI1/img.png)

<DNS Server 구성>

//bind 설치

[root@server ~]# yum -y install bind*

//named 데몬 실행 및 확인

[root@server ~]# systemctl start named

[root@server ~]# systemctl status named

```jsx
//bind 구성

[root@server ~]# vi /etc/named.conf

options {

        listen-on port 53 { any; };   << ipv4 접근허용

        listen-on-v6 port 53 { any; };    << ipv6 접근허용

        directory       "/var/named";

        dump-file       "/var/named/data/cache_dump.db";

        statistics-file "/var/named/data/named_stats.txt";

        memstatistics-file "/var/named/data/named_mem_stats.txt";

        recursing-file  "/var/named/data/named.recursing";

        secroots-file   "/var/named/data/named.secroots";

        allow-query     { any; };   << dns query 접근허용
// DNS 방화벽 포트 및 서비스 추가설정

[root@server ~]# firewall-cmd --permanent --zone=public --add-port=53/tcp << 포트추가

success

[root@server ~]# firewall-cmd --permanent --zone=public --add-service=dns << 서비스추가

success

[root@server ~]# firewall-cmd --reload << 적용

success

```

```jsx
// 영역(zone) 파일생성

 

1. 정방향조회 zone 생성

[root@server ~]# cd /var/named

[root@server named]# cp -a named.localhost nobreak.co.kr.zone
[root@server named]# vi nobreak.co.kr.zone

$TTL 1D

@       IN SOA  ns.nobreak.co.kr. root.nobreak.co.kr. (

                                        0       ; serial

                                        1D      ; refresh

                                        1H      ; retry

                                        1W      ; expire

                                        3H )    ; minimum

              NS              ns.nobreak.co.kr.

               IN      A       192.168.10.10    <<  DNS 주소

ns           IN      A       192.168.10.10

www     IN      A       192.168.10.10

ftp         IN      A       192.168.10.20
```

```jsx
2. 역방향조회 zone 생성

 

[root@server named]# cp -a nobreak.co.kr.zone db.192.168.10

[root@server named]# vi db.192.168.10

$TTL 1D

@       IN SOA  ns.nobreak.co.kr. root.nobreak.co.kr. (

                                        0       ; serial

                                        1D      ; refresh

                                        1H      ; retry

                                        1W      ; expire

                                        3H )    ; minimum

          NS                 ns.nobreak.co.kr.

          IN      PTR     nobreak.co.kr.

10      IN      PTR     ns.nobreak.co.kr.

10      IN      PTR     www.nobreak.co.kr.

20      IN      PTR     ftp.nobreak.co.kr.

 

**** 참고 : 메일기본항목 란에 주소가 없을 경우 named-checkzone 시 유효하지 않는 값의 오류가 뜬다.

// named.rfc1912.zones 영역추가

[root@server named]# vi /etc/named.rfc1912.zones

 

---- 맨 하단부 이동 후 내용작성

zone "nobreak.co.kr" IN { << 정방향

        type master;

        file "nobreak.co.kr.zone";

};

 

zone "10.168.192.in-addr.arpa" IN { << 역방향

        type master;

        file "db.192.168.10";

};

 

// named 데몬 재시작

[root@server named]# systemctl restart named

// dns server test

[root@server named]# nslookup nobreak.co.kr << 정방향 조회

Server: 192.168.10.10

Address: 192.168.10.10#53

 

Name: nobreak.co.kr

Address: 192.168.10.10

 

[root@server named]# nslookup 192.168.10.10 << 역방향 조회

10.10.168.192.in-addr.arpa name = ns.nobreak.co.kr.

10.10.168.192.in-addr.arpa name = www.nobreak.co.kr.

 

[root@server named]# nslookup 192.168.10.20

20.10.168.192.in-addr.arpa name = ftp.nobreak.co.kr.
```

```jsx
<master DNS 서버 구성>

 

// named.rfc1912.zones 파일 수정

[root@server named]# vi /etc/named.rfc1912.zones

 

---- 맨 하단부 이동 후 내용수정

zone "nobreak.co.kr" IN {

        type master;

        file "nobreak.co.kr.zone";

allow-transfer { 192.168.10.20; }; << client IP 추가

};

 

zone "10.168.192.in-addr.arpa" IN {

        type master;

        file "db.192.168.10";

allow-transfer { 192.168.10.20; }; << client IP 추가

};

// slave DNS named.rfc1912.zones 파일 수정

[root@client ~]# cd /var/named

[root@client named]# vi /etc/named.rfc1912.zones

 

---- 맨 하단부 이동 후 내용 작성

zone "nobreak.co.kr" IN {

        type slave;

        masters { 192.168.10.10; };

        file "slaves/nobreak.co.kr.slave";

};

 

zone "10.168.192.in-addr.arpa" IN {

        type master;

        masters { 192.168.10.10; };

        file "slaves/db.192.168.10.slave";

};

// named 데몬 재시작

[root@client named]# systemctl restart named

 

// slaves 디렉터리 내 파일생성 확인

[root@client named]# ls -l slaves/

total 4

-rw-r--r--. 1 named named 349 Apr 15 23:22 nobreak.co.kr.slave

 

**** master DNS - slave DNS server 개념 : 마스터 - 클라이언트에 양방향으로 구성이되면

master의 named 서비스가 장애로 인해 중단이 되어도 slave의 named 서비스가 실행중이므로

192.168.10.10 의 dns가 중지되지 않고 사용이 가능하다.

// master DNS named stop 후 slave에서 dns 서비스 확인하기

[root@server named]# systemctl stop named

 

[root@client named]# nslookup 

> server

Default server: 192.168.10.10

Address: 192.168.10.10#53

Default server: 192.168.10.20

Address: 192.168.10.20#53

> nobreak.co.kr

Server: 192.168.10.20 << **** 참고

Address: 192.168.10.20#53

 

Name: nobreak.co.kr

Address: 192.168.10.10

 

**** 참고 : master dns server의 named 서비스 중지로 인한 slave(client pc) dns가 작동하여

해당 dns 정보를 정/역방향 조회가 가능하다. 기본 default server는 slave nameserver로 작동한다.

 

**** tip : master-slave dns server를 구성하게 되면 아래를 보고 설정해야한다.

-- master-dns(server-pc) : dns1 : 192.168.10.10 // dns2 : 192.168.10.20

-- slave-dns(client-pc)  : dns1 : 192.168.10.20 // dns2 : 192.168.10.10
```

<master DNS 서버 구성>

// named.rfc1912.zones 파일 수정

[root@server named]# vi /etc/named.rfc1912.zones

- --- 맨 하단부 이동 후 내용수정

zone "nobreak.co.kr" IN {

type master;

file "nobreak.co.kr.zone";

allow-transfer { 192.168.10.20; }; << client IP 추가

};

zone "10.168.192.in-addr.arpa" IN {

type master;

file "db.192.168.10";

allow-transfer { 192.168.10.20; }; << client IP 추가

};

---

// slave DNS named.rfc1912.zones 파일 수정

[root@client ~]# cd /var/named

[root@client named]# vi /etc/named.rfc1912.zones

- --- 맨 하단부 이동 후 내용 작성

zone "nobreak.co.kr" IN {

type slave;

masters { 192.168.10.10; };

file "slaves/nobreak.co.kr.slave";

};

zone "10.168.192.in-addr.arpa" IN {

type master;

masters { 192.168.10.10; };

file "slaves/db.192.168.10.slave";

};

---

// named 데몬 재시작

[root@client named]# systemctl restart named

---

// slaves 디렉터리 내 파일생성 확인

[root@client named]# ls -l slaves/

total 4

- rw-r--r--. 1 named named 349 Apr 15 23:22 nobreak.co.kr.slave
- *** master DNS - slave DNS server 개념 : 마스터 - 클라이언트에 양방향으로 구성이되면

master의 named 서비스가 장애로 인해 중단이 되어도 slave의 named 서비스가 실행중이므로

192.168.10.10 의 dns가 중지되지 않고 사용이 가능하다.

---

// master DNS named stop 후 slave에서 dns 서비스 확인하기

[root@server named]# systemctl stop named

[root@client named]# nslookup

> server

Default server: 192.168.10.10

Address: 192.168.10.10#53

Default server: 192.168.10.20

Address: 192.168.10.20#53

> nobreak.co.kr

Server: 192.168.10.20 << **** 참고

Address: 192.168.10.20#53

Name: nobreak.co.kr

Address: 192.168.10.10

- *** 참고 : master dns server의 named 서비스 중지로 인한 slave(client pc) dns가 작동하여

해당 dns 정보를 정/역방향 조회가 가능하다. 기본 default server는 slave nameserver로 작동한다.

- *** tip : master-slave dns server를 구성하게 되면 아래를 보고 설정해야한다.
- - master-dns(server-pc) : dns1 : 192.168.10.10 // dns2 : 192.168.10.20
- - slave-dns(client-pc) : dns1 : 192.168.10.20 // dns2 : 192.168.10.10