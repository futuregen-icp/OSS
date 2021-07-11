https://www.notion.so/songcloud/PHP-0a4ea94890a14b1ebfd6446a6734c22f

# PHP

## PHP-fpm이란?

PHP(Hypertext Preprocessor)는 C언어를 기반으로 만들어진 서버 측에서 실행되는 서버 사이드 스크립트 언어입니다.

- PHP는 정적인 페이지만을 전달해주는 HTML을 보완하여 동적인 페이지를 표현할 수 있게 도와줍니다.
- 최근에는 HTML과 PHP를 다른 파일로 작성하는 것이 일반적입니다.
- 그리고 따로 작성된 PHP는 웹서버가 아닌 PHP-fpm을 통해 실행된다고 합니다.
1. CGI : CGI(Common Gateway Interface)는 동적인 페이지 구현을 위한 프로그램에 클라이언트의 요청을 전달해주는 프로그램입니다.
2. PHP-fpm : PHP-fpm(PHP FastCGI Process Manager)는 보통의 CGI보다 빠른 버전입니다.
- 외부 PHP 프로그램에 클라이언트의 요청을 전달해줍니다.
- FastCGI는 클라이언트의 요청을 전달할 때마다 새로운 프로세스를 생성하는 것이 아니라 이미 생성된 프로세스를 재활용하는 방식을 사용하여 처리가 빠릅니다.

CGI 와 FASTCGI 차이점

**사용 방안**

- 동적 페이지를 사용할 때 CGI보다 더 빠른 속도로 작업이 진행되도록 할 수 있습니다.

**CGI와 FastCGI**

- 로그인, 게시글 등록과 같이 동적인 페이지 사용 시 웹 외부 프로그램(WAS 등)에서 처리하는 방법이 필요합니다.
- 외부 프로그램이 내용을 전달받아 HTML 파일로 반환하는 단계를 CGI라고 합니다.
- PHP-FPM는 PHP FastCGI Process Manager의 약자로 여기서 FastCGI는 CGI보다 더 빠른 처리를 뜻합니다.

**일반 CGI의 경우**

- 요청(Request)가 인입될 때마다 신규 프로세스를 생성/구동하여 이 과정에서 부하 증가 등의 이슈가 발생됩니다

**FastCGI의 경우**

- FastCGI 실행 시 미리 프로세스를 생성한 뒤 해당 프로세스를 활용함으로써 일반 속도가 빠르고 부하가 적습니다.
- 이론 상으로 볼 시 일반 CGI를 FastCGI를 변경하여 처리할 경우 3~30배의 성능 개선 효과를 볼 수 있습니다.

PHP-FPM 설정파일 구조

![PHP%2019c0e6ef0d3a4656a7f4656ca7523e30/99C2CD4B5FA2355D29.png](PHP%2019c0e6ef0d3a4656a7f4656ca7523e30/99C2CD4B5FA2355D29.png)

**PHP-FPM 폴더 구조**

**bin  - PHP 명령어가 있습니다**

**etc - PHP-FPM 설정파일이 있습니다**

**include  - PHP Module이 정보가 있습니다**

**lib - PHP Engine 있습니다**

**logs - PHP-FPM LOG 파일 있습니다**

**sbin - PHP-FPM 구동파일이 있습니다**

PHP-FPM 동작 구조 이해하기

![PHP%2019c0e6ef0d3a4656a7f4656ca7523e30/9981C0445FA234F52C.png](PHP%2019c0e6ef0d3a4656a7f4656ca7523e30/9981C0445FA234F52C.png)

PHP-FPM은 PHP가 프로세스로 분리되어 운영되고, PHP-FPM이 프로세스로 동작하는데 설정 파일 PHP-FPM.CONF 파일입니다 그리고 PHP-FPM.CONF 파일에 설정 따라 서버의 자원 효율, 서버 부하, 오류 등등에 많은 영향을 미치게 됩니다

그래서 PHP-FPM.CONF 파일에 설정 파일에 내용을 유심히 살펴봐야 됩니다

================================================================

## 1. libmcrypt-2.5.8 설치

```
wget [https://server-talk.tistory.com/attachment/cfile2.uf@99A0E2445EFB5DE9260D87.gz](https://server-talk.tistory.com/attachment/cfile2.uf@99A0E2445EFB5DE9260D87.gz)
```

1) libmcrypt-2.5.8.tar.gz 압축해제

```
# tar zxf libmcrypt-2.5.8.tar.gz
```

2) libmcrypt-2.5.8 소스 트리 구성

```
./configure --prefix=/usr/local/
```

3) libmcrypt-2.5.8 설치 시작

```
# make && make install
```

================================================================

## 2. PHP-FPM 다운로드

```
# wget [https://php-fpm.org/downloads/php-5.2.15-fpm-0.5.14.diff.gz](https://php-fpm.org/downloads/php-5.2.15-fpm-0.5.14.diff.gz)
```

================================================================

## 3. PHP 설치하기

**1) 심볼릭 링크 설정**

```
[root@test php-5.2.15]# ln -s /usr/lib64/libjpeg.so /usr/lib/
[root@test php-5.2.15]# ln -s /usr/lib64/libpng.so /usr/lib/
```

**2) PHP 압축해제**

```
[root@test php-5.2.15]# tar zxf php-5.2.15.tar.gz
```

**3) PHP, PHP-FPM 패치**

```
[root@test php-5.2.15]# gzip -cd php-5.2.15-fpm-0.5.14.diff.gz | patch -d php-5.2.15 -p1
```

4) 패치파일 이동 및 패치

```
# wget [https://server-talk.tistory.com/attachment/cfile2.uf@991AD23F5EFC39B0369FD5.patch](https://server-talk.tistory.com/attachment/cfile2.uf@991AD23F5EFC39B0369FD5.patch)

[root@ ~]# mv libxml29_compat.patch php-5.2.15

[root@ ~]# cd php-5.2.15

[root@ php-5.2.15]# patch -p0 < ./libxml29_compat.patch
```

configure 설정 전 curl, curl-devel 설치

```
# yum -y install curl curl-devel
```

5) PHP 소스트리 구성

```

[root@test php-5.2.15]# ./configure --prefix=/usr/local/src/libmcrypt/php/ 
--with-mysql=/usr/local/src/libmcrypt/mysql 
--with-mysqli=/usr/local/src/libmcrypt/mysql/bin/mysql_config
--with-curl 
--disable-debug 
--enable-safe-mode 
--enable-sockets 
--enable-sysvsem=yes  
--enable-sysvshm=yes 
--enable-ftp 
--enable-magic-quotes  
--with-ttf 
--enable-gd-native-ttf 
--enable-inline-optimization 
--enable-bcmath 
--with-zlib 
--with-gd 
--with-gettext 
--with-jpeg-dir=/usr 
--with-png-dir=/usr/lib64 
--with-freetype-dir=/usr 
--with-libxml-dir=/usr 
--enable-exif 
--enable-sigchild 
--enable-mbstring 
--enable-fastcgi 
--enable-fpm 
--with-openssl 
--enable-soap

-생략-

+--------------------------------------------------------------------+
|                        *** WARNING ***                             |
|                                                                    |
| You will be compiling the CGI version of PHP without any           |
| redirection checking.  By putting this cgi binary somewhere in     |
| your web space, users may be able to circumvent existing .htaccess |
| security by loading files directly through the parser.  See        |
| [http://www.php.net/manual/security.php](http://www.php.net/manual/security.php) for more details.           |
+--------------------------------------------------------------------+
| License:                                                           |
| This software is subject to the PHP License, available in this     |
| distribution in the file LICENSE.  By continuing this installation |
| process, you are bound by the terms of this license agreement.     |
| If you do not agree with the terms of this license, you must abort |
| the installation process at this point.                            |
+--------------------------------------------------------------------+

Thank you for using PHP.
```

6) PHP 설치시작

```
[root@test php-5.2.15]# make && make install

Build complete.
Don't forget to run 'make test'.
Installing PHP SAPI module:       cgi
Installing PHP CGI binary: /usr/local/src/libmcrypt/php//bin/
Installing FPM config:            /usr/local/src/libmcrypt/php//etc/php-fpm.conf
Installing init.d script:         /usr/local/src/libmcrypt/php//sbin/php-fpm
Installing PHP CLI binary:        /usr/local/src/libmcrypt/php//bin/
Installing PHP CLI man page:      /usr/local/src/libmcrypt/php//man/man1/
Installing build environment:     /usr/local/src/libmcrypt/php//lib/php/build/
Installing header files:          /usr/local/src/libmcrypt/php//include/php/
Installing helper programs:       /usr/local/src/libmcrypt/php//bin/
program: phpize
program: php-config
Installing man pages:             /usr/local/src/libmcrypt/php//man/man1/
page: phpize.1
page: php-config.1
Installing PEAR environment:      /usr/local/src/libmcrypt/php//lib/php/
[PEAR] Archive_Tar    - installed: 1.3.7
[PEAR] Console_Getopt - installed: 1.2.3
[PEAR] Structures_Graph- installed: 1.0.3
[PEAR] XML_Util       - installed: 1.2.1
[PEAR] PEAR           - installed: 1.9.1
Wrote PEAR system config file at: /usr/local/src/libmcrypt/php//etc/pear.conf
You may want to add: /usr/local/src/libmcrypt/php//lib/php to your php.ini include_path
Installing PDO headers:          /usr/local/src/libmcrypt/php//include/php/ext/pdo/
```

7) **PHP 설정파일 복사**

```
[root@test php-5.2.15]# cp -a php.ini-dist /usr/local/src/libmcrypt/php/lib/php.ini
```

8) PHP-FPM 구동 스크립트

```
[root@test php-5.2.15]# cd /etc/init.d/

[root@test init.d]# ln -s /usr/local/src/libmcrypt/php/sbin/php-fpm /etc/init.d/php-fpm
```

9) PHP-FPM 설정파일 데몬 계정 주석 해제 - 63번 66번 줄 주석해제

```
[root@test init.d]# vim /usr/local/src/libmcrypt/php/etc/php-fpm.conf

63 <value name="user">nobody</value>
66 <value name="group">nobody</value>
```

10) PHP-FPM IP와 Port 설정 - 41번줄

```
<value name="listen_address">192.168.1.100:9000</value>
```

11) PHP-FPM이 허용하게될 FastGCI의 IP를 입력 - 137번줄

```
<value name="allowed_clients">192.168.1.100</value>
```

12) PHP-FPM 실행

```
[root@test init.d]# /etc/init.d/php-fpm start

Starting php_fpm  done
```

================================================================
