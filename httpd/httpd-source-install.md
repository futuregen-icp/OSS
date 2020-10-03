# Apache-HTTPD install for source 

## 요구사항 

### 방화벽 

```
http service  port  : 80
https service port : 443
```



### 필수 라이브러리

```
apache runtime and apache runtime util
pcre install
Perl 5
gcc 
Disk space 50MB 이상
```



## 초기 설치 구성

### OS 구성 방법

```
Minimal Install
```



### 기본 라이브러리 설치 

```
yum groupinstall "Container Management"
yum groupinstall "RPM Development Tools"
yum groupinstall "Development Tools"
yum groupinstall "Headless Management"
yum groupinstall "Legacy UNIX Compatibility"
yum groupinstall "System Tools"
```



### 추가 설치 패키지

```
yum install expat-devel
yum install openssl-devel
```



### 사용포트 방화벽 열기

	firewall-cmd --permanent --zone=public --add-service=http
	firewall-cmd --permanent --zone=public --add-service=https

​		

### 디렉토리 생성 및 파일 다운로드

```
mkdir /ICS
mkdir /ICS/src
cd /ICS/src

wget http://archive.apache.org/dist/httpd/httpd-2.4.46.tar.gz
wget http://archive.apache.org/dist/apr/apr-1.7.0.tar.gz
wget http://archive.apache.org/dist/apr/apr-util-1.6.1.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz 
```



## 설치 과정 

### apache runtime install

```
cd /ICS/src 
tar xvfpz apr-1.7.0.tar.gz
cd apr-1.7.0
./configure --prefix=/ICS/utils/
make
make install

[root@oss apr-1.7.0]# ls /ICS/utils/bin/
apr-1-config
```



### apache runtime util install

```
cd /ICS/src 
tar xvfpz apr-util-1.6.1.tar.gz
cd apr-util-1.6.1
./configure --prefix=/ICS/utils/ --with-apr=/ICS/utils/
make
make install

[root@oss apr-util-1.6.1]# ls /ICS/utils/bin/
apr-1-config  apu-1-config
```



### pcre install

```
cd /ICS/src 
tar xvfpz pcre-8.44.tar.gz
cd pcre-8.44
./configure --prefix=/ICS/utils/
make
make install

[root@oss pcre-8.44]# ls /ICS/utils/bin/
apr-1-config  apu-1-config  pcre-config  pcregrep  pcretest
```



### apache https install

```
cd /ICS/src 
tar xvfpz httpd-2.4.46.tar.gz
cd httpd-2.4.46
./configure --prefix=/ICS/httpd-2.4.46/ --enable-modules=most --enable-mods-shared=all --enable-so \
            --enable-rewrite --enable-ssl \
             --with-mpm=event --with-apr=/ICS/utils/ --with-apr-util=/ICS/utils/ --with-pcre=/ICS/utils/
make
make install

ln -s /ICS/httpd-2.4.46 /ICS/httpd
mkdir /ICS/httpd-2.4.46/run




*** httpd.conf 수정 ***

AS-IS 
erverRoot "/ICS/httpd-2.4.46/"

TO-BE
erverRoot "/ICS/httpd-2.4.46/"
PidFile "/ICS/httpd-2.4.46/run/httpd.pid"
```



### service 등록

```
vi /etc/systemd/system/httpd.service
[Unit]
Description=The Apache HTTP Server

[Service]
Type=forking
#EnvironmentFile=/ICS/httpd/bin/envvars
PIDFile=/ICS/httpd/run/httpd.pid
ExecStart=/bin/bash /ICS/httpd/bin/apachectl start
ExecReload=/bin/bash /ICS/httpd/bin/apachectl graceful
ExecStop=/bin/bash /ICS/httpd/bin/apachectl stop
KillSignal=SIGCONT
PrivateTmp=true

[Install]
WantedBy=multi-user.target


systemctl daemon-reload
systemctl enable httpd
```



### SELinux 설정 

```
 *** httpd 설정 ***
 
 semanage fcontext -a -t httpd_config_t -s system_u "/ICS/httpd-2.4.46/conf(/.*)?"
 semanage fcontext -a -t httpd_exec_t -s system_u "/ICS/httpd-2.4.46/bin(/.*)?"
 semanage fcontext -a -t httpd_log_t -s system_u "/ICS/httpd-2.4.46/logs(/.*)?"
 semanage fcontext -a -t httpd_sys_rw_content_t -s system_u "/ICS/httpd-2.4.46/htdocs(/.*)?"
 semanage fcontext -a -t httpd_sys_rw_content_t -s system_u "/ICS/httpd-2.4.46/manual(/.*)?"
 semanage fcontext -a -t httpd_sys_rw_content_t -s system_u "/ICS/httpd-2.4.46/error(/.*)?"
 semanage fcontext -a -t httpd_modules_t -s system_u "/ICS/httpd-2.4.46/modules(/.*)?"
 semanage fcontext -a -t httpd_sys_script_exec_t -s system_u "/ICS/httpd-2.4.46/cgi-bin(/.*)?"
 semanage fcontext -a -t httpd_rotatelogs_exec_t -s system_u "/ICS/httpd-2.4.46/bin/rotatelogs"
 semanage fcontext -a -t httpd_var_run_t -s system_u "/ICS/httpd-2.4.46/run(/.*)?"

 restorecon -Rvf /ICS/httpd-2.4.46

 chcon -t  httpd_config_t -u system_u /ICS/httpd-2.4.46/conf -R
 chcon -t  httpd_exec_t -u system_u /ICS/httpd-2.4.46/bin -R
 chcon -t  httpd_log_t -s system_u /ICS/httpd-2.4.46/logs -R
 chcon -t  httpd_sys_rw_content_t -s system_u /ICS/httpd-2.4.46/htdocs -R 
 chcon -t  httpd_sys_rw_content_t -s system_u /ICS/httpd-2.4.46/manual -R 
 chcon -t  httpd_sys_rw_content_t -s system_u /ICS/httpd-2.4.46/error -R
 chcon -t  httpd_modules_t -s system_u /ICS/httpd-2.4.46/modules -R
 chcon -t  httpd_sys_script_exec_t -s system_u /ICS/httpd-2.4.46/cgi-bin -R
 chcon -t  httpd_rotatelogs_exec_t -s system_u /ICS/httpd-2.4.46/bin/rotatelogs
 chcon -t  httpd_var_run_t -s system_u /ICS/httpd-2.4.46/run -R
 
 *** 연관 라이브러리 설정 ***
 semanage fcontext -a -t lib_t "/ICS/utils/lib(/.*)?"
 restorecon -Rv /ICS/utils/lib
```



## 구동 방법

```
구동  : systemctl start httpd
중지  : systemctl stop httpd
재시작 : systemctl restart httpd
```

