# HTTPD REWRITE - REDIRECT



## Redirect 와  rewite 비교 



| redirect                                                     | rewrite                                             |
| ------------------------------------------------------------ | --------------------------------------------------- |
| 클라이언트 사이드                                            | 서버 사이드                                         |
| redirect : 상태 코드에 따라 다름<br /> - 301 : Move Permanently<br />- 302 Found<br />-307: Temporary Redirect | redirect : 상태 코드와 관련이 없음                  |
| 예시)<br />                                                  | 예시)<br />                                         |
| 동일한 사이트 또는 다른 사이트로 이동 시 사용                | 보통 동일한 사이트 내에 상대패스를 이용하여 rewrite |





## 도메인 URL 재작성 

### redirect

```
<VirtualHost *>
  ServerName  httpd-1.home.igotit.co.kr
  ServerAdmin devkuma@devkuma.com
  DocumentRoot  /var/www/html

  redirect / http://httpd-2.home.igotit.co.kr/

</VirtualHost>

```



### rewrite (redirect)

```
<VirtualHost *>
  ServerName  httpd-1.home.igotit.co.kr
  ServerAdmin devkuma@devkuma.com
  DocumentRoot  /var/www/html

  RewriteEngine On
  RewriteCond %{HTTP_HOST} ^(httpd-1\.home\.igotit\.co\.kr)
  RewriteRule (.*)  http://httpd-2.home.igotit.co.kr/$1  [R,L]

</VirtualHost>

```




### rewrite (proxy)

```
<VirtualHost *>
  ServerName  httpd-1.home.igotit.co.kr
  ServerAdmin devkuma@devkuma.com
  DocumentRoot  /var/www/html

  RewriteEngine On
  RewriteCond %{HTTP_HOST} ^(httpd-1\.home\.igotit\.co\.kr)
  RewriteRule (.*)  http://httpd-2.home.igotit.co.kr/$1  [P,L]

</VirtualHost>

```



## 테스트 결과 

### redirect

```
[root@httpd-2 ~]# curl http://httpd-2.home.igotit.co.kr
<html>
        <head>httpd-2</head>
<body>
<h1> httpd-2 </h1>
</body>
</html>

[root@httpd-2 ~]# curl http://httpd-1.home.igotit.co.kr
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>302 Found</title>
</head><body>
<h1>Found</h1>
<p>The document has moved <a href="http://httpd-2.home.igotit.co.kr/">here</a>.</p>
</body></html>
[root@httpd-2 ~]#

```



### rewrite (redirect)

```
[root@httpd-2 ~]# curl http://httpd-2.home.igotit.co.kr
<html>
        <head>httpd-2</head>
<body>
<h1> httpd-2 </h1>
</body>
</html>

[root@httpd-2 ~]# curl http://httpd-1.home.igotit.co.kr
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>302 Found</title>
</head><body>
<h1>Found</h1>
<p>The document has moved <a href="http://httpd-2.home.igotit.co.kr//">here</a>.</p>
</body></html>
[root@httpd-2 ~]#

```



### rewrite (proxy)

```
[root@httpd-2 ~]# curl http://httpd-2.home.igotit.co.kr
<html>
        <head>httpd-2</head>
<body>
<h1> httpd-2 </h1>
</body>
</html>

[root@httpd-2 ~]# curl http://httpd-1.home.igotit.co.kr
<html>
        <head>httpd-2</head>
<body>
<h1> httpd-2 </h1>
</body>
</html>
[root@httpd-2 ~]#


```



## DeploymentConfig

```
    spec:
      volumes:
        - name: rewrite
          configMap:
            name: rewrite
            items:
              - key: virtualhost.conf
                path: virtualhost.conf
            defaultMode: 420
      containers:
        - resources:
...
          volumeMounts:
            - name: rewrite
              mountPath: /etc/httpd/conf.d/virtualhost.conf
              subPath: virtualhost.conf
```



## ConfigMap

```
kind: ConfigMap
apiVersion: v1
metadata:
  name: rewrite
  namespace: test
data:
  virtualhost.conf: |-
    <VirtualHost *>
    ServerName  httpd-2.home.igotit.co.kr
    ServerAlias localhost
    ServerAdmin devkuma@devkuma.com
    DocumentRoot  /var/www/html
    RewriteEngine On
    RewriteCond %{HTTP_HOST} ^(localhost)
    RewriteRule (.*)  http://httpd-2.home.igotit.co.kr/$1  [R,L]
    #   redirect / http://httpd-2.home.igotit.co.kr/
    </VirtualHost>
```





