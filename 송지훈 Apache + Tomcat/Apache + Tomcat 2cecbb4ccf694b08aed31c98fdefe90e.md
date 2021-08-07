# Apache + Tomcat

**톰캣이란? ( tomcat )**

- 톰캣은 아파치 소프트웨어 재단의 어플리케이션 서버로서, 자바 서블릿을 실행시키고 JSP 코드가 포함되어 있는 웹페이지를 만들어준다. 자바 서블릿과 JSP 규격의 '참조용 구현'으로 평가되고 있는 톰캣은, 개발자들의 개방적 협력 작업의 산물로 바이너리 버전과 소스코드 버전 둘 모두를 아파치 웹사이트에서 얻을 수 있다. 즉, 톰캣은 웹서버에서 넘어온 동적인 페이지를 읽어들여 프로그램을 실행하고 그 결과를 다시 html로 재구성하여 아파치에게 되돌려 준다. 톰캣은 자체적으로 보유하고 있는 내부 웹서버와 함께 독립적으로 사용될 수도 있지만 아파티나 넷스케이프 엔터프라이즈 서버, IIS 등 다른 웹서버와 함께 사용될 수도 있다. 톰캣을 실행시키기 위해서는 JRE 1.1 이상에 부합되는 자바 런타임 환경이 필요하다.

- **아파치 & 톰캣**

아파치는 기본적으로 80포트로 연결되며, APACHE_HOME/bin/startup.bat 과 같은 배치파일을 실행하거나, 지금은 서비스로 등록해주는 것이 있기 때문에 서비스에서 실행시키면 된다.

톰캣은 기본적으로 8080포트로 연결되며, 서버를 띄우려면 TOMCAT_HOME/bin/startup.bat 과 같은 배치파일을 실행시키면 된다.

아파치는 웹서버이고, 톰캣은 WAS(Web Application Server)이다.

톰캣의 경우 html파일과 jsp 파일을 같은 것으로 보고 처리를 하기 때문에 html 파일의 경우 한번의 재구성을 통해 보여주기 때문에 대량의 트래픽이 발생되는 곳에서 톰캣단독으로 운영이 된다면 많은 비용이 들 것으로 예상된다.

아파치는 정적인 페이지를 보여주는 역할을 수행하는데 적합한 반면, 게시판과 같은 사용자가 뭔가를 입력하고 거기에 따라 다른 결과를 보여주는 동적인 페이지에 대해서는 톰캣이 수행하는 것이 적합하다.

아파치와 톰캣을 연동한다는 것은 동일한 포트로 운영한다는 의미로, 보통 이미지나 HTML 요소는 아파치에서 처리가 되고, 사용자의 데이터 처리와 같은 업무는 톰캣에서 처리하게끔 한다.

- **WAS 란?**

웹 어플리케이션 서버(Web Application Server)는 인터넷 상에서 HTTP를 통해 사용자 컴퓨터나 장치에 어플리케이션을 수행해 주는 미들웨어(소프트웨어 엔진). 

웹 어플리케이션 서버는 동적 서버 콘텐츠를 수행하는 것으로 일반적인 웹서버와 구별이 되며, 주로 데이터베이스 서버와 같이 수행이 된다.

WAS란 웹 서버와 웹 컨테이너의 결합으로 이루어진 소프트웨어다. 웹 서버를 포함하고 있기 때문에 웹 서버처럼 사용할 수도 있다. 

DB 와 연결되어 트랜잭션 처리를 하거나 다른 시스템과의 연동 기능 또한 포함하고 있다. 

그리고 웹 서버와 달리 요청에 대해 동적인 페이지를 만들 어 유연하게 응답할 수 있다.

Apache 웹 서버 혼자만으로는 정적인 웹 페이지 제공밖에 할 수 없다

하지만 Tomcat은 정적인 페이지는 물론 동적인 페이지 제공 및 기타 미들웨어로써의 추가적인 기능을 할 수 있다

물론 Tomcat 하나만으로도 정적인 페이지도 제공이 가능하지만, 둘을 나눠놓음으로써 성능 향상을 얻을 수 있다.

정적인 페이지는 Apache 웹 서버가, 동적인 페이지는 Tomcat 미들웨어가 제공하면 되기 떄문이다.

### **WAS가 필요한 이유**

웹 서버는 정적인 컨텐츠만 제공하기 때문에 클라이언트의 요구에 유연하게 대처할 수 없다. 

다양한 클라이언트의 요구에 유연하게 대처하기 위해 DB와 연결해 데이터를 주고받거나 데이터 조작을 하여 동적인 페이지를 생성해 응답하기 위해 WAS를 사용하고 있다.

## 아파치 (Apache)

![https://blog.kakaocdn.net/dn/dEPTC1/btq0TvkFkuz/sg8wkZzsNuWzIMKV4ZeIJ1/img.png](https://blog.kakaocdn.net/dn/dEPTC1/btq0TvkFkuz/sg8wkZzsNuWzIMKV4ZeIJ1/img.png)

> 아파치 소프트웨어 재단의 오픈소스 프로젝트이다. 일명 웹서버로 불리며, 클라이언트 요청이 왔을때만 응답하는 정적 웹페이지에 사용된다.

- 웹서버 = 80번 포트로 클라이언트 요청(POST,GET,DELETE)이 왔을때만 응답함.
- 정적인 데이터만 처리한다.(HTML,CSS,이미지 등).

## 톰캣 (Tomcat)

![https://blog.kakaocdn.net/dn/5L5Pj/btq0LQj5bVY/qhydiZIH476UHYtJEXDxwk/img.png](https://blog.kakaocdn.net/dn/5L5Pj/btq0LQj5bVY/qhydiZIH476UHYtJEXDxwk/img.png)

> dynamic(동적)인 웹을 만들기 위한 웹 컨테이너, 서블릿 컨테이너라고 불리며, 웹서버에서 정적으로 처리해야할 데이터를 제외한 JSP, ASP, PHP 등은 웹 컨테이너(톰캣)에게 전달한다.

- WAS(Web Application Server)
1. 컨테이너, 웹 컨테이너, 서블릿 컨테이너라고 부름
2. JSP,서블릿처리,HTTP요청 수신 및 응답
3. 아파치만 쓰면 정적인 웹페이지만 처리하므로 처리속도가 매우 빠르고 안정적이다.

하지만 톰캣(WAS)를 쓰면 동적인 데이터 처리가 가능하다. DB연결,데이터 조작, 다른 응용프로그램과 상호 작용이 가능하다. 

톰캣은 8080포트로 처리한다.

## 아파치톰캣 (Apache+Tomcat)

![https://blog.kakaocdn.net/dn/bCe3Hk/btq0JwzqtHk/iatIu10gG3IohPTdq3fDk1/img.png](https://blog.kakaocdn.net/dn/bCe3Hk/btq0JwzqtHk/iatIu10gG3IohPTdq3fDk1/img.png)

> 톰캣이 아파치의 기능 일부를 가져와서 제공해주는 형태이기 때문에 같이 합쳐서 부른다. WAS(Web Application Server)

![https://blog.kakaocdn.net/dn/q7Z09/btq0NwrPm5t/2JxFBzxS1O4Ww80uFY0Etk/img.png](https://blog.kakaocdn.net/dn/q7Z09/btq0NwrPm5t/2JxFBzxS1O4Ww80uFY0Etk/img.png)

> 그림을 통해서 아파치와 톰캣의 차이를 알 수 있다. 톰캣은 일반적으로 WAS(Wep)라고 불리며, 톰캣은 아파치와 합쳐서 아파치톰캣 이라 부른다.

1. 아파치만 사용하면 정적인 웹페이지만 처리 가능
2. 톰캣만 사용하면 동적인 웹페이지 처리가 가능하지만 아파치에서 필요한 기능을 못가져옴. 또한 여러 사용자가 요청할시에 톰캣에 과부하가 걸림.
3. 아파치와 톰캣을 같이 쓰면 아파치는 정적인 데이터만 처리하고, JSP 처리는 Web Container(톰캣의 일부)로 보내주어 분산처리 할 수 있다.

아파치 : 80포트톰캣 : 8080포트(하지만 실제로는 80포트로 다 처리하므로, 8080포트는 아파치가 알아서 보내줌. 8080포트를 다루거나 보려면 리눅스단에서 처리하거나 수동적으로 포트 처리할때 빼고는 보기힘듬)

## 아파치 톰캣 정리

![https://blog.kakaocdn.net/dn/bzo5cE/btq0Okq9MOq/pZua6sujkfTVWAeGKwgTzk/img.png](https://blog.kakaocdn.net/dn/bzo5cE/btq0Okq9MOq/pZua6sujkfTVWAeGKwgTzk/img.png)

## 톰캣의 구성요소 및 역할

Tomcat 4.x부터 Catalina (servlet container), Coyote (HTTP 커넥터) 및 Jasper ( JSP 엔진 )와 함께 출시되었습니다 (21년 1월 기준, stable 버전은 9 버전)

### Catalina

**Catalina는 Tomcat의 servlet container이다**

- servlet container(= web container)는
    1. 웹 서버의 구성요소로서 URL을 특정 servlet에 매핑하며 URL 요청자가 올바른 액세스 권한을 갖도록 한다.

        → url을 특정 서블릿에 매핑!

    2. servlet , Jakarta Server Pages (JSP) 파일 및 서버 측 코드를 포함하는 기타 유형의 파일에 대한 요청을 처리한다.

        → servlet, jsp 파일에 대한 요청을 처리한다

    3. 웹 컨테이너는 서블릿 인스턴스를 생성하고, 서블릿을 로드 및 언로드 하고, 요청 및 응답 객체를 생성 및 관리하고, 기타 서블릿 관리 작업을 수행한다.

        → servlet의 생명주기 관리해준다.

### Coyote

**Coyote는 HTTP 1.1 프로토콜을 웹 서버로 지원하는 Tomcat의 Connector Component이다.**

→ Catalina는 Coyote를 사용해 웹 서버로서 작동할 수 있다.

### Jasper

**Jasper는 Tomcat의 JSP 엔진이다.**

Jasper는 JSP 파일을 구문 분석하여 Java 코드를 서블릿으로 컴파일한다.

톰캣 버전 5부터 Tomcat은 Jasper 2를 사용한다.

Jasper에서 Jasper 2까지 중요한 기능이 추가되었다.

- JSP 태그 라이브러리 풀링
- 백그라운드 JSP 컴파일 – 수정된 JSP Java 코드를 재 컴파일하는 동안 이전 버전을 서버 요청에 계속 사용할 수 있다. 새 JSP 서블릿이 다시 컴파일되면 이전 JSP 서블릿이 삭제된다.

    → 수정된 jsp 파일을 서버에 반영하기 위해서 서버를 재시작할 필요가 없다.

- 페이지 변경이 포함된 경우 JSP를 다시 컴파일합니다. 런타임에 페이지를 JSP에 삽입하고 포함할 수 있다.

    → 새로운 jsp 파일을 서버에 반영하기 위해서 서버 재시작할 필요가 없다

![https://blog.kakaocdn.net/dn/dUjQTc/btqR6wm4rzt/BjtNKmLQAjT3dI3zQLeWF1/img.png](https://blog.kakaocdn.net/dn/dUjQTc/btqR6wm4rzt/BjtNKmLQAjT3dI3zQLeWF1/img.png)

Tomcat과 구성요소들의 역할

### **Tomcat의 디렉토리 구조**

- Bin: 톰캣 서버의 동작을 제어할 수 있는 스크립트 및 실행 파일
- Conf: 톰캣의 기본적인 설정 파일
- Lib: 아파치와 같은 다른 웹 서버와 톰캣을 연결해주는 바이너리 모듈들
- Webapps: 톰캣이 제공하는 웹 애플리케이션의 기본 위치
- Logs: 서버의 로그 파일이 저장
- Work: jsp 컨테이너와 다른 파일들이 생성하는 임시 디렉토리
- Temp: 임시 저장 폴더

## tomcat설치(yum)

**1.tomcat설치**

```
yum -y install tomcat

yum install -y tomcat-webapps tomcat-admin-webapps
```

**2.방화벽 포트 열기**

```
firewall-cmd --add-port=8080/tcp --permanentfirewall-cmd --reload

systemctl stop tomcatsystemctl start tomcatsystemctl enable tomcat.service
```

**3.포트 확인**netstat -an | grep 8080

**4.tomcat 계정 생성**

```
vi /etc/tomcat/tomcat-users.xml

```

vi /etc/tomcat/tomcat-users.xml 수정소스

<?xml version='1.0' encoding='utf-8'?><!--  Licensed to the Apache Software Foundation (ASF) under one or more  contributor license agreements.  See the NOTICE file distributed with  this work for additional information regarding copyright ownership.  The ASF licenses this file to You under the Apache License, Version 2.0  (the "License"); you may not use this file except in compliance with  the License.  You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software  distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and  limitations under the License.--><tomcat-users><!--  NOTE:  By default, no user is included in the "manager-gui" role required  to operate the "/manager/html" web application.  If you wish to use this app,  you must define such a user - the username and password are arbitrary.--><!--

NOTE:  The sample user and role entries below are wrapped in a comment  and thus are ignored when reading this file. Do not forget to remove  <!.. ..> that surrounds them.-->

<!--  <role rolename="tomcat"/>  <role rolename="role1"/>  <user username="tomcat" password="tomcat" roles="tomcat"/>  <user username="both" password="tomcat" roles="tomcat,role1"/>  <user username="role1" password="tomcat" roles="role1"/>-->

<!-- <role rolename="admin"/> --><!-- <role rolename="admin-gui"/> --><!-- <role rolename="admin-script"/> --><!-- <role rolename="manager"/> --><!-- <role rolename="manager-gui"/> --><!-- <role rolename="manager-script"/> --><!-- <role rolename="manager-jmx"/> --><!-- <role rolename="manager-status"/> -->

<!--<user name="admin" password="adminadmin" roles="admin,manager,admin-gui,admin-script,manager-gui,manager-script,manager-jmx,manager-status" />--></tomcat-users>

빨간부분(주석)제거

**5.tomcat 재시작**

```
systemctl restart tomcat
```

http:/Centos7 IP주소/:8080/

**6.hello.jsp수정후 http:/Centos7 IP주소/:8080/sample/hello.jsp접속 후 확인**

```
vi /var/lib/tomcat/webapps/sample/hello.jsp
```

vi /var/lib/tomcat/webapps/sample/hello.jsp 수정소스

Licensed to the Apache Software Foundation (ASF) under one or more  contributor license agreements.  See the NOTICE file distributed with  this work for additional information regarding copyright ownership.  The ASF licenses this file to You under the Apache License, Version 2.0  (the "License"); you may not use this file except in compliance with  the License.  You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software  distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and  limitations under the License.--><html><head><title>Sample Application JSP Page</title></head><body bgcolor=white>

<table border="0">

<tr><td align=center><img src="images/tomcat.gif"></td><td><h1>Sample Application JSP Page</h1>This is the output of a JSP page that is part of the Hello, Worldapplication.</td></tr></table>

<%= new String("Hello!") %>

</body></html>

빨간부분 수정후 확인

http:/Centos7 IP주소/:8080/sample/hello.jsp 접속

# Apache + Tomcat

- **apache 서버 설치 및 설정**

<토폴로지>

![Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/%EC%BA%A1%EC%B2%98.jpg](Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/%EC%BA%A1%EC%B2%98.jpg)

톰캣 커넥터 받는 곳

[https://mirror.navercorp.com/apache/tomcat/tomcat-connectors/jk/#releases](https://mirror.navercorp.com/apache/tomcat/tomcat-connectors/jk/#releases)

[https://tomcat.apache.org/download-connectors.cgi](https://tomcat.apache.org/download-connectors.cgi)

httpd 설치 내용

```
# yum install httpd httpd-devel gcc gcc-c++

# tomcat-connector 설치
wget http://apache.mirror.cdnetworks.com/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz
# tar zxvf tomcat-connectors-1.2.48-src.tar.gz
# cd tomcat-connectors-1.2.48-src/native/
# ./configure --with-apxs=/bin/apxs
# make
# make install

## /usr/lib64/httpd/modules/mod_jk.so 파일이 존재하지 않을 경우 아래 내용 실행
# cp -p mod_jk.so /usr/lib64/httpd/modules/mod_jk.so
# chmod 755 /usr/lib64/httpd/modules/mod_jk.so

========================================================================================
바이너리로 설치할 시 
빌드 에러시

# cd /native

# ./buildconf.sh

 autoconf 가 설치되어 있지 않는 경우 yum으로 설치

buildconf: checking installation...

buildconf: autoconf not found.

You need autoconf version 2.59 or newer installed

to build mod_jk from SVN.

# yum install autoconf

libtool 가 설치되어 있지 않은 경우 yum으로 설치

buildconf: checking installation...

buildconf: autoconf version 2.63 (ok)

buildconf: libtool not found.

You need libtool version 1.4 or newer installed

to build mod_jk from SVN.

# yum install libtool

./configure --with-apxs=/usr/local/apache2/bin/apxs (경로 중요)

---에러남-----

no apache given

no netscape given

configure: error: Cannot find the WebServer

# find / -name "apxs" -print
/usr/bin/apxs

경로가 없다면 설치
# yum install httpd-devel
```

아파치 톰캣 연동 작업을 위해 필요한 톰캣 커넥터(Tomcat connector) 설치 작업 중 다음과 같은 에러가 발생했다.

톰캣 커넥터를 다운받고 tar로 압축을 푼 후 해당 폴더의 native폴더에 들어가 다음의 MakeFile을 만들기 위해 명령어를 실행

```
./configure --with-apxs=/usr/bin/apxs
```

다음과 같은 에러 발생

```
configure: error: in `/usr/local/src/tomcat-connectors-1.2.48-src/native':configure: error: C compiler cannot create executables
```

mod_jk를 설치 하려면 gcc, gcc-c++, httpd-devel 세가지 패키지가 설치되어 있어야 한다.

다음과 같이 설치해주고 다시 실행

```
yum install gcc gcc-c++ httpd-devel
```

httpd.conf 파일 설정 내용

```
vi /etc/httpd/conf/httpd.conf

# 대충 58번 라인 근처에 아래 내용 작성
LoadModule jk_module /usr/lib64/httpd/modules/mod_jk.so

# jsp 파일에 대해서만 tomcat에 요청하도록 한다.
# 더 필요한 내용이 있을 경우 문법에 맞춰 작성 해준다.
<IfModule jk_module>
	JkWorkersFile /etc/httpd/conf/workers.properties
	JkLogFile /var/log/httpd/mod_jk.log
	JkLogLevel info
	JkLogStampFormat "[%a %b %d %H:%M:%S %Y]"
	JkMount /*.jsp worker1
</IfModule>
```

workers.properties 설정 내용 

(worker1은 위의 IfModule 안에 JkMount 에서 설정한 이름과 같게 설정 해준다)

```
# vi /etc/httpd/conf/workers.properties

worker.list=worker1

worker.worker1.type=ajp13
worker.worker1.host=[톰캣 서버의 IP]
worker.worker1.port=8009
```

완료 후 systemctl restart httpd

- **tomcat 서버 설치 및 설정**

JDK 설치 내용

```
JDK 설치
# yum -y update
# yum install java-1.8.0-openjdk-devel.x86_64

JDK 환경 변수 설정
# vi /etc/profile

# 맨 아래에 내용 작성 (자바 홈 경로는 검색해서 알맞은 경로로 작성)
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH
:wq

설정 내용 적용
# source /etc/profile

1.8.0 으로 재대로 출력 되는지 확인
# java -version
```

tomcat 설치 내용

톰캣 tar.gz 파일 받는곳

 [https://tomcat.apache.org/download-90.cgi](https://tomcat.apache.org/download-90.cgi)

```
tomcat 9.0.36 설치 (yum -y install tomcat 도 가능)
# wget http://mirror.navercorp.com/apache/tomcat/tomcat-9/v9.0.36/bin/apache-tomcat-9.0.36.tar.gz
# tar zxvf apache-tomcat-9.0.36.tar.gz
# mv apache-tomcat-9.0.36 /usr/local/tomcat9

8.5.51 버전 설치하실분들은 아래 명령어 입력
# wget http://mirror.navercorp.com/apache/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz
# tar zxvf apache-tomcat-8.5.51.tar.gz
# mv apache-tomcat-8.5.51 /usr/local/tomcat8
```

이후 vi /usr/local/tomcat9/conf/server.xml 들어가서 아래 116~121 라인의 주석을 해제 한다. (tomcat8 설치하면 /usr/local/tomcat8/conf/server.xml)

( yum 으로 설치했을 시는 /etc/tomcat/server.xml)

![https://blog.kakaocdn.net/dn/bJzeNr/btqB2HJVRcl/KAM5AmZOtPthaFuy8hPp9k/img.png](https://blog.kakaocdn.net/dn/bJzeNr/btqB2HJVRcl/KAM5AmZOtPthaFuy8hPp9k/img.png)

주석을 풀었으면 아래와 같이 설정을 작성 한다.

![https://blog.kakaocdn.net/dn/bbBng5/btqB1bFxqif/Bj6tD3j6MifOQhejFOm0z0/img.png](https://blog.kakaocdn.net/dn/bbBng5/btqB1bFxqif/Bj6tD3j6MifOQhejFOm0z0/img.png)

- **address** : AJP 커넥터를 이용할 네트워크 IP 대역 허용 (0.0.0.0은 모든 IP 허용)
- **secretRequired** : SSL 설정 안함

완료 후 systemctl restart tomcat or /usr/local/tomcat9/bin/start.sh 입력하여 톰캣 실행 후 잘 되는지 테스트 한다. 

apache 설정할 때 jsp 파일을 tomcat 서버로 지정하였다면 

(/etc/httpd/conf/httpd.conf   IfModule dir.module 에서 index.jsp 추가)

https://[웹서버 IP]/index.jsp 입력 후 톰캣 화면이 뜨면 재대로 연동 된 것이다.

![Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/%EC%BA%A1%EC%B2%98%201.jpg](Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/%EC%BA%A1%EC%B2%98%201.jpg)

이건 톰캣설치하고 톰캣포트인 8080으로 톰캣서버에서 접속했을 때

![Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/1.jpg](Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/1.jpg)

# Apache-Tomcat 로드밸런싱 설정

- **Apache-Tomcat 로드밸런싱 설정**
- **1. Apache 설정**

아래 설정은 URL에 .jsp로 끝나는 모든것은 loadbalancer 를 사용하도록 한다. 

loadbalancer는 사용자 임의로 정할 수 있다. 

(파일 경로 : /etc/httpd/conf/httpd.conf )

```
LoadModule jk_module /usr/lib64/httpd/modules/mod_jk.so

<IfModule jk_module>
   JkWorkersFile /etc/httpd/conf/workers.properties
   JkLogFile /var/log/httpd/mod_jk.log
   JkLogLevel info
   JkLogStampFormat "[%a %b %d %H:%M:%S %Y]"
   JkMount /*.jsp loadbalancer
</IfModule>
```

worker.list로 로드밸런싱을 사용할 tomcat을 묶어준다. 

위의 /*.jsp 뒤에 사용한 이름을 작성해주어야 한다.

host는 tomcat ip를 적고 port는 ajp를 사용할 포트를 정해 준다. 임의로 설정 가능 하다.

lbfactor는 로드밸런싱을 얼마나 할지를 정하는데, 모두 1로 정하면 라운드로빈(roundrobin) 방식 으로 로드 밸런싱되며 각각의 톰캣별로 로드밸런싱할 비율을 정해줄 수 있다. 

(파일 경로 : /etc/httpd/conf/httpd.confworkers.properties )

```
worker.list=worker1,worker2,loadbalancer

worker.loadbalancer.type=lb
worker.loadbalancer.balanced_workers=worker1,worker2
worker.loadbalancer.sticky_session=1

worker.worker1.type=ajp13
worker.worker1.host=[톰캣서버 IP]
worker.worker1.port=8010
worker.worker1.lbfactor=1

worker.worker2.type=ajp13
worker.worker2.host=[톰캣서버 IP]
worker.worker2.port=9010
worker.worker2.lbfactor=1
```

이것으로 apache 설정은 모두 종료 되었으니 **systemctl restart httpd** 입력하여 옵션을 적용 시켜줌

- **2. tomcat 설정**

vi /usr/local/tomcat9/conf/server.xml (/etc/tomcat/server.xml) 후 아래와 같이 설정 해줍니다. 

나의 경우 apache 에서 설정한대로 톰캣서버1은 8010, 톰캣서버2는 9010 포트를 사용해야하므로 각 서버에 맞게 포트를 할당 한다.

또한 address="0.0.0.0" 와 SSL설정을 하지 않을것이므로 secretRequired="false" 을 넣었다. 

(tomcat 최신 버전에만 해당 한다)

![https://blog.kakaocdn.net/dn/ySv0L/btqCn0bYkFJ/FNgpiJC4DFP43JJFbIBs21/img.png](https://blog.kakaocdn.net/dn/ySv0L/btqCn0bYkFJ/FNgpiJC4DFP43JJFbIBs21/img.png)

설정완료 후 /usr/local/tomcat9/bin/startup.sh(systemctl restart tomcat) 을 입력하여 톰캣 실행 http://[apache ip]/index.jsp 로 접근하여 로드 밸런싱을 확인 하면 되고, 

나는 apache 설정에서 tomcat 을 모두 lbfactor=1을 주었으므로 라운드로빈 방식으로 동작하게 되어 엔터를 한번 칠때마다 아래 이미지처럼 번갈아가며 출력 된다.

로드밸런싱 확인 시 각 서버별로 /usr/local/tomcat9/webapps/ROOT

(/var/lib/tomcat/webapps/ROOT/index.jsp) 디렉토리에 jsp 파일을 조금씩 다르게 설정하여 확인하는게 편하다

![Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/%EC%BA%A1%EC%B2%98%202.jpg](Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/%EC%BA%A1%EC%B2%98%202.jpg)

![Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/1%201.jpg](Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/1%201.jpg)

lsof -i 명령어로 톰캣이 제대로 동작하고 있는지 확인

```
tomcat server1 # lsof -i
COMMAND   PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
sshd     1059   root    3u  IPv4  21030      0t0  TCP *:ssh (LISTEN)
sshd     1059   root    4u  IPv6  21032      0t0  TCP *:ssh (LISTEN)
master   1353   root   13u  IPv4  21432      0t0  TCP localhost:smtp (LISTEN)
master   1353   root   14u  IPv6  21433      0t0  TCP localhost:smtp (LISTEN)
sshd     9545   root    3u  IPv4  43012      0t0  TCP api1:ssh->211.183.3.100:60208 (ESTABLISHED)
sshd    16047   root    3u  IPv4  58219      0t0  TCP api1:ssh->211.183.3.100:59534 (ESTABLISHED)
sshd    16049   root    3u  IPv4  58274      0t0  TCP api1:ssh->211.183.3.100:59536 (ESTABLISHED)
java    16303 tomcat   51u  IPv6  65181      0t0  TCP *:webcache (LISTEN)
java    16303 tomcat   52u  IPv6  65182      0t0  TCP *:8010 (LISTEN)
java    16303 tomcat   56u  IPv6  65733      0t0  TCP localhost:mxi (LISTEN)
java    16303 tomcat   57u  IPv6  65735      0t0  TCP api1:8010->web:53516 (ESTABLISHED)
java    16303 tomcat   59u  IPv6  65736      0t0  TCP api1:8010->web:53520 (ESTABLISHED)
java    16303 tomcat   60u  IPv6  65789      0t0  TCP api1:8010->web:53524 (ESTABLISHED)
java    16303 tomcat   61u  IPv6  65929      0t0  TCP api1:8010->web:53530 (ESTABLISHED)
java    16303 tomcat   62u  IPv6  66034      0t0  TCP api1:8010->web:53536 (ESTABLISHED)
java    16303 tomcat   63u  IPv6  66036      0t0  TCP api1:8010->web:53538 (ESTABLISHED)
java    16303 tomcat   65u  IPv6  66229      0t0  TCP api1:8010->web:53548 (ESTABLISHED)
```

```
tomcat server2 # lsof -i
COMMAND   PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
sshd     1065   root    3u  IPv4  20226      0t0  TCP *:ssh (LISTEN)
sshd     1065   root    4u  IPv6  20228      0t0  TCP *:ssh (LISTEN)
master   1534   root   13u  IPv4  22595      0t0  TCP localhost:smtp (LISTEN)
master   1534   root   14u  IPv6  22596      0t0  TCP localhost:smtp (LISTEN)
sshd     8257   root    3u  IPv4  28016      0t0  TCP api2:ssh->211.183.3.100:61892 (ESTABLISHED)
sshd     9211   root    3u  IPv4  41823      0t0  TCP api2:ssh->211.183.3.100:56891 (ESTABLISHED)
java    10113 tomcat   51u  IPv6  77120      0t0  TCP *:webcache (LISTEN)
java    10113 tomcat   52u  IPv6  77121      0t0  TCP *:sdr (LISTEN)
java    10113 tomcat   56u  IPv6  77130      0t0  TCP localhost:mxi (LISTEN)
java    10113 tomcat   57u  IPv6  76529      0t0  TCP api2:sdr->web:52700 (ESTABLISHED)
java    10113 tomcat   59u  IPv6  77182      0t0  TCP api2:sdr->web:52704 (ESTABLISHED)
java    10113 tomcat   60u  IPv6  77231      0t0  TCP api2:sdr->web:52706 (ESTABLISHED)
java    10113 tomcat   61u  IPv6  77233      0t0  TCP api2:sdr->web:52712 (ESTABLISHED)
java    10113 tomcat   63u  IPv6  78052      0t0  TCP api2:sdr->web:52718 (ESTABLISHED)
java    10113 tomcat   64u  IPv6  94192      0t0  TCP api2:sdr->web:52722 (ESTABLISHED)
```

# apache-tomcat secretRequired 설정 방법

## (AJP Connecter SSL, secret key, secret password)

- **Apache 설정**

apache 서버에서 설정해야할 파일은 아래 이미지와 같이 httpd.conf에 작성되어 있는 JkWorkersFile 이다.

```
LoadModule jk_module /usr/lib64/httpd/modules/mod_jk.so

<IfModule jk_module>
   JkWorkersFile /etc/httpd/conf/workers.properties
   JkLogFile /var/log/httpd/mod_jk.log
   JkLogLevel info
   JkLogStampFormat "[%a %b %d %H:%M:%S %Y]"
   JkMount /*.jsp loadbalancer
</IfModule>
```

workers.properties 파일에서  아래와 같이 설정 하였다.

worker1(211.183.3.112) , worker2(211.183.3.113) 두 서버를 이중화 해두었고, 

각각의 worker에 임의의 키를 작성 했다.

작성한 키는 자신의 마음대로 소문자,대문자,숫자,특수문자를 섞어서 사용해도 되며 worker1과 worker2의 secret key가 달라도 된다.

```
worker.list=loadbalancer

worker.loadbalancer.type=lb
worker.loadbalancer.balanced_workers=worker1,worker2
worker.loadbalancer.sticky_session=1

worker.worker1.type=ajp13
worker.worker1.host=211.183.3.112
worker.worker1.port=8010
worker.worker1.lbfactor=1
worker.worker1.secret=[KEY]

worker.worker2.type=ajp13
worker.worker2.host=211.183.3.113
worker.worker2.port=9010
worker.worker2.lbfactor=1
worker.worker2.secret=[KEY]
```

- **Tomcat 설정**

Tomcat 설정은 server.xml 파일에 아래와 같이 사용하면 된다.

 Tomcat 7.0.100, 8.5.51, 9.0.31 버전의 경우 secretRequired가 기본값으로 되어있으므로 따로 작성 안해도 되고, Apache 서버에서 적어뒀던 임의의 Key를 secret 속성에 작성, address는 Tomcat 서버 IP를 작성 해주면 된다.

위에 언급한것보다 낮은 버전의 경우 requiredSecret 속성을 사용해서 True를 해준다음 해야 할것이 다. (이하 버전의 경우 테스트는 직접 해보지 않았다)

```
Tomcat server1
<!-- Define an AJP 1.3 Connector on port 8009 -->
<Connector port="8010" secretRequired="[KEY]" address="192.168.1.112" protocol="AJP/1.3" redirectPort="8443" />

Tomcat server2
<!-- Define an AJP 1.3 Connector on port 8009 -->
<Connector port="8010" secretRequired="[KEY]" address="192.168.1.113" protocol="AJP/1.3" redirectPort="8443" />
```

- **통신 확인**

Apache와 Tomcat을 재시작 해준 후 정상적으로 통신이 되는지 확인 한다.

![Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/%EC%BA%A1%EC%B2%98%202.jpg](Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/%EC%BA%A1%EC%B2%98%202.jpg)

![Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/1%201.jpg](Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/1%201.jpg)

# Session Clustering

세션 클러스터링을 설정할때 주의 해야 할 점이 한가지 있는데, 세션 클러스터링은 쿠키 기반으로 세션키를 공유한다는 점이다.

즉, 클러스터링을 묶은 웹 어플리케이션은 같은 도메인(or IP)주소로 접근되어야 세션이 공유 되는 효과를 볼 수 있다.

예제의 경우 각 서버가 192.168.1.112, 192.168.1.113 로 나누어져 있는데,

만약 192.168.1.112:8080 , 192.168.1.113:8080과 같이 접근하는 도메인 주소가 틀리다면 세션은 공유되지 않는다.

DNS 라운드 로빈을 하던지, L4를 사용하던지 apache 나 nginx 와 같은 웹서버로 로드밸런싱을 하든지 같은 도메인 주소로 접근되도록 환경을 구성해야 한다.

로컬환경으로 Tomcat을 이용하여 개발하다 보면 종종 세션이 끊길때가 있다.

물론 Tomcat 1개에 1개의 서비스만 올려서 사용중이라면 그럴일은 없겠지만, 여러 프로젝트를 여러개의 서비스에 올려서 개발할경우 종종 로그인이 끊어지는 경우가 있다.

여러개의 서비스 일지라도 1개의 서비스만 집중적으로 개발할 경우 그럴일은 없는데, 하루에 여러 프로젝트를 손대다보면 세션 끊김이 발생한다.

예를들어 로컬에서 개발시 A라는 프로젝트를 로그인을 한 후 B라는 프로젝트를 로그인 하면 A 프로젝트에서 로그인 했던

세션이 끊어진다.

해당 문제는 바로 JSessionID가 충돌하여 발생하는 문제라고 볼수 있다.

JSessionID는 브라우저에서 로그인등을 통해 세션이나 쿠키등이 생성될경우 사용자의 고유정보를 갖고있는데, 이를 통해 서버는 클라이언트가 어떤 녀석인지 구분을 하게 된다.

이 JSessionID는 사용자 IP를 가지고 구분하게 되는데 우리가 보통 로컬환경에서 개발을 할때는 서비스에 따라 포트만 달리하여 개발을 하기 때문에 기존 세션이 없어지는 문제가 생기는 것이다.

다행히 톰캣은 서비스에 따라 JSessionID의 이름을 사용자가 지정할수 있다.

server.xml의 context 부분에 sessionCookieName을 지정해 주면 된다.

[포트 역할](https://www.notion.so/e1d559c1403147269bbabbf082bfad9b)

- 하나의 서버에서 작동 시 4000 외 사용할 포트가 필요하다.

세션 클러스터링은 Web과 연동된 여러대의 Tomcat을 클러스터링하여 세션을 공유하는 기법이다.

세션 클러스터링 시, Tomcat A의 사용자가 Tomcat B로 연결되어도 A에서 생성한 세션을 그대로 이어받을 수 있다.

### Tomcat 설정 전 준비사항

---

**1. Tomcat Session Clustering 간 Multicast를 위한 라우팅 설정이 필요하다.**

```jsx
route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         gateway         0.0.0.0         UG    100    0        0 ens33
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 ens33
```

위와 같이 라우팅 설정이 되어있지 않으면 해당 명령어로 주소를 추가하자.

```jsx
route add -net 224.0.0.0 netmask 240.0.0.0 dev ens33(디바이스명)
```

```jsx
route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         gateway         0.0.0.0         UG    100    0        0 ens33
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 ens33
224.0.0.0       0.0.0.0         240.0.0.0       U     0      0        0 ens33
```

**2. Session Clustering에 사용되는 포트를 방화벽에서 허가해줘야 한다.**

CentOS 6의 경우에는 vi /etc/sysconfig/iptables 로 아래의 내용을 추가하고 service iptables restart 실행

```
-A INPUT -m state --state NEW -m tcp -p tcp --dport 45564 -j ACCEPT
-A INPUT -m state --state NEW -m udp -p udp --dport 45564 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 4000:4100 -j ACCEPT
```

CentOS 7의 경우에는 아래의 명령어를 실행한다.

```
firewall-cmd --permanent --zone=public --add-port=45564/tcp
firewall-cmd --permanent --zone=public --add-port=45564/udp
firewall-cmd --permanent --zone=public --add-port=4000-4100/tcp
firewall-cmd --reload
```

**3. Apache workers.properties 파일에서 Sticky Session이 활성 되어있는지 확인한다.**

기본값이 TRUE이기 때문에 아래와 같이 반드시 명시할 필요는 없다.

false 또는 0 으로 되어있을 경우 true 또는 1로 변경한다.

```jsx
worker.list=worker1,worker2,loadbalancer

worker.loadbalancer.type=lb
worker.loadbalancer.balanced_workers=worker1,worker2
worker.loadbalancer.sticky_session=1

worker.worker1.type=ajp13
worker.worker1.host=192.168.1.112
worker.worker1.port=8010
worker.worker1.lbfactor=1

worker.worker2.type=ajp13
worker.worker2.host=192.168.1.113
worker.worker2.port=9010
worker.worker2.lbfactor=1
```

### Tomcat 관련 설정

---

Tomcat에서 설정해야할 부분은 총 3곳이다.

**1. server.xml <Engine> 내 jvmRoute 요소 설정**

위의 workers.properties 파일에서 로드밸런싱할 톰캣의 이름을 각각 worker1, worker2로 설정했었다.

각각의 Tomcat 서버에 jvmRoute 값을 worker1, worker2로 설정한다.

```jsx
You should set jvmRoute to support load-balancing via AJP ie :
<Engine name="Catalina" defaultHost="localhost" jvmRoute="worker1">
```

jvmRoute 값은 각 Tomcat 인스턴스의 라우팅 식별자로 사용되며, 설정 시  세션 ID 값에 xxxxxx.${jvmRoute} 로 추가되어 표시된다.

2. server.xml <Host> 하위에 <Cluster> 설정

```
<!-- channelSendOptions 비동기 세션 공유-->
<Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"
                 channelSendOptions="8">

          <Manager className="org.apache.catalina.ha.session.DeltaManager"
                   expireSessionsOnShutdown="false"
                   notifyListenersOnReplication="true"/>

          <Channel className="org.apache.catalina.tribes.group.GroupChannel">
            <Membership className="org.apache.catalina.tribes.membership.McastService"
                        address="228.0.0.4"
                        port="45564"
                        frequency="500"
                        dropTime="3000"/>
           <!-- 수신 대상 지정 -->
           <Receiver className="org.apache.catalina.tribes.transport.nio.NioReceiver"
                      address="auto"  -- 자신의 IP
                      port="4000"     -- 수신하기 위한 port
                      autoBind="100"  -- 수신 포트에 실패 할 경우 확장할 수 10일 경우 4000 ~ 4010 
                      selectorTimeout="5000" -- 대기 시간
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
```

<Receiver> 내의 address 값에 ip 값을 입력하고, 같은 서버에서 여러대의 Tomcat이 동작할 경우 port의 값도 각각 다르게 설정해야 한다.

[Tomcat  세션 관리자 종류](https://www.notion.so/e966d075fe674ea9b13cb9fc68c73b3f)

## **Manager**

세션을 어떻게 복제할지를 책임지는 객체로 Clustering시 사용되는 매니저는 아래와 같이 3가지다.

1. DeltaManager모든 노드에 동일한 세션을 복제한다. 정보가 변경될때마다 복제하기 때문에 노드 개수가 많을 수록 네트워크 트래픽이 높아지고 메모리 소모가 심해진다.
- notifyListenersOnReplication : 다른 tomcat에서 세션이 생성/소멸시 알림을 받을지 여부확인.
- expireSessionsOnShutdown : tomcat서버가 shutdown될 때 모든 노드의 모든 세션들을 expire할지 여부로 default는 false이다.
1. BackupManagerPrimary Node와 Backup Node로 분리되어 모든 노드에 복제하지 않고 단 Backup Node에만 복제한다. 하나의 노드에만 복제하기 때문에 DeltaManager의 단점을 커버할 수 있고 failover도 지원한다고 한다.
2. PersistentManager DB나 파일시스템을 이용하여 세션을 저장한다. IO문제가 생기기 떄문에 실시간성이 떨어진다.

## **Channel**

서로 다른 tomcat간의 메시지 송수신에 관련된 하위 Component를 그룹핑을한다.하위 Component로는 `Membership`, `Sender`, `Sender/Transport`, `Receiver`, `Interceptor`가 있고 현재 Channel구현체는 `org.apache.catalina.tribes.group.GroupChannel`가 유일하다.

## **Channel/Membership**

Cluster안의 노드들을 동적으로 분별하는데 multicast IP/PORT를 통해 `frequency`에 설정된 간격으로 각 노드들이 UDP packet을 날려 heartbeat 확인한다.`dropTime`에 설정된 시간동안 heartbeat가 없을 경우 장애로 판단하고 각 노드에 알리게 된다.

## **Channel/Sender, Channel/Sender/Transport**

Sender는 노드에서 Cluster로 메시지를 보내는 역할을 한다. 사실상 빈 껍데기로 상세 역확을 Transport에서 정의된다.

Transport는 기본적으로 `org.apache.catalina.tribes.transport.nio.PooledParallelSender`를 사용하는데 non-blocking 방식으로 동시에 여러 노드로 메시지를 보낼수도, 하나의 노드에 여러 메시지를 동시에 보낼수도 있다.

 `org.apache.catalina.tribes.transport.bio.PooledMultiSender`는 blocking 방식을 사용한다.

## **Channel/Receiver**

Cluster로부터 메시지를 수신하는 역활을 하며 blocking방식 

`org.apache.catalina.tribes.transport.bio.BioReceiver`와 

non-blocking방식인 `org.apache.catalina.tribes.transport.nio.NioReceiver`을 지원한다.

tomcat에서는 non-blocking방식을 추천하며 노드수가 많아져서 제한된 thread를 통해 많은 메시지를 받아들일 수 있다고 한다. 기본적으로 노드당 1개의 thread를 할당한다.

## **Channel/Interceptor**

Membership 알림 또는 메시지를 가로챌수 있고, documentation에도 각 interceptor에 대한 자세한 설명은 안나왔지만 각 클래스 명으로 역활 구분이 가능한 수준인것 같다.

## **Valve**

`org.apache.catalina.ha.ClusterValve`를 구현한 객체로 일반적인 [Tomcat Valve](http://tomcat.apache.org/tomcat-8.5-doc/config/valve.html)처럼 HTTP Request processing에 관여하는 역활을 하는데 clustering시 중간 interceptor역할을 한다.

예를 들어 `org.apache.catalina.ha.tcp.ReplicationValve`의 경우 HTTP Request가 끝나는 시점에 다른 복제를 해야할지 말아야 할지 cluster에 알리는 역할을 한다.

`org.apache.catalina.ha.session.JvmRouteBinderValve`의 경우 mod_jk를 사용중 failover시 session에 저장한 jvmWorker속성을 변경하여 다음 request부터는 해당 노드에 고정시킨다.

## **Deployer**

WAR배포시 cluster안의 다른 노드에도 같이 배포해준다.

## **ClusterListener**

Cluster내 다른 노드의 메시지를 받는다. DeltaManager를 사용할 경우 Manager는 ClusterSessionListener를 통해 메시지를 받게 된다.

3. 어플리케이션 디렉터리 WEB-INF/web.xml에 <distributable /> 태그를 삽입한다.

```jsx
Welcome to Tomcat
</description>

<distributable/>

</web-app>
```

세션복제 사용여부

WAS에서는 각 모듈 별로 분산 혹은 클러스터링 여부를 설정할 수 있도록 하고 있다.

특히 웹 어플리케이션의 경우에는 web.xml에서 <distributable/>을 설정해 표준적인 방법으로 클러스터링을 설정한다.

web.xml 파일이 conf안에도 존재하기 때문에 헷갈릴 수가 있는데, Tomcat내에 webapps/ROOT/WEB-INF이다.

만약에 웹 어플레이션 경로를 변경했다면 (예를 들어 /testweb) /testweb/WEB-INF/ 으로 전체 복사를 한 후 내용을 변경한다.

[IT와 Game이야기]

### 테스트

---

정상적으로 세션 클러스터링이 설정되었을 경우 테스트 방법은 아래와 같다.

1. Tomcat A, B 기동

2. Tomcat A 또는 B에서 처음으로 세션이 생성됨

3. 세션이 생성된 서버를 Shutdown

4. 나머지 서버의 세션 값이 처음 생성된 세션 값과 동일하면 설정 완료

NAT 서버 설정 - CentOS 7기준

![Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/img1.daumcdn.png](Apache%20+%20Tomcat%202cecbb4ccf694b08aed31c98fdefe90e/img1.daumcdn.png)

기본 권장 아키텍처는

일반적으로 서버는 모두 사설 IP 대역에 두고,

서비스가 필요한 부분은 Cloud LB를 통해서 외부와 연결 하기를 권장한다.

꼭 Public IP가 필요한 경우는, Public IP를 부여해도 되고, NAT 서버에서 Secondary IP를 할당 해서 1:1 NAT를 해주면 된다.

본 글은 일반적인 NAT 서버 구성방법과, 서버내에 기본 라우팅을 바꾸는 법을 설명한다. 

서버는 NAT 서버, 일반 서버 두대로 가정한다.

**[NAT 서버] PublicIP: 211.183.3.111 PrivateIP: 192.168.1.112**

**NAT 서버를 먼저 설정해 본다.**

```
# 1. NAT 서비스를 해줄 방화벽 서비스를 활성화 하고
systemctl enable firewalld
systemctl start firewalld

# 2. 커널에서 IP 패킷 포워딩을 허용 해준다.
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/ip_forward.conf
sysctl -p /etc/sysctl.d/ip_forward.conf

# 3. 방화벽에서 NAT MASQUERADE 설정을 하고, 설정을 반영한다.
firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -o ens33 -j MASQUERADE
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i ens32 -o ens33 -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i ens33 -o ens32 -m state --state RELATED,ESTABLISHED -j ACCEPT
firewall-cmd --reload
```

**[일반 사설 IP만 있는 서버] PrivateIP:10.178.100.20**

디폴트 라우팅만 NAT서버로 바꾸어 주면 된다. 

vim /etc/sysconfig/network-script/ifcfg-ens33 입력 후 

게이트웨이를 nat서버 사설아이피로 바꿔준다.

```jsx
ip route
default via 211.183.3.1 dev ens32 proto static metric 100
default via 192.168.1.111 dev ens33 proto static metric 101
192.168.1.0/24 dev ens33 proto kernel scope link src 192.168.1.112 metric 101
211.183.3.0/24 dev ens32 proto kernel scope link src 211.183.3.112 metric 100
```

defalut 가 nat서버로 변경되있는 걸 확인 할 수 있다.

```jsx
ping -I ens33 192.168.1.111
PING 192.168.1.111 (192.168.1.111) from 192.168.1.112 ens33: 56(84) bytes of data.
64 bytes from 192.168.1.111: icmp_seq=1 ttl=64 time=0.786 ms
64 bytes from 192.168.1.111: icmp_seq=2 ttl=64 time=0.746 ms
64 bytes from 192.168.1.111: icmp_seq=3 ttl=64 time=0.795 ms
```

WAS서버에서 NAT 사설아이피로 소스핑을 하면 잘 가는 것을 확인 할 수 있다.

이제 사설 IP만 있는 서버에서도 외부 Repo를 통해 업데이트를 할 수 있다

세션클러스터링 or mariaDB 관련 블로그

[https://pooheaven81.tistory.com/14](https://pooheaven81.tistory.com/14)

[https://atl.kr/dokuwiki/doku.php/tomcat_clustering](https://atl.kr/dokuwiki/doku.php/tomcat_clustering)

[https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=sunguru&logNo=220935388261](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=sunguru&logNo=220935388261)