# apache -tomcat 연동

[참고글](apache%20-tomcat%20%E1%84%8B%E1%85%A7%E1%86%AB%E1%84%83%E1%85%A9%E1%86%BC%2051710df64ca64419a4fcf393e54f2ba8/%E1%84%8E%E1%85%A1%E1%86%B7%E1%84%80%E1%85%A9%E1%84%80%E1%85%B3%E1%86%AF%20ee9203dafe69489c87c47d35dd9063ee.md)

- **Apache 2.4.6 / Tomcat 9.0.31 설치**

우선 아래 selinux를 해제 해주시고 firewalld 중지 시켜줍니다. (사용하실분은 정책 넣어주세요.)

```
# firewalld 중지
systemctl stop firewalld
systemctl disabled firewalld

# firewalld 실행시 
[root@web ~]# firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: ens33
  sources:
  services: dhcpv6-client http https ssh
  ports: 80/tcp 8010/tcp 9010/tcp 8009/tcp 8443/tcp 8080/tcp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

# selinux 중지
setenforce 0

vi /etc/sysconfig/selinux
SELINUX=disabled

/ apache 2.4.6 버전과 tomcat-connector 설치
## 필요 패키지 설치 ## 
yum install httpd httpd-devel gcc gcc-c++

# tomcat-connector 설치 (mod_jk)
wget http://apache.mirror.cdnetworks.com/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.46-src.tar.gz
tar zxvf tomcat-connectors-1.2.46-src.tar.gz
cd tomcat-connectors-1.2.46-src/native/
./configure --with-apxs=/bin/apxs
make
make install

## /usr/lib64/httpd/modules/mod_jk.so 파일이 존재하지 않을 경우 아래 내용 실행
cp -p mod_jk.so /usr/lib64/httpd/modules/mod_jk.so
chmod 755 /usr/lib64/httpd/modules/mod_jk.so
```

```jsx
아래 코드를 입력하여 jdk와 tomcat 9.0.31 설치 해줍니다.

# JDK 설치
yum -y update
yum install java-1.8.0-openjdk-devel.x86_64

# JDK 환경 변수 설정
vi /etc/profile

# 맨 아래에 내용 작성
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH
:wq

# 설정 내용 적용
source /etc/profile

# 1.8.0 으로 재대로 출력 되는지 확인
java -version

# tomcat 9.0.31 설치
wget http://mirror.navercorp.com/apache/tomcat/tomcat-9/v9.0.31/bin/apache-tomcat-9.0.31.tar.gz
tar zxvf apache-tomcat-9.0.31.tar.gz
mv apache-tomcat-9.0.31 /usr/local/tomcat9
```

```jsx
[root@web native]# find / -name "mod_jk.so"
/usr/lib64/httpd/modules/mod_jk.so
/usr/local/src/tomcat-connectors-1.2.48-src/native/apache-2.0/.libs/mod_jk.so
/usr/local/src/tomcat-connectors-1.2.48-src/native/apache-2.0/mod_jk.so
```

```jsx
Apache-Tomcat 로드밸런싱 설정

1. Apache 설정
아래 설정은 URL에 .jsp로 끝나는 모든것은 loadbalancer 를 사용하도록 합니다. loadbalancer는 사용자 임의로 정할 수 있습니다. (파일 경로 : /etc/httpd/conf/httpd.conf )

LoadModule jk_module /usr/lib64/httpd/modules/mod_jk.so

<IfModule jk_module>
   JkWorkersFile /etc/httpd/conf/workers.properties
   JkLogFile /var/log/httpd/mod_jk.log
   JkLogLevel info
   JkLogStampFormat "[%a %b %d %H:%M:%S %Y]"
   JkMount /*.jsp loadbalancer
</IfModule>
 

worker.list로 로드밸런싱을 사용할 tomcat을 묶어줍니다. 위의 /*.jsp 뒤에 사용한 이름을 작성해주어야 합니다.

host는 tomcat ip를 적고 port는 ajp를 사용할 포트를 정해 줍니다. 임의로 설정 가능 합니다.

lbfactor는 로드밸런싱을 얼마나 할지를 정하는데, 모두 1로 정하면 라운드로빈(roundrobin) 방식 으로 로드 밸런싱되며 각각의 톰캣별로 로드밸런싱할 비율을 정해줄 수 있습니다. (파일 경로 : /etc/httpd/conf/httpd.confworkers.properties )

worker.list=loadbalancer

worker.loadbalancer.type=lb
worker.loadbalancer.balanced_workers=worker1,worker2
worker.loadbalancer.sticky_session=1

worker.worker1.type=ajp13
worker.worker1.host=192.168.222.111
worker.worker1.port=8010
worker.worker1.lbfactor=1

worker.worker2.type=ajp13
worker.worker2.host=192.168.222.112
worker.worker2.port=9010
worker.worker2.lbfactor=1
 

이것으로 apache 설정은 모두 종료 되었으니 systemctl restart httpd 입력하여 옵션을 적용 시켜주세요.
```

- **2. tomcat 설정**

vi /etc/tomcat/server.xml 후 아래와 같이 설정 해줍니다. 저의 경우 apache 에서 설정한대로 192.168.222.111은 8010, 192.168.222.112 은 9010 포트를 사용해야하므로 각 서버에 맞게 포트를 할당 합니다.

또한 address="0.0.0.0" 와 SSL설정을 하지 않을것이므로 secretRequired="false" 을 넣었습니다. (tomcat 최신 버전에만 해당 합니다.)

![https://blog.kakaocdn.net/dn/ySv0L/btqCn0bYkFJ/FNgpiJC4DFP43JJFbIBs21/img.png](https://blog.kakaocdn.net/dn/ySv0L/btqCn0bYkFJ/FNgpiJC4DFP43JJFbIBs21/img.png)

이후 /usr/local/tomcat9/bin/startup.sh을 입력하여 톰캣 실행 후 http://[apache ip]/index.jsp 로 접근하여 로드 밸런싱을 확인 하시면 되고, 저는 apache 설정에서 tomcat 을 모두 lbfactor=1을 주었으므로 라운드로빈 방식으로 동작하게 되어 엔터를 한번 칠때마다 아래 이미지처럼 번갈아가며 출력 됩니다.

로드밸런싱 확인 시 각 서버별로 /var/lib/tomcat/webapps/ROOT 디렉토리에 jsp 파일을 조금씩 다르게 설정하여 확인하시는게 편합니다.

httpd.conf 파일의 mod_jk 설정 부분에 아래의 설정을 추가하면 로그로도 확인할 수 있다.

**JkRequestLogFormat "%w %R %V %T %U %q"**

Apache logs 디렉터리의 mod_jk.log 파일 내용에 request 처리 내역이 추가된다.

![https://blog.kakaocdn.net/dn/bPn8z5/btqEHwAxRQv/SUmVORMw8dPM2zSJxzVmY0/img.png](https://blog.kakaocdn.net/dn/bPn8z5/btqEHwAxRQv/SUmVORMw8dPM2zSJxzVmY0/img.png)

# 세션 클러스터링

[tomcat_clustering [AllThatLinux!]](https://atl.kr/dokuwiki/doku.php/tomcat_clustering)

# 클러스터링 사전 요구사항

- web.xml 내에 `<distributable/>` 선언 필수
- Session attributes는 반드시 `java.io.Serializable`을 구현해야합니다. 만약 그렇지 않다면 `sessionAttributeFilter`를 사용할 수 있습니다.
- `DeltaManager`를 사용하는 경우에는 `org.apache.catalina.ha.session.ClusterSessionListener`가 필요합니다.

1. Tomcat Session Clustering 간 Multicast를 위한 라우팅 설정이 필요하다.

```jsx
# route add -net 224.0.0.0 netmask 240.0.0.0 dev ens34(디바이스명)
# ifconfig ens34 multicast 멀티캐스트 허용  
# ss -nt // session 확인
# lsof -i 
# 확인
[root@worker2 ~]# netstat -nr
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         192.168.222.2   0.0.0.0         UG        0 0          0 ens33
0.0.0.0         172.16.1.2      0.0.0.0         UG        0 0          0 ens34
172.16.1.0      0.0.0.0         255.255.255.0   U         0 0          0 ens34
192.168.222.0   0.0.0.0         255.255.255.0   U         0 0          0 ens33
224.0.0.0       0.0.0.0         240.0.0.0       U         0 0          0 ens34

[root@worker2 ~]# tcpdump -i ens34 -n -v ip multicast
tcpdump: listening on ens34, link-type EN10MB (Ethernet), capture size 262144 bytes
18:20:13.408582 IP (tos 0x0, ttl 1, id 43457, offset 0, flags [DF], proto UDP (17), length 105)
    172.16.1.111.45564 > 228.0.0.4.45564: UDP, length 77
18:20:13.409577 IP (tos 0x0, ttl 1, id 53558, offset 0, flags [DF], proto UDP (17), length 105)
    172.16.1.112.45564 > 228.0.0.4.45564: UDP, length 77
18:20:13.909849 IP (tos 0x0, ttl 1, id 43836, offset 0, flags [DF], proto UDP (17), length 105)
    172.16.1.111.45564 > 228.0.0.4.45564: UDP, length 77
18:20:13.910104 IP (tos 0x0, ttl 1, id 53833, offset 0, flags [DF], proto UDP (17), length 105)
    172.16.1.112.45564 > 228.0.0.4.45564: UDP, length 77
18:20:14.410959 IP (tos 0x0, ttl 1, id 53896, offset 0, flags [DF], proto UDP (17), length 105)
```

1. Session Clustering에 사용되는 포트를 방화벽에서 허가해줘야 한다.

CentOS 7의 경우에는 아래의 명령어를 실행한다.

```
firewall-cmd --permanent --zone=public --add-port=45564/tcp
firewall-cmd --permanent --zone=public --add-port=45564/udp # session 상태 228.0.0.4 로 공유
firewall-cmd --permanent --zone=public --add-port=4000-4100/tcp # 수신 
firewall-cmd --reload
```

**3. Apache workers.properties 파일에서 Sticky Session이 활성 되어있는지 확인한다.**

기본값이 TRUE이기 때문에 아래와 같이 반드시 명시할 필요는 없다.

false 또는 0 으로 되어있을 경우 true 또는 1로 변경한다.

```jsx
[root@web ~]# cat /etc/httpd/conf/workers.properties
worker.list=loadbalancer =>클러스터 멤버 그룹

worker.loadbalancer.type=lb
worker.loadbalancer.balanced_workers=worker1,worker2
worker.loadbalancer.sticky_session=1

worker.worker1.type=ajp13
worker.worker1.host=172.16.1.111
worker.worker1.port=8010
worker.worker1.lbfactor=1

worker.worker2.type=ajp13
worker.worker2.host=172.16.1.112
worker.worker2.port=9010
worker.worker2.lbfactor=1
[root@web ~]#
```

## tomcat 설정

**1. server.xml <Engine> 내 jvmRoute 요소 설정**

위의 workers.properties 파일에서 로드밸런싱할 톰캣의 이름을 각각 worker1, worker2로 설정했었다.

각각의 Tomcat 서버에 jvmRoute 값을 worker1, worker2로 설정한다.

![https://blog.kakaocdn.net/dn/bLbnQP/btqGrd6zqY9/VcWUXKqFLxnkBNjba40f8K/img.png](https://blog.kakaocdn.net/dn/bLbnQP/btqGrd6zqY9/VcWUXKqFLxnkBNjba40f8K/img.png)

jvmRoute 값은 각 Tomcat 인스턴스의 라우팅 식별자로 사용되며, 설정 시 아래와 같이 세션 ID 값에 xxxxxx.${jvmRoute} 로 추가되어 표시된다.

![https://blog.kakaocdn.net/dn/moQr9/btqGrj6y6yc/ZvJY5F8D1GTgcDWlWuYlk0/img.png](https://blog.kakaocdn.net/dn/moQr9/btqGrj6y6yc/ZvJY5F8D1GTgcDWlWuYlk0/img.png)

1.  server.xml <host> 하위에 <cluster> 설정
- multicast 방식으로 동작하며 address는 ‘228.0.0.4’, port는 ‘45564’를 사용하고 서버 IP는 `java.net.InetAddress.getLocalHost().getHostAddress()`로 얻어진 IP 값으로 송출됩니다.

```jsx
[root@worker1 ~]# cat /etc/tomcat/server.xml
<?xml version='1.0' encoding='utf-8'?>

    <!-- Define an AJP 1.3 Connector on port 8009 -->
    <Connector port="8010" address="0.0.0.0" secretRequired="false" protocol="AJP/1.3" redirectPort="8443" />

    <!-- An Engine represents the entry point (within Catalina) that processes
         every request.  The Engine implementation for Tomcat stand alone
         analyzes the HTTP headers included with the request, and passes them
         on to the appropriate Host (virtual host).
         Documentation at /docs/config/engine.html -->

    <!-- You should set jvmRoute to support load-balancing via AJP ie :
    <Engine name="Catalina" defaultHost="localhost" jvmRoute="jvm1">
    -->
<!-- worekr2 에도 (jvmRoute 2 로 변경)동일하게 설정 
    -->
    <Engine name="Catalina" defaultHost="localhost" jvmRoute="worker1">

      <!--For clustering, please take a look at documentation at:
          /docs/cluster-howto.html  (simple how to)
          /docs/config/cluster.html (reference documentation) -->
      <!--
      <Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"/>
      -->

      <!-- Use the LockOutRealm to prevent attempts to guess user passwords
           via a brute-force attack -->
      <Realm className="org.apache.catalina.realm.LockOutRealm">
        <!-- This Realm uses the UserDatabase configured in the global JNDI
             resources under the key "UserDatabase".  Any edits
             that are performed against this UserDatabase are immediately
             available for use by the Realm.  -->
        <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
               resourceName="UserDatabase"/>
      </Realm>

      <Host name="localhost"  appBase="webapps"
            unpackWARs="true" autoDeploy="true">

        <!-- SingleSignOn valve, share authentication between web applications
             Documentation at: /docs/config/valve.html -->
        <!--
        <Valve className="org.apache.catalina.authenticator.SingleSignOn" />
        -->

        <!-- Access log processes all example.
             Documentation at: /docs/config/valve.html
             Note: The pattern used is equivalent to using pattern="common" -->
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log." suffix=".txt"
               pattern="%h %l %u %t &quot;%r&quot; %s %b" />

      </Host>
<Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"
                 channelSendOptions="8">
<!-- channelSendOptions 값이 6:동기 방식 8:비동기 방식
        8:비동기 방식 사용시 Receiver의 selectorTimeout을 5000(5초) 이상으로 설정 권장 -->

				<!-- Delta Manager -->
          <Manager className="org.apache.catalina.ha.session.DeltaManager"
                   expireSessionsOnShutdown="false"
                   notifyListenersOnReplication="true"/>

          <Channel className="org.apache.catalina.tribes.group.GroupChannel">
            <Membership className="org.apache.catalina.tribes.membership.McastService"
<!-- Membershipe 절에 address=228.0.0.4", port=45564" 두요소는 클러스터멤버쉽을 구성 -->
                        address="228.0.0.4"~
                        port="45564"
                        frequency="500"
                        dropTime="3000"/>
            <Receiver className="org.apache.catalina.tribes.transport.nio.NioReceiver"
                      address="172.16.1.111"
                      port="4000"
                      autoBind="100"
                      selectorTimeout="5000"
                      maxThreads="6"/>

            <Sender className="org.apache.catalina.tribes.transport.ReplicationTransmitter">
              <Transport className="org.apache.catalina.tribes.transport.nio.PooledParallelSender"/>
            </Sender>

						<!-- 이 인터셉터는 모든 노드에 핑으로 체크를 해주는 인터셉터이다.
                 이 인터셉터는 다른 노드가 클러스터를 떠났을 때 모든 노드가 인식 할 수 있도록 다른 노드를 ping 체크한다.
                 이 클래스가 없으면 클러스터가 제대로 작동하는 것처럼 보일 수 있지만 노드를 제거하고 다시 도입하면 세션 복제가 중단 될 수 있다.
                 TcpFailureDetector보다 위쪽에 위치하여야 한다. -->
			<!--	<Interceptor className="org.apache.catalina.tribes.group.interceptors.TcpPingInterceptor"/> -->

<!-- 멤버간 데이터 통신 오류 또는 시간 초과등의 문제가 발생하였을시 감지하는 인터셉터 -->
            <Interceptor className="org.apache.catalina.tribes.group.interceptors.TcpFailureDetector"/>
            <Interceptor className="org.apache.catalina.tribes.group.interceptors.MessageDispatchInterceptor"/>
          </Channel>
<!-- 해당 필터에 포함되는 요청은 세션데이터 갱신에서 제외한다 -->
          <Valve className="org.apache.catalina.ha.tcp.ReplicationValve"
                 filter=""/>

<!-- route 변경시 현재 jvmRoute를 변경해주는 밸브.
               이게 없는경우 route가 변경되어도 jvmRoute값이 유지되어 failback효과를 유도한다 -->
          <Valve className="org.apache.catalina.ha.session.JvmRouteBinderValve"/>
<!-- 클러스터 노드간 자동배포를 위한 디플로이어 일반적으로 사용하지 않으며 <Host 엘리먼트에 넣어야 정상 동작함
          <Deployer className="org.apache.catalina.ha.deploy.FarmWarDeployer"
                    tempDir="/tmp/war-temp/"
                    deployDir="/tmp/war-deploy/"
                    watchDir="/tmp/war-listen/"
                    watchEnabled="false"/>
<!-- DeltaManager 사용시 필요함 -->
          <ClusterListener className="org.apache.catalina.ha.session.ClusterSessionListener"/>
        </Cluster>
    </Engine>
  </Service>
</Server>
[root@worker1 ~]#
```

- 먼저 구동되는 서버부터 4000 ~ 4100 사이의 TCP port를 통해 reqplication message를 listening합니다.
- Listener는 `ClusterSessionListener`, interceptor는 `TcpFailureDetector`와 `MessageDispatchInterceptor`가 설정됩니다.

**3. 어플리케이션 디렉터리 WEB-INF/web.xml에 <distributable /> 태그를 삽입한다.**

vim /var/lib/tomcat/webapps/ROOT/WEB-INF/web.xml

![https://blog.kakaocdn.net/dn/RZaiH/btqGpxqWH7L/pbrJttvzZeipYf8XJKl7zk/img.png](https://blog.kakaocdn.net/dn/RZaiH/btqGpxqWH7L/pbrJttvzZeipYf8XJKl7zk/img.png)

Tomcat Documentation에 따르면 <distrubutable />이 하는 역할은 다음과 같다.

The <Manager> element defined inside the <Cluster> element is the template defined for all web applications that are marked <distributable/> in their web.xml file. However, you can still override the manager implementation on a per web application basis, by putting the <Manager> inside the <Context> element either in the context.xml file or the server.xml file.

web.xml에 <distrubutable />이 설정된 모든 어플리케이션이 server.xml에 설정한 <Manager> 설정대로 관리되는 듯 하다.

## 테스트

정상적으로 세션 클러스터링이 설정되었을 경우 테스트 방법은 아래와 같다.

---

1. Tomcat A, B 기동

2. Tomcat A 또는 B에서 처음으로 세션이 생성됨

3. 세션이 생성된 서버를 Shutdown

4. 나머지 서버의 세션 값이 처음 생성된 세션 값과 동일하면 설정 완료

**1. Tomcat A, B 기동**

![https://blog.kakaocdn.net/dn/euI59A/btqGreRZB3B/RHFrOeQrUEesvNn3DAqOi0/img.png](https://blog.kakaocdn.net/dn/euI59A/btqGreRZB3B/RHFrOeQrUEesvNn3DAqOi0/img.png)

**2. Tomcat A 또는 B에서 세션 생성 확인 (Tomcat A에서 세션이 생성)**

세션 값을 확인하는 방법은 여러가지가 있으나 여기서는 Chrome 브라우저의 개발자도구를 사용하였음.

![https://blog.kakaocdn.net/dn/c2FHod/btqGrjS4JLg/Zi8HqqkIJW9889A5sTco2K/img.png](https://blog.kakaocdn.net/dn/c2FHod/btqGrjS4JLg/Zi8HqqkIJW9889A5sTco2K/img.png)

**3. 세션이 생성된 서버를 Shutdown(Tomcat A)**

![https://blog.kakaocdn.net/dn/esY0Na/btqGqah11by/BH7Jg3D5BUAMbaV2kr6rjK/img.png](https://blog.kakaocdn.net/dn/esY0Na/btqGqah11by/BH7Jg3D5BUAMbaV2kr6rjK/img.png)

**4. 나머지 서버(Tomcat B)의 세션 값이 처음 생성된 세션 값과 동일한지 확인**

![https://blog.kakaocdn.net/dn/bkzphb/btqGqnWglsa/m4K2ZKNzUTFJVGTvoNyLZK/img.png](https://blog.kakaocdn.net/dn/bkzphb/btqGqnWglsa/m4K2ZKNzUTFJVGTvoNyLZK/img.png)

세션 값이 **1EF398C1540F9380C4163C2F6062171F.worker1** 으로 동일한 것을 확인할 수 있다.

만약 Session Clustering이 설정되지 않았다면 **xxxxxxxx.worker2**로 세션 값이 설정되었을 것이다.

[root@worker1 ~]# cat /etc/tomcat/server.xml
<?xml version='1.0' encoding='utf-8'?>
<!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

```
  <http://www.apache.org/licenses/LICENSE-2.0>

```

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<!-- Note:  A "Server" is not itself a "Container", so you may not
define subcomponents such as "Valves" at this level.
Documentation at /docs/config/server.html
-->
<Server port="8005" shutdown="SHUTDOWN">
<Listener className="org.apache.catalina.startup.VersionLoggerListener" />
<!-- Security listener. Documentation at /docs/config/listeners.html
<Listener className="org.apache.catalina.security.SecurityListener" />
-->
<!--APR library loader. Documentation at /docs/apr.html -->
<Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
<!--Initialize Jasper prior to webapps are loaded. Documentation at /docs/jasper-howto.html -->
<Listener className="org.apache.catalina.core.JasperListener" />
<!-- Prevent memory leaks due to use of particular java/javax APIs-->
<Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
<Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
<Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

<!-- Global JNDI resources
Documentation at /docs/jndi-resources-howto.html
-->
<GlobalNamingResources>
<!-- Editable user database that can also be used by
UserDatabaseRealm to authenticate users
-->
<Resource name="UserDatabase" auth="Container"
type="org.apache.catalina.UserDatabase"
description="User database that can be updated and saved"
factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
pathname="conf/tomcat-users.xml" />
</GlobalNamingResources>

<!-- A "Service" is a collection of one or more "Connectors" that share
a single "Container" Note:  A "Service" is not itself a "Container",
so you may not define subcomponents such as "Valves" at this level.
Documentation at /docs/config/service.html
-->
<Service name="Catalina">

```
<!--The connectors can use a shared executor, you can define one or more named thread pools-->
<!--
<Executor name="tomcatThreadPool" namePrefix="catalina-exec-"
    maxThreads="150" minSpareThreads="4"/>
-->

<!-- A "Connector" represents an endpoint by which requests are received
     and responses are returned. Documentation at :
     Java HTTP Connector: /docs/config/http.html (blocking & non-blocking)
     Java AJP  Connector: /docs/config/ajp.html
     APR (HTTP/AJP) Connector: /docs/apr.html
     Define a non-SSL HTTP/1.1 Connector on port 8080
-->
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
<!-- A "Connector" using the shared thread pool-->
<!--
<Connector executor="tomcatThreadPool"
           port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
-->
<!-- Define a SSL HTTP/1.1 Connector on port 8443
     This connector uses the BIO implementation that requires the JSSE
     style configuration. When using the APR/native implementation, the
     OpenSSL style configuration is required as described in the APR/native
     documentation -->
<!--
<Connector port="8443" protocol="org.apache.coyote.http11.Http11Protocol"
           maxThreads="150" SSLEnabled="true" scheme="https" secure="true"
           clientAuth="false" sslProtocol="TLS" />
-->

<!-- Define an AJP 1.3 Connector on port 8009 -->
<Connector port="8010" address="0.0.0.0" secretRequired="false" protocol="AJP/1.3" redirectPort="8443" />

<!-- An Engine represents the entry point (within Catalina) that processes
     every request.  The Engine implementation for Tomcat stand alone
     analyzes the HTTP headers included with the request, and passes them
     on to the appropriate Host (virtual host).
     Documentation at /docs/config/engine.html -->

<!-- You should set jvmRoute to support load-balancing via AJP ie :
<Engine name="Catalina" defaultHost="localhost" jvmRoute="jvm1">
-->
<Engine name="Catalina" defaultHost="localhost" jvmRoute="worker1">

  <!--For clustering, please take a look at documentation at:
      /docs/cluster-howto.html  (simple how to)
      /docs/config/cluster.html (reference documentation) -->
  <!--
  <Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"/>
  -->

  <!-- Use the LockOutRealm to prevent attempts to guess user passwords
       via a brute-force attack -->
  <Realm className="org.apache.catalina.realm.LockOutRealm">
    <!-- This Realm uses the UserDatabase configured in the global JNDI
         resources under the key "UserDatabase".  Any edits
         that are performed against this UserDatabase are immediately
         available for use by the Realm.  -->
    <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
           resourceName="UserDatabase"/>
  </Realm>

  <Host name="localhost"  appBase="webapps"
        unpackWARs="true" autoDeploy="true">

    <!-- SingleSignOn valve, share authentication between web applications
         Documentation at: /docs/config/valve.html -->
    <!--
    <Valve className="org.apache.catalina.authenticator.SingleSignOn" />
    -->

    <!-- Access log processes all example.
         Documentation at: /docs/config/valve.html
         Note: The pattern used is equivalent to using pattern="common" -->
    <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
           prefix="localhost_access_log." suffix=".txt"
           pattern="%h %l %u %t &quot;%r&quot; %s %b" />

  </Host>

```

<Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"
channelSendOptions="8">

```
      <Manager className="org.apache.catalina.ha.session.DeltaManager"
               expireSessionsOnShutdown="false"
               notifyListenersOnReplication="true"/>

      <Channel className="org.apache.catalina.tribes.group.GroupChannel">
        <Membership className="org.apache.catalina.tribes.membership.McastService"
                    address="228.0.0.4"
                    port="45564"
                    frequency="500"
                    dropTime="3000"/>
        <Receiver className="org.apache.catalina.tribes.transport.nio.NioReceiver"
                  address="172.16.1.111"
                  port="4000"
                  autoBind="100"
                  selectorTimeout="5000"
                  maxThreads="6"/>

        <Sender className="org.apache.catalina.tribes.transport.ReplicationTransmitter">
          <Transport className="org.apache.catalina.tribes.transport.nio.PooledParallelSender"/>
        </Sender>
        <Interceptor className="org.apache.catalina.tribes.group.interceptors.TcpFailureDetector"/>
        <Interceptor className="org.apache.catalina.tribes.group.interceptors.MessageDispatchInterceptor"/>
      </Channel>

      <Valve className="org.apache.catalina.ha.tcp.ReplicationValve"
             filter=""/>
      <Valve className="org.apache.catalina.ha.session.JvmRouteBinderValve"/>

      <Deployer className="org.apache.catalina.ha.deploy.FarmWarDeployer"
                tempDir="/tmp/war-temp/"
                deployDir="/tmp/war-deploy/"
                watchDir="/tmp/war-listen/"
                watchEnabled="false"/>

      <ClusterListener className="org.apache.catalina.ha.session.ClusterSessionListener"/>
    </Cluster>
</Engine>

```

</Service>
</Server>
[root@worker1 ~]#