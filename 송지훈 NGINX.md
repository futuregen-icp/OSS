https://www.notion.so/songcloud/Nginx-8dafd7c5ce80476289f6e4c2db8479f0

# Nginx

# 설치 및 연동

# 2021/07-05 ~ 2021/07-09 (2주)

## **Nginx**

- apache의 한 시스템에 동시 접속자 수가 1만명이 넘어갈 때, 효율적이지 못한 문제를 해결하기 위해 나온 **Event-Driven 구조의 웹 서버 SW**
- 가벼움과 높은 성능을 목표로 탄생
- 웹 서버, 리버스 프록시, 메일 프록시
    - 리버스 프록시
        - 컴퓨터 네트워크에서 클라이언트를 대신해서 한 대 이상의 서버로부터 자원을 추출하는 프록시 서버의 일종
        - 자원들을 웹 서버 자체에 가지고 있는 것처럼 (origin 처럼) 클라이언트로 반환
        - 목적지에 직접 접근하지 않고 프록시를 통해 데이터를 주고 받는 포워드 프록시와 반대되는 개념으로, 리버스 프록시는 다른 서버의 정보를 프록시를 통해 받아오는 중간 매개체
        - 사용자가 요청하는 Endpoint는, 접근하고자 하는 최종 목적지 서버가 아닌, 리버스 프록시
        - 리버스 프록시는 사용자의 Endpoint가 리버스 프록시의 Domain Name이 된다. 사용자는 항상 리버스 프록시의 주소인 reverse.proxy.com 과 같이 요청하게 되고, 리버스 프록시는 back-end 단에 있는 여러 서버들 중 하나로부터 응답을 받아와 사용자에게 반환

### **Apache VS Nginx**

- **Apache**
    - Client가 HTTP 요청을 보낼 때, MPM(Multi Process Module)을 사용해서 처리한다.
    - MPM
        - PreFork (다중 프로세스 처리)
            - 요청에 대해 default 개수만큼 자식 프로세스를 생성해서 처리하고, 요청이 많을 경우 Process를 생성해서 처리하는 방식
        - Worker 방식(멀티프로세스 - 스레드)
            - Prefort와 같은 방법으로 자식 프로세스 생성하고, 요청이 많을 경우 각 프로세스의 스레드를 생성해서 처리하는 구조
    - 동시 접속 요청이 많아질수록 프로세스나 스레드 생성 비용이 들고, 대용량 요청에 대한 한계를 드러냄

- Apache 병렬처리 동작방식

    기본적으로 Apache는 Process 기반 방식으로 클라이언트 요청들을 처리한다.요청에따라 프로세스를 생성하는 `MPM(Multi Process Module)-prefork` 방식과 프로세스와 쓰레드를 병행해서 사용하는 `MPM-worker` 두가지 방법이 있다.

    ![Nginx%20fbe662885088409c88bdf9fd81385525/nginx-event-driven_1.png](Nginx%20fbe662885088409c88bdf9fd81385525/nginx-event-driven_1.png)

- **Nginx**
    - **Event-Driven** 방식으로 한개의 고정된 프로세스만 생성한다.
    - **요청에 대한 처리는 스레드에 의존하지 않고 프로세스 내부에서 비동기 방식으로 작업을 처리**한다.
    - 동시 접속 요청이 많아도 프로세스나 스레드 생성 비용이 존재하지 않음
    - 문제점
        - **Event 처리 시간이 길어져 단일 Thread를 점유하고 있으면, 다른 Event 처리도 늦어지는 Blocking 현상이 발생**
        - 주로 Dist 동작이 동반되는 File Read/Write의 경우, 오랜 시간 스레드를 점유할 수 있는 Blocking의 주요 원인
        - **[Nginx third-party modules](https://www.nginx.com/resources/wiki/modules/)**들의 처리 시간이 긴 함수도 원인이 될 수 있음
    - 이런 Blocking 문제를 해결하기 위해 Nginx의 **Thread Pool** 기법이 고안됨

- Nginx 병렬처리 동작방식

    Nginx는 event-driven 즉, 이벤트 구동방식으로 클라이언트 요청 병렬처리를 진행한다. 이는 입출력 이벤트를 감지해 처리가 필요할때 시그널을 통해 처리한다.기본적으로 싱글 프로세스 기반으로 이벤트를 받는 reactor와 이벤트를 실제 처리를 위한 worker로 전달하기위한 handler등으로 구성되어 처리단위로 동작하게된다.

    ![Nginx%20fbe662885088409c88bdf9fd81385525/nginx-event-driven_2.png](Nginx%20fbe662885088409c88bdf9fd81385525/nginx-event-driven_2.png)

### **Nginx Thread pool**

- NGINX version 1.7.11 과 NGINX Plus Release 7 부터 Thread pool 방식이 도입
- worker process가 긴 작업을 실행해야하는 경우, 직접 실행하지 않고 task queue에 작업을 넘긴다. task queue는 thread pool에서 작업을 수행할 수 있는 스레드에게 작업을 주고, 완료되면 다시 worker process에게 완료된 결과를 전달한다.

    ![Nginx%20fbe662885088409c88bdf9fd81385525/thread-pools-worker-process-event-cycle.png](Nginx%20fbe662885088409c88bdf9fd81385525/thread-pools-worker-process-event-cycle.png)

- **이 기법을 활용하면, 하나의 worker thread가 Blocking 되어도 나머지 worker thread가 작동하는데 영향이 없기 때문에, Blocking 문제를 해결할 수 있다.**

### 프로세스(process)란?

프로세스(process)란 단순히 실행 중인 프로그램(program)이라고 할 수 있습니다.

즉, 사용자가 작성한 프로그램이 운영체제에 의해 메모리 공간을 할당받아 실행 중인 것을 말합니다.

이러한 프로세스는 프로그램에 사용되는 데이터와 메모리 등의 자원 그리고 스레드로 구성됩니다.

### 스레드(thread)란?

스레드(thread)란 프로세스(process) 내에서 실제로 작업을 수행하는 주체를 의미합니다.

모든 프로세스에는 한 개 이상의 스레드가 존재하여 작업을 수행합니다.

또한, 두 개 이상의 스레드를 가지는 프로세스를 멀티스레드 프로세스(multi-threaded process)라고 합니다.

nginx 설치 과정

```
# vi /etc/yum.repos.d/nginx.repo

EX)
[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/mainline/<OS>/<OSRELEASE>/$basearch/
gpgcheck=0
enabled=1

[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1

# yum update

# yum install nginx

# nginx

# curl -I 127.0.0.1

# vim /etc/nginx/conf.d/default.conf
server {
    listen       8080; <-80에서 포트가 안겹치게 8080으로 변경
    server_name  localhost;

    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;

# systemctl restart nginx

# vim /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>HI! there!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>HI! I`m jihune</h1>
```

![Nginx%20fbe662885088409c88bdf9fd81385525/1.jpg](Nginx%20fbe662885088409c88bdf9fd81385525/1.jpg)
