# haproxy roundrobin 설정 및 확인

```jsx
#---------------------------------------------------------------------
# main frontend which proxys to the backends
#---------------------------------------------------------------------
frontend  main *:80
    acl url_static       path_beg       -i /static /images /javascript /stylesheets
    acl url_static       path_end       -i .jpg .gif .png .css .js

    use_backend static          if url_static
    default_backend             app

#---------------------------------------------------------------------
# static backend for serving up images, stylesheets and such
#---------------------------------------------------------------------
backend static
    balance     roundrobin
    server      static 127.0.0.1:4331 check

#---------------------------------------------------------------------
# round robin balancing between the various backends
#---------------------------------------------------------------------
backend app
    balance     roundrobin
    server  app1 192.168.6.31:8080 check
    server  app2 192.168.6.31:80 check
#    server  app3 127.0.0.1:5003 check
#    server  app4 127.0.0.1:5004 check
#---------------------------------------------------------------------
# test
#--------------------------------------------------------------------
listen stats // 
  bind  :9000
  mode  http

  stats enable
  stats uri /haproxy_stats
  stats auth  admin:admin

# haproxy -f /etc/haproxy/haproxy.cfg -c #설정완료후 설정파일에 문법 오류 없는지 확인

```

- http://서버ip:9000/haproxy_stats 확인시

![haproxy%20roundrobin%20%E1%84%89%E1%85%A5%E1%86%AF%E1%84%8C%E1%85%A5%E1%86%BC%20%E1%84%86%E1%85%B5%E1%86%BE%20%E1%84%92%E1%85%AA%E1%86%A8%E1%84%8B%E1%85%B5%E1%86%AB%206ba0d4360888417289fa6d31cf2cbe45/Untitled.png](haproxy%20roundrobin%20%E1%84%89%E1%85%A5%E1%86%AF%E1%84%8C%E1%85%A5%E1%86%BC%20%E1%84%86%E1%85%B5%E1%86%BE%20%E1%84%92%E1%85%AA%E1%86%A8%E1%84%8B%E1%85%B5%E1%86%AB%206ba0d4360888417289fa6d31cf2cbe45/Untitled.png)

- haproxy acl alise 맵핑

[How to Map Domain Names to Backend Server Pools with HAProxy - HAProxy Technologies](https://www.haproxy.com/blog/how-to-map-domain-names-to-backend-server-pools-with-haproxy/)

**설정파일 구성**

global, defaults, listen, frontend, backend의 영역으로 구분 됨.

global은 전체 영역에 걸쳐 적용되는 기본 설정을 담당.

defaults는 이후 오는 영역(frontend, backend, listen)에 적용되는 설정.

frontend는 클라이언트 연결을 받아들이는 소켓에 대한 설정.

backend는 앞에서 들어온 연결에 할당될 프록시 서버들에 대한 설정

listen : frontend와 backend로 사용되는 포트를 한번에 설정하는 영역. TCP 프록시에서만 이용됨.

[HAProxy 설정 및 실행](https://arisu1000.tistory.com/27739)