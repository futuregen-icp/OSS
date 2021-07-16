# MariaDB / MySql

MYSQL은 전세계적으로 가장 널리 사용되고 있는 오픈 소스 데이터베이스이며, MySQL AB사가 개발하여 배포/판매하고 있는 데이터베이스(DataBase)이다.

표준 데이터베이스 질의 언어 SQL(Structured Query Language)을 사용하는 개방 소스의 관계형 데이터베이스 관리 관리시스템(RDBMS), 매우 빠르고, 유연하며, 사용하기 쉬운 특징이 있다.

다중사용자, 다중 쓰레드를 지원하고, C, C++, Eiffel, 자바, 펄, PHP, Pyton 스크립트 등을 위한 응용프로그램 인터페이스(API)를 제공한다.

유닉스나 리눅스, Windows 운영체제 등에서 사용할 수 있다.

LAPM 즉 리눅스 운영체제와 Apahe 서버 프로그램, MySQL, PHP 스크립트 언어 구성은 상호 연동이 잘되면서도 오픈소스로 개발되는 무료 프로그램이어서 홈페이지나 소핑몰 등등 일반적인 웹 개발에 널리 사용되고 있다.

# ****데이터베이스(Database)란?**

어느 한 조직의 여러 응용 시스템이 공유할 수 있도록 통합. 저장된 운영 데이터의 집합을 의미한다.

테이터베이스의 특징

데티어베이스는 질의에 대한 실시간 처리 및 응답을 처리할 수 있도록 실시간 접근과 삽입, 삭제 갱신을 통해서 현재의 데이터를 동적으로 유지할 수 있는 계속적인 변화를 제공하며, 여러 사용자가 동시에 공용할 수 있는 동시 공유와 위치나 주소가 아닌 내용, 즉 값에 따라 참조할 수 있는 내용에 의한 참조의 특징을 지니고 있다.

**데이터베이스 구성요소**

데이터베스에서는 어떤 목석을 가지고 있는 하나의 테이블로 정의한다.

테이블을 이용할 경우 편리성을 제공하기 위해서는 필드를 상세하게 정의하는 것이 좋다

**데이터베이스 관리 시스템(DBMS)**

DBMS는 응용 프로그램과 데이터의 중재자로서 모든 응용 프로그램들이 데이터베이스를 공유할 수 있도록 관리해 주는 소프트웨어 시스템이다. 목적은 데이터의 독립성을 제공하는 것이다

데이터의 독립성에는 응용 프로그램에 영향을 주지 않고, 데이터베이스의 논리적인 구조를 변경시킬 수 있는 물리적 데이터의 독립성이 있다. MySQL도 DBMS의 한종류이다.

**MySQL 데이터베이스의 특징**

PHP 웹 프로그래밍에서 사용되는 DBMS는 MySQL이며, MySQL이 가지고 있는 특징을 살펴보면, 가장 먼저 꼽을 수 있는 것은 일반 사용자가 무료로 다운로드하여 사용할 수 있는 장점이다

MySQL은 공개용 소프트웨어이기 때문에 누구나 무료로 다운로드받아 사용 할 수 있지만, 상업적인 목적으로 MySQL을 사용하려면 반드시 라이센스를 별도로 구매하여야 한다. MySQL은 무료이면서 처리되는 속도 또한 상당히 빠르고 용이하며, 대용량의 데이터를 처리할 수 있는 장점과 보안에도 뛰어난 특성을 지니고 있습니다.

# MariaDB

### MariaDB가 나오게 된 배경

우선 MariaDB는 MySQL 커뮤니티 코드 베이스를 이용해 탄생했다.사실 MariaDB가 나오게 된 배경에는 오라클의 Mysql 인수 때문이다.

MySQL은 1995년 오픈소스로 제작된 DBMS로 무료이며 대용량 데이터를 처리할 수 있어 인기가 좋았다.2008년도에 Sun Microsystems에 인수되어 관리됐는데, 2010년도에 Sun Microsystems가 오라클에 인수되며 MySQL의 개발자들은 오라클 소속으로 개발을 진행하게 된다.

오라클은 MySQL을 유료화 하고, 이에 발끈한 창업자 몬티는 일부 개발자들과 오라클 사를 나와 MariaDB사를 설립하고 MariaDB를 개발하게 된다.

### MariaDB의 특징

아무래도 MySQL의 핵심 개발자들이 기존의 시스템을 발전시켜서 만들었기 때문에 MySQL에 비해 성능이 좋다는 인식이 있다. 하지만 여러 다른 블로그를 확인해 본 결과 시나리오나 상황에 따라 결과가 다르게 나올수도 있다는 글을 읽었다.

[10 reasons to migrate to MariaDB (if still using MySQL)](https://linuxnatives.net/2015/10-reasons-to-migrate-to-mariadb-if-still-using-mysql)

위의 링크에서는 MySQL에서 MariaDB로 마이그레이션 해야하는 10가지 이유를 말하는데, 요약하자면 다음과 같다.

1) 좀 더 개방적이고 활발한 MariaDB

2) 빠르고 투명한 보안패치

3) 보완된 기능

4) 더 많은 Storage Engine5) 나은 성능

6) Galera 액티브-액티브 마스터 클러스터링

7) 오라클 관리하의 MySQL의 불확실성

8) 인기가 많아짐

9) 뛰어난 호환성, 쉬운 마이그레이션

10) 15년도 이후에는 마이그레이션이 어려울 수 있음.

MariaDB를 사용한 사람들은 주로 아래와 같은 이유를 장점으로 꼽았다.

- 가볍고 처리속도가 빠름
- 라이센스가 자유로움 -> 공짜
- 호환이 완벽하기에 갈아타기 쉬움

================================================================

## **1. MySQL 설치**

**MySQL 파일 : mysql-5.1.73.tar.gz**

1) 계정생성

```
# adduser -M -s /bin/false mysql
```

2) MySQL Config

```
# tar zxf mysql-5.1.73.tar.gz

# cd mysql-5.1.51

# ./configure --prefix=/usr/local/src/libmcrypt/mysql 
--enable-thread-safe-client 
--localstatedir=/usr/local/src/libmcrypt/mysql/data 
--enable-shared 
--with-mysqld-user=mysql 
--with-charset=euckr 
--with-extra-charsets=all 
--with-libedit 
--enable-assembler 
--sysconfdir=/etc
```

다운받은 MySQL 압축해제 후 Config 설정

3) 설치 시작

```
# make && make install
```

4) 설치된 mysql 경로 권한 설정

```
# chown mysql.mysql /usr/local/src/libmcrypt/mysql -R
```

5) 인스톨 스크립트 실행

```
# /usr/local/src/libmcrypt/mysql/bin/mysql_install_db --user=mysql
```

6) my.cnf 생성

```
# cp /usr/local/src/libmcrypt//mysql/share/mysql/my-huge.cnf /etc/my.cnf
```

7) mysql 구동 파일 복사

```
# cp -a /usr/local/src/libmcrypt/mysql/share/mysql/mysql.server /etc/rc.d/init.d/mysqld
```

8) mysql 데몬 구동

```
# /etc/rc.d/init.d/mysqld start
```

9 )MySQL 관리자 계정설정

```
# /usr/local/src/libmcrypt/mysql/bin/mysqladmin -u root password root
```

10) 부팅시 MySQL 시작

```
# chkconfig mysqld on
```

11) mysql 동작 확인

```
mysql -u root -proot

Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 5
Server version: 5.1.73-log Source distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| test               |
+--------------------+
3 rows in set (0.00 sec)

MySQL [(none)]>
```