# tomcat

**▶ 아파치 톰캣 특징**

- 아파치 톰캣(Apache Tomcat) 은 아파치 소프트웨어 재단 에서 만든 Java Servlet & JSP 기술 구현을 위한 Open Source

- 톰캣은 웹 서버와 연동하여 실행할 수 있는 자바 환경을 제공하여 자바서버페이지(JSP)와 자바 서블릿이 실행할 수 있는 환경을 제공한다.

- 웹 서버로 사용할 수도 있지만 주로 웹 애플리케이션 서버(WAS)로 사용된다.

- html 같은 정적 페이지를 로딩하는데 다른 웹 서버보다 수행 속도가 느리다. (그렇기 때문에 아파치랑 연동 한다.)

**톰캣 카탈리나(Catalina)**

톰캣은 여러개의 기능(부품)으로 구성한다. 톰캣의 코어 컴포넌트는 카탈리나라고 칭한다.

카탈리나는 톰캣의 서블릿 스펙의 실질적인 구동을 제공한다. 톰캣 서버를 가동시킬 경우, 카탈리나를 구동시킨 것이라고 생각하면 된다.

카탈리나 기본동작은 톰캣의 6개 config 파일을 편집하여 구현/제어 할 수 있다.

cataline.policy

- JavaEE 스펙에 정의된 표준 보안 정책 구문으로 표현된 카탈리나 자바 클래스의 톰캣 보안 정책이다.

톰캣의 코어 보안 정책, 시스템 코드, 웹앱, 카탈리나 자체의 permission(사용권한)이 정의되어 있다.

catalina.properties

- 카탈리나 클래스를 위한 표준 자바 프로퍼티다. 보안 패키지 리스트, 클래스 로더 패스 등과 같은 정보다.

톰캣의 성능 최적화를 위한 String 캐시 설정이 포함된다.

logging.properties

- 이 파일은 임계값, 로그값의 위치와 같은 카탈리나의 로깅 기능을 구성하는 방법이다.
- 로그의 모든 항목은 JDK의 로깅 구현 대신, 톰캣이 자동으로 사용하는 commons-logging 구현인 JULI 참조한다.

context.xml

- 이 파일은 톰캣에 구동되는 웹앱에 대해 로드될 정보들이다.

server.xml

- 톰캣의 메인 config 파일이다. 자바 서블릿 스펙에 지정된 계층적 문법을 사용하여, 카탈리나의 초기 상태 구성, 톰캣을 부팅하고 구성 요소의 빌드 순서를 정의한다.

tomcat-users.xml

- 톰캣 서버의 많은 유저, 패스워드, 유저롤(role)에 관한 정보와 데이터에 엑세스하는 신뢰된 영역(JNDI, JDBC 등) 에 대한 정보가 들어있다.

web.xml

- 버퍼 크기, 디버깅 레벨, 클래스패스와 같은 Jasper 옵션, MIME 유형 및 웹페이지 index 파일 같은 서블릿 정의를 포함하여, 톰캣 인스턴스에 로드되는 모든 응용 프로그램에 적용하는 옵션 또는 값이다.

**재스퍼(Jasper)**

- 톰캣의 JSP 엔진이다. 제스퍼는 JSP 파일을 파싱하여 서블릿(JavaEE) 코드로 컴파일한다. JSP 파일의 변경을 감지하여 리컴파일 작업도 수행한다.

### 설치

[http://mirror.navercorp.com/apache/tomcat/tomcat-9/v9.0.50/](http://mirror.navercorp.com/apache/tomcat/tomcat-9/v9.0.50/) 

- wget
- yum 패키지 설치

### 톰캠 다운로드 사이트

[Apache Tomcat®](https://tomcat.apache.org/download-90.cgi)

==== JDK 설치 안되있을 경우 ====

```jsx
sudo yum -y install java-1.8.0-openjdk

sudo vi /etc/profile
```

버전과 경로를 본인 세팅에 맞춰서 제일 밑줄에 추가

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.292.b10-1.el7_9.x86_64/jre

변경된 설정 적용

source /etc/profile

```jsx
[root@app2 bin]# /usr/local/apache-tomcat-9.0.50/bin/startup.sh
Using CATALINA_BASE:   /usr/local/apache-tomcat-9.0.50
Using CATALINA_HOME:   /usr/local/apache-tomcat-9.0.50
Using CATALINA_TMPDIR: /usr/local/apache-tomcat-9.0.50/temp
Using JRE_HOME:        /
Using CLASSPATH:       /usr/local/apache-tomcat-9.0.50/bin/bootstrap.jar:/usr/local/apache-tomcat-9.0.50/bin/tomcat-juli.jar
Using CATALINA_OPTS:
Tomcat started.
[root@app2 bin]# java -version
openjdk version "1.8.0_292"
OpenJDK Runtime Environment (build 1.8.0_292-b10)
OpenJDK 64-Bit Server VM (build 25.292-b10, mixed mode)
```

**Java development kit; JDK자바 개발 키트, 자바 개발 도구, 자바 개발 환경**

**Java runtime environment; JRE자바 런타임 환경, 자바 실행 환경**

# **1 JDK**

- 자바 소프트웨어 개발 환경
- 자바 소스 코드(.java)를 컴파일할 수 있는 환경
- 자바 컴파일러, 디버거 등의 도구 포함
- JRE 포함
- 개발자용

# **2 JRE**

- 바이트코드 인터프리터
- 자바 응용프로그램이 실행되는 환경
- 컴파일된 파일(.class)를 실행시킬 수 있는 환경
- JDK 없이 JRE만 설치할 수 있음
- [자바 가상머신](https://zetawiki.com/wiki/%EC%9E%90%EB%B0%94_%EA%B0%80%EC%83%81%EB%A8%B8%EC%8B%A0) 등
- 일반 사용자용

![tomcat%20d5e749fa159147bdaab0a0f1e0bb0cb2/Untitled.png](tomcat%20d5e749fa159147bdaab0a0f1e0bb0cb2/Untitled.png)

### 톰캣 환경변수 설정

```jsx
vi /etc/profile

JAVA_HOME=/usr/local/java

JRE_HOME=/usr/local/java

CATALINA_HOME=/usr/local/tomcat

CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$CATALINA_HOME/lib/jsp-api.jar:$CATALINA_HOME/lib/servlet-api.jar

PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin

export JAVA_HOME CLASSPATH PATH CATALINA_HOME JRE_HOME

/ 설정반영 및 변수 확인

source /etc/profile

echo $CATALINA_HOME

/ #### 톰캣 실행

usr/local/apache-tomcat-9.0.35/bin/startup.sh

/ 방화벽 설정 

firewall-cmd --permanent --zone=public --add-port=8080/tcp

firewall-cmd --reload

```

```jsx
** 포트가 LISTEN 되는지 확인

netstat -an | grep 8080

** http://ip주소:8080 접속

** 중지

/usr/local/tomcat/bin/shutdown.sh

```

## yum 설치

**1.tomcat설치**

yum -y install tomcat

yum install -y tomcat-webapps tomcat-admin-webapps

**2.방화벽 포트 열기**

firewall-cmd --add-port=8080/tcp --permanentfirewall-cmd --reloadsystemctl stop tomcatsystemctl start tomcatsystemctl enable tomcat.service

**3.포트 확인**netstat -an | grep 8080

**4.tomcat 계정 생성**

빨간부분(주석)제거

systemctl restart tomcathttp:/Centos7 IP주소/:8080/

**6.hello.jsp수정후 http:/Centos7 IP주소/:8080/sample/hello.jsp접속후확인**vi /var/lib/tomcat/webapps/sample/hello.jsp

vi /var/lib/tomcat/webapps/sample/hello.jsp 수정소스

Licensed to the Apache Software Foundation (ASF) under one or more  contributor license agreements.  See the NOTICE file distributed with  this work for additional information regarding copyright ownership.  The ASF licenses this file to You under the Apache License, Version 2.0  (the "License"); you may not use this file except in compliance with  the License.  You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software  distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and  limitations under the License.--><html><head><title>Sample Application JSP Page</title></head><body bgcolor=white>

<table border="0">

<tr><td align=center><img src="images/tomcat.gif"></td><td><h1>Sample Application JSP Page</h1>This is the output of a JSP page that is part of the Hello, Worldapplication.</td></tr></table>

<%= new String("Hello!") %>

</body></html>

빨간부분 수정후 확인

http:/Centos7 IP주소/:8080/sample/hello.jsp

**JDK, JRE, JVM 차이점**

[제목 없음](tomcat%20d5e749fa159147bdaab0a0f1e0bb0cb2/%E1%84%8C%E1%85%A6%E1%84%86%E1%85%A9%E1%86%A8%20%E1%84%8B%E1%85%A5%E1%86%B9%E1%84%82%E1%85%B3%E1%86%AB%20%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%A5%E1%84%87%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%89%E1%85%B3%205560c2eabb8d4b45a20aa4550a1c85ff.csv)

### Tomcat 디렉토리 구조

---

![https://blog.kakaocdn.net/dn/Zxwts/btqysdtv3Pc/KvhgELtnOVqf6sHKmmqap0/img.png](https://blog.kakaocdn.net/dn/Zxwts/btqysdtv3Pc/KvhgELtnOVqf6sHKmmqap0/img.png)

### /bin

startup, shutdown, 기타 스크립트가 존재한다. sh 파일(유닉스 시스템)과 bat 파일(윈도우 시스템)은 기능적으로 동일하다.

### /conf

설정 파일과 DTD와 연관된 파일이 존재한다. 가장 중요한 파일인 server.xml이 있으며 이 파일은 컨테이너의 주요 설정 파일이다.

### /logs

기본적으로 이 디렉토리에 로그 파일이 생성된다.

### /webapps

기본 webapps가 위치하는 디렉토리이다.

### /lib

classpath에 추가되는 리소스가 위치한 디렉토리이다.

### /work

Jsp 파일을 서블릿 형태로 변환한 java 파일과 class 파일이 저장되는 디렉토리이다.

### /temp

JVM에 사용되는 임시 디렉토리이다.

### bin 디렉토리 파일

---

![https://blog.kakaocdn.net/dn/trdQR/btqyt6UeADh/uSuoCfmpXdDA6fBY9rXhak/img.png](https://blog.kakaocdn.net/dn/trdQR/btqyt6UeADh/uSuoCfmpXdDA6fBY9rXhak/img.png)

bat 파일은 윈도우에서 실행하는 batch 파일, sh 파일은 유닉스 계열에서 실행하는 shell script 파일이다.

### bootstrap.jar

Tomcat 서버가 구동될 때 사용되는 main() 메소드가 포함되어 있으며 클래스 로더가 클래스를 구현하는데에 필수적이다.

### tomcat-juil.jar

로깅을 구현하는 java.util.logging API를 포함하고 있는 클래스이다.

### common-daemon.jar

Apache Commons Daemon 프로젝트에 필요한 클래스이다.

[Catalina.sh](http://catalina.sh/) 파일에 의해 빌드되지 않으며 bootstrap.jar 파일에 의해 참조된다.

### [catalina.sh](http://catalina.sh/)

CATALINA 서버의 제어 스크립트이다.

### [ciphers.sh](http://ciphers.sh/)

지정된 알고리즘을 사용하는 다이제스트 암호를 설정하는 스크립트이다.

### [configtest.sh](http://configtest.sh/)

CATALINA 서버의 설정 스크립트이다.

### [daemon.sh](http://daemon.sh/)

Common Daemon에 사용되는 스크립트이다.

### [digest.sh](http://digest.sh/)

지정된 알고리즘을 사용하는 다이제스트 암호를 설정하는 스크립트이다.

### [makebase.sh](http://makebase.sh/)

Tomcat 실행에 필요한 분산 디렉토리 구조를 생성하는 스크립트이다.

### [setclasspath.sh](http://setclasspath.sh/)

JAVA_HOME 또는 JRE_HOME이 세팅되지 않았을 경우 세팅한다.

### [shutdown.sh](http://shutdown.sh/)

CATALINA 서버를 중지하는 스크립트이다.

### [startup.sh](http://startup.sh/)

CATALINA 서버를 시작하는 스크립트이다.

### [tool-wrapper.sh](http://tool-wrapper.sh/)

커맨드 라인 도구에서 사용되는 Wrapper 스크립트이다.

### [version.sh](http://version.sh/)

Tomcat의 정보를 표시해주는 스크립트이다.

### conf 디렉토리 파일

---

![https://blog.kakaocdn.net/dn/wZMjW/btqyr4XRraS/HTZJZhxkjk3Jwt9D4nACPk/img.png](https://blog.kakaocdn.net/dn/wZMjW/btqyr4XRraS/HTZJZhxkjk3Jwt9D4nACPk/img.png)

### catalina.policy

Tomcat의 보안 정책을 설정하는 파일이다.

Catlina가 –security 옵션으로 실행될 때 시행되는 보안 정책을 설정할 수 있다.

### catalina.properties

서버를 시작할 때 검색하는 서버, 공유 로더, JAR 등의 정보를 포함한다.

### context.xml

세션, 쿠키 저장 경로등을 지정하는 설정 파일이다.

### jaspic-providers.xml

사용자 인증 제공 방법에 대해 정의한 파일

### logging.properties

Tomcat 인스턴스의 로깅 설정 파일이다.

tomcat-juli.jar 라이브러리를 활용하여 로깅 서비스를 제공한다.

### server.xml

Tomcat 설정에서 가장 중요한 파일이다.

Service, Connector, Host 등과 같은 주요 기능을 설정할 수 있다.

### tomcat-users.xml

Tomcat의 manager 기능을 사용하기 위해 사용자 권한을 설청하는 파일이다.

### web.xml

Tomcat의 환경설정 파일이며 서블릿, 필터, 인코딩 등을 설정할 수 있다.

### lib 디렉토리 파일

---

![https://blog.kakaocdn.net/dn/mZh6X/btqyuF298cY/gzjkpYCM7kVyuDLCZqS0wK/img.png](https://blog.kakaocdn.net/dn/mZh6X/btqyuF298cY/gzjkpYCM7kVyuDLCZqS0wK/img.png)

### annotations-api.jar

자바EE 어노테이션 클래스 파일

### catalina.jar

Tomcat의 Catalina 서블릿 컨테이너를 구현하는 파일

### catalina-ant.jar

Tomcat Catalina Ant 작업 파일

### catalina-ha.jar

고가용성 패키지 파일

### catalina-storeconfig.jar

서버 상태의 흐름을 XML 설정파일로 생성한다.

### catalina-tribes.jar

그룹 커뮤니케이션 패키지 파일

### ecj-*.jar

이클립스 JDT 자바 컴파일러 파일

### el-api.jar

EL 3.0 API 파일

### jasper.jar

Tomcat Jasper JSP 컴파일러와 런타임 파일

### jasper-el.jar

Tomcat Jasper EL 구현 파일

### jsp-api.jap

JSP 2.3 API 파일

### servlet-api.jar

Servlet 4.0 API 파일

### tomcat-api.jar

Tomcat에 의해 정의되는 몇몇 인터페이스 파일

### tomcat-coyote.jar

Tomcat connector와 유틸리티 클래스 파일

### tomcat-dpcp.jar

데이터베이스 커넥션 풀을 구현하는 파일

### tomcat-i18n-**.jar

Tomcat 언어 패키지 파일

### tomcat-jdbc.jar

Tomcat JDBC pool로 알려진 대체 데이터베이스 커넥션 풀을 구현하는 파일

### tomcat-util.jar

Apache Tomcat의 다양한 컴포넌트에서 사용되는 일반 클래스 파일

### tomcat-websocket.jar

WebSocket 1.1 구현 파일

### websocket-api.jar

Websocket 1.1 API 파일