# httpd module install 

## mod_jk install

### connector install

```
cd /ICS/src
tar zxvfp  tomcat-connectors-1.2.48-src.tar.gz
cd /ICS/src/tomcat-connectors-1.2.48-src/native
./configure --with-apxs=/ICS/httpd-2.4.46/bin/apxs 
make 
make install
```

확인

```
[root@oss native]# ls -al /ICS/httpd-2.4.46/modules/
...
-rwxr-xr-x.  1 root root 1666280 10월  5 21:44 mod_jk.so
...
```



### httpd configration

```
vi /ICS/httpd-2.4.46/conf/workers.properties

worker.list=tomcatA,tomcatB,lb1
## [Tomcat1] ##
worker.tomcatA.type=ajp13
worker.tomcatA.host= 127.0.0.1
worker.tomcatA.port=8009
worker.tomcatA.lbfactor=1
worker.tomcatA.fail_on_status=500,503 # HTTP Error Code
worker.tomcatA.socket_connect_timeout=1000 #ms default = socket_timeout
worker.tomcatA.socket_timeout=60 #second default 0 (unlimited)
worker.tomcatA.retries=1 # default 2
worker.tomcatA.retry_interval=100 # default 100 ms

worker.tomcatB.type=ajp13
worker.tomcatB.host= 127.0.0.1
worker.tomcatB.port=9009
worker.tomcatB.lbfactor=1
worker.tomcatB.fail_on_status=500,503 # HTTP Error Code
worker.tomcatB.socket_connect_timeout=1000 #ms default = socket_timeout
worker.tomcatB.socket_timeout=60 #second default 0 (unlimited)
worker.tomcatB.retries=1 # default 2
worker.tomcatB.retry_interval=100 # default 100 ms

## [Balance] ##
worker.lb1.type=lb
worker.lb1.balance_workers=tomcatA
#worker.lb1.sticky_session=1
worker.lb1.recover_time=600 #second default 60
```



```
vi /ICS/httpd-2.4.46/conf/extra/httpd-mod-jk.conf

LoadModule jk_module modules/mod_jk.so

<IfModule mod_jk.c>
	JkWorkersFile conf/workers.properties
	JkLogFile /sdi/log/web/apache/jk.log
	JkLogLevel error
	JkLogStampFormat "[%a %b %d %H:%M:%S %Y]"
	JkRequestLogFormat "%w %R %V %T %U %q"
</IfModule>
```



```
<VirtualHost *:80>
	DocumentRoot "/ICS/httpd-2.4.46/htdocs"
	ServerName 192.168.1.241
	#ServerAlias DOMAIN.com
	ErrorLog "/ICS/was/tomcat-9.0.38/logs/DOMAIN-error_log"
	CustomLog "/ICS/was/tomcat-9.0.38/logs/DOMAIN-access_log" combined
	#JkMount /*.jsp lb1
	#JkMount /*.do lb1
	JkMount /* lb1
</VirtualHost>
```

### Tomcat configration

```
   vi /ICS/was/tomcat-9.0.38/conf/server.xml
   
   <!-- Define an AJP 1.3 Connector on port 8009 -->
    <!-- -->
    <Connector protocol="AJP/1.3"
               address="127.0.0.1"
               port="8009"
               secretRequired="false"
               redirectPort="8443" />
    <!-- -->                              
```



## 추가 확인 부분 

secretRequired = true 로 설정가능한지

