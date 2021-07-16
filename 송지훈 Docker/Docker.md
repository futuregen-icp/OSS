# Docker

# 도커란?

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f/docker-works.png](Docker%20ecc89c70aa3f4e05aa818244f1a2125f/docker-works.png)

도커는 **컨테이너 기반의 오픈소스 가상화 플랫폼이**다.

컨테이너라 하면 배에 실는 네모난 화물 수송용 박스를 생각할 수 있는데 각각의 컨테이너 안에는 옷, 신발, 전자제품, 술, 과일등 다양한 화물을 넣을 수 있고 규격화되어 컨테이너선이나 트레일러등 다양한 운송수단으로 쉽게 옮길 수 있다.

서버에서 이야기하는 컨테이너도 이와 비슷한데 다양한 프로그램, 실행환경을 컨테이너로 추상화하고 동일한 인터페이스를 제공하여 프로그램의 배포 및 관리를 단순하게 해준다. 백엔드 프로그램, 데이터베이스 서버, 메시지 큐등 어떤 프로그램도 컨테이너로 추상화할 수 있고 조립PC, AWS, Azure, Google cloud등 어디에서든 실행할 수 있다.

## 컨테이너(Container)

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f/docker-container.png](Docker%20ecc89c70aa3f4e05aa818244f1a2125f/docker-container.png)

컨테이너는 격리된 공간에서 프로세스가 동작하는 기술이다. 

가상화 기술의 하나지만 기존방식과는 차이가 있다.

기존의 가상화 방식은 주로 **OS를 가상화**했다.

우리에게 익숙한 [VMware](http://www.vmware.com/)나 [VirtualBox](https://www.virtualbox.org/)같은 가상머신은 호스트 OS위에 게스트 OS 전체를 가상화하여 사용하는 방식이다. 

이 방식은 여러가지 OS를 가상화(리눅스에서 윈도우를 돌린다던가) 할 수 있고 비교적 사용법이 간단하지만 무겁고 느려서 운영환경에선 사용할 수 없었다.

이러한 상황을 개선하기 위해 CPU의 가상화 기술([HVM](https://en.wikipedia.org/wiki/Hardware-assisted_virtualization))을 이용한 [KVM](http://www.linux-kvm.org/)Kernel-based Virtual Machine과 [반가상화](https://en.wikipedia.org/wiki/Paravirtualization) Paravirtualization방식의 [Xen](https://www.xenproject.org/)이 등장한다. 이러한 방식은 게스트 OS가 필요하긴 하지만 전체OS를 가상화하는 방식이 아니였기 때문에 호스트형 가상화 방식에 비해 성능이 향상되었다. 이러한 기술들은 [OpenStack](https://www.openstack.org/)이나 AWS, [Rackspace](https://www.rackspace.com/)같은 클라우드 서비스에서 가상 컴퓨팅 기술의 기반이 되었다.

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f/vm-vs-docker.png](Docker%20ecc89c70aa3f4e05aa818244f1a2125f/vm-vs-docker.png)

전가상화든 반가상화든 추가적인 OS를 설치하여 가상화하는 방법은 어쨋든 성능문제가 있었고 이를 개선하기 위해 **프로세스를 격리** 하는 방식이 등장한다.

리눅스에서는 이 방식을 리눅스 컨테이너라고 하고 단순히 프로세스를 격리시키기 때문에 가볍고 빠르게 동작한다. CPU나 메모리는 딱 프로세스가 필요한 만큼만 추가로 사용하고 성능적으로도 거의 손실이 없다.

하나의 서버에 여러개의 컨테이너를 실행하면 서로 영향을 미치지 않고 독립적으로 실행되어 마치 가벼운 VMVirtual Machine을 사용하는 느낌을 준다. 실행중인 컨테이너에 접속하여 명령어를 입력할 수 있고 apt-get이나 yum으로 패키지를 설치할 수 있으며 사용자도 추가하고 여러개의 프로세스를 백그라운드로 실행할 수도 있다. CPU나 메모리 사용량을 제한할 수 있고 호스트의 특정 포트와 연결하거나 호스트의 특정 디렉토리를 내부 디렉토리인 것처럼 사용할 수도 있다.

이러한 컨테이너라는 개념은 도커가 처음 만든 것이 아니다. 도커가 등장하기 이전에, 프로세스를 격리하는 방법으로 리눅스에서는 cgroupscontrol groups와 namespace를 이용한 [LXC](https://linuxcontainers.org/lxc/)Linux container가 있었고 FreeBSD에선 [Jail](https://www.freebsd.org/doc/handbook/jails.html), Solaris에서는 [Solaris Zones](https://docs.oracle.com/cd/E18440_01/doc.111/e18415/chapter_zones.htm#OPCUG426)이라는 기술이 있었다. 구글에서는 고급 기술자들이 직접 컨테이너 기술을 만들어 사용하였고 [lmctfy(Let Me Contain That For You)](https://github.com/google/lmctfy)라는 컨테이너 기술을 공개했지만 성공하진 못했다.

도커는 LXC를 기반으로 시작해서 0.9버전에서는 자체적인 [libcontainer](https://github.com/docker/libcontainer) 기술을 사용하였고 추후 [runC](http://runc.io/)기술에 합쳐졌다.

## 이미지(Image)

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f/docker-image.png](Docker%20ecc89c70aa3f4e05aa818244f1a2125f/docker-image.png)

도커에서 가장 중요한 개념은 컨테이너와 함께 이미지라는 개념이다.

이미지는 **컨테이너 실행에 필요한 파일과 설정값등을 포함하고 있는 것**으로 상태값을 가지지 않고 변하지 않는다. 컨테이너는 이미지를 실행한 상태라고 볼 수 있고 추가되거나 변하는 값은 컨테이너에 저장된다. 같은 이미지에서 여러개의 컨테이너를 생성할 수 있고 컨테이너의 상태가 바뀌거나 컨테이너가 삭제되더라도 이미지는 변하지 않고 그대로 남아있다.

ubuntu이미지는 ubuntu를 실행하기 위한 모든 파일을 가지고 있고 MySQL이미지는 debian을 기반으로 MySQL을 실행하는데 필요한 파일과 실행 명령어, 포트 정보등을 가지고 있다. 좀 더 복잡한 예로 Gitlab 이미지는 centos를 기반으로 ruby, go, database, redis, gitlab source, nginx등을 가지고 있다.

말그대로 이미지는 컨테이너를 실행하기 위한 모든 정보를 가지고 있기 때문에 더 이상 의존성 파일을 컴파일하고 이것저것 설치할 필요가 없다. 이제 새로운 서버가 추가되면 미리 만들어 놓은 이미지를 다운받고 컨테이너를 생성만 하면 된다. 한 서버에 여러개의 컨테이너를 실행할 수 있고, 수십, 수백, 수천대의 서버도 문제없다.

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f/docker-store.png](Docker%20ecc89c70aa3f4e05aa818244f1a2125f/docker-store.png)

도커 이미지는 Docker hub에 등록하거나 Docker Registry 저장소를 직접 만들어 관리할 수 있다. 현재 공개된 도커 이미지는 50만개가 넘고 Docker hub의 이미지 다운로드 수는 80억회에 이른다. 누구나 쉽게 이미지를 만들고 배포할 수 있다.

## 이미지 경로

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f/image-url.png](Docker%20ecc89c70aa3f4e05aa818244f1a2125f/image-url.png)

이미지는 url 방식으로 관리하며 태그를 붙일 수 있다. ubuntu 14.04 이미지는 [docker.io/library/ubuntu:14.04](http://docker.io/library/ubuntu:14.04) 또는 [docker.io/library/ubuntu:trusty](http://docker.io/library/ubuntu:trusty) 이고 [docker.io/library는](http://docker.io/library%EB%8A%94) 생략가능하여 ubuntu:14.04 로 사용할 수 있다. 이러한 방식은 이해하기 쉽고 편리하게 사용할 수 있으며 태그 기능을 잘 이용하면 테스트나 롤백도 쉽게 할 수 있다.

================================================

Docker 기본설치 및 구동

1. yum 패키지 업데이트
2. docker & docker registry 설치

```jsx
# yum -y update

# yum -y install docker docker-registry 
```

3. 부팅 시에 실행 하도록 systemctl 에 등록

```jsx
# systemctl enable docker

# systemctl start docker

# systemctl status docker
docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
   Active: active (running) since 월 2021-07-12 20:36:23 EDT; 2h 2min ago
```

4. 다운로드가능한 이미지 파일 검색

```jsx
# docker search <image>
```

5. 원하는 이미지 찾아서 pull 명령어로 받아오기

```jsx
# docker pull nginx <- (레포지토리)이미지이름
```

6. 다운로드 된 이미지 확인

```jsx
# docker images 

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker.io/nginx     latest              4cdc5dd7eaad        6 days ago          133 MB
```

7. 받은 이미지를 내가 보기 쉽게 tag 하기

```jsx
# docker tag <imagename:tag> docker_user_id/원하는이미지이름:태그

# docker tag [docker.io](http://docker.io)/nginx virtuall12/nginx:song
```

8. DockerHub에 내가 받은 이미지 tag 해서 push 하기(dockerhub에서 확인)

```jsx
# docker push virtuall12/nginx:song
```

9. 이미지 삭제하는 법

```jsx
docker rmi -f <image id>
```

10. docker container 실행 or container 접속

```jsx
# docker run -it -d virtuall12/nginx /bin/bash <- bash를 사용하겠다.

옵션설명
  -i : 사용자가 입출력을 할 수 있는 상태로
  -t : 가상 터미널 환경을 에물레이션 함
  -d : 컨테이너를 백그라운드 형태로 계속 실행하게 함
```

11. 실행중인 컨테이너 확인

```jsx
# docker container ls , docker ps -a

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
1328521fc5b5        virtuall12/nginx     "/docker-entrypoin..."   38 minutes ago      Up 28 minutes       80/tcp              affectionate_sinoussi
```

12. container 접속, 확인

```jsx
docker attach 1328 <- 컨테이너 아이디는 다른아이디와 구분 가능한 범위만 적어주어도 된다.

root@1328521fc5b5:/# ls
bin   dev                  docker-entrypoint.sh  home  lib64  mnt  proc  run   srv  tmp  var
boot  docker-entrypoint.d  etc                   lib   media  opt  root  sbin  sys  usr
```

13. 컨테이너 종료 

exit 를 입력하거나 Ctrl + d 하면 컨테이너도 중지시키면서 종료함.

종료 후 $ docker ps -a 쳐보면 확인 가능 ( docker ps -a 는 동작중이지 않은 컨테이너도 보여줌

```jsx
# docker ps -a 

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                            PORTS               NAMES
1328521fc5b5        [docker.io/nginx](http://docker.io/nginx)     "/docker-entrypoin..."   43 minutes ago      Exited (130) About a minute ago                       affectionate_sinoussi
```

컨테이너 접속상태에서 Ctrl을 누른상태로 p 누르고 q 를 누르면 컨테이너를

백그라운드로 실행된 상태로 host os로 돌아감.

이렇게 종료 한 다음 $ docker ps -a 해보면

```jsx
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
1328521fc5b5        [docker.io/nginx](http://docker.io/nginx)     "/docker-entrypoin..."   46 minutes ago      Up 54 seconds       80/tcp              affectionate_sinoussi
```

컨테이너가 백그라운드에서 동작중인 것을 확인 할 수 있다.

14. 다시 컨테이너로 들어가기

```
$ docker ps -a
```

위 명령을 입력하면 현재 container 목록과 상태를 볼수 있다.

여기서 container id 아 status 를 확인.

status 가 Exited 일 경우 container 를 먼저 실행해야 한다.

```
$ docker start 1328
```

(아까 설명했듯이 container id를 끝까지 입력할 필요는 없다. 

다른 아이디와 구분될때까지만~)

그럼 상태가 up 으로 되어있을 것이고 여기서 접속을 한다.

```
$ docker attach 1328
```

이러면 container 의 console 이 뜬다.

15. 컨테이너 재시작 ( restart )

```
$ docker restart 1328
```

16. 컨테이너 종료 ( stop )

```
$ docker stop 1328
```

17. 컨테이너 삭제 ( rm )

```
$ docker rm 1328
```

여기까지 기본적인 도커 설치 및 이미지,컨테이너 생성 ,관리 

================================================================

## container을 run, start 했을 때, 바로 꺼지는(Exitted) 이유

Docker를 사용할 때 가장 기본이 되는 개념중 하나는

container는 Virtual Machine이 아니라는 점이다

> centos의 /bin/cal를 실행했는데 왜 아무것도 실행되지 않고 바로 Exit 되었을까?

> 바로 container는 Virtual Machine같은 한 서버환경이 아니라명령을 실행하는 한 환경이고 명령을 이행시켜줄 뿐이다.

이는 docker ps -a를 입력해서 나오는 리스트에 있는

Command 속성을 보면 유추할 수 있다.

```
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS                          PORTS                NAMES
ec1ad271b5d7        centos:7            "/bin/cal"               2 minutes ago        Exited (0) 2 minutes ago                             test1
```

그렇게 명령을 이행하고 나면Machine을 켠 것 마냥 계속 켜져있는 것이 아니라

본분을 이행하고 꺼지는 것이다. 이는 무조건 꺼지는 것이 아니라 Command에 따라 다르다.

예를 들어

```
$ docker container run -d -p 8080:80 nginx
```

이렇게 nginx라는 이미지(docker hub로부터 pull받은 official 이미지이다)를 별다른 command를 뒤에 붙이지 않고 container로 run 했다면 각각 기본 command로 정해진 command들이 실행되고

nginx의 경우

```
$ docker ps -a                                                                                                [2:23:09]
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                       PORTS                  NAMES
d023acc091e6        nginx               "nginx -g 'daemon of…"   31 seconds ago      Up 30 seconds                0.0.0.0:8080->80/tcp   competent_clarke
```

이런 Command를 가진 container가 실행되는데 이는 계속 해당 Command에 의해 계속 켜져있게 된다. docker container start는 기본적으로 표준입력과 표준출력이 데스크탑의 키보드와 화면에 대해 열려있지 않다. 그래서 /bin/bash나 /bin/cal 같은 명령을 실행하고 그 입력이나 출력을 보려면

interactive 모드를 꼭 붙여줘야 한다.

```
apple@appleui-MacBookPro ~$ docker container start -i ec1ad271b5d7
```

이렇게 말이다. 그리고 도커는 커맨드상의 옵션이 굉장히 중요한 것 같으니 매번 —help 습관들이기

```
--help
```

================================================================

## dockerfile을 build하여 이미지를 만들고 컨테이너 생성 및 실행

1. Dockerfile 작성 ← D 대문자 지켜야함

```jsx
   # mkdir Dockerfile

   # cd Dockerfile

   # touch Dockerfile

EX)
   FROM centos:7
   RUN yum -y update
   RUN yum -y install httpd
   EXPOSE 80
   CMD ["/bin/bash"]

   ex) docker build -t <원하는 이미지명>:tag
   # docker build -t spache:1.0
   
   # docker images 

   REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
   spache              1.0                 48a81c4aa3af        3 minutes ago       591 MB
```

2. 만들어진 이미지로 컨테이너 생성 및 실행

```jsx
# docker run -it -d -p 8008:80 spache:1.0 
```

3. 생성된 컨테이너 확인

```jsx
# docker container ls , docker ps -a

CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                  NAMES
e06a81932064        spache:1.0          "/bin/bash"         2 minutes ago       Up 2 minutes        0.0.0.0:8008->80/tcp   stoic_lewin
```

## !!!

 만약 Dockerfile build 할 때 yum이 작동되지 않는다면 

vsphere 에는 edit setting 에가서  hardware virtualization 을 활성화 해야함

vmware에서는 edit settiong → cpu 세팅창에서 

virtualize intel VT-x/EPT or AMD-V/RVI , 

virtualize CPU perfomance counters 체크박스를 체크해야한다.

=========================================================

## #Dockerfile 작성법#

도커파일(Dockerfile)은 도커 상에서 작동시킬 컨테이너의 구성 정보를 기술하기 위한 파일
이며 일반적으로 아래의 내용을 포함 한다

∎ 베이스가 될 도커 이미지
∎ 도커 컨테이너 안에서 수행한 조작(명령)
∎ 환경변수 등의 설정
∎ 도커 컨테이너 안에서 작동시켜둘 데몬 실행

작성된 Dockerfile 은 build 명령을 통해 이미지로 작성시킬 수 있다.

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f.jpg](Docker%20ecc89c70aa3f4e05aa818244f1a2125f.jpg)

도커에서 사용하는 명령은 대문자 소문자 상관은 없지만 일반적으로 대문자를 사용한다. 주요 명령은 아래와 같다

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f%201.jpg](Docker%20ecc89c70aa3f4e05aa818244f1a2125f%201.jpg)

* Dockerfile 내에서 사용하는 주석은 “#” 을 사용한다
* 편집기 입력 등이 부자연스러운 경우 $sudo apt-get -y install vim 이후 편                  집기 사용

Dockerfile 파일 이용하여 이미지 만들기
Dockerfile 이 작성되었다면 해당 파일을 이용하여 이미지를 작성하기 위해 build를 실행해야 한다. 일반적인 명령 형태는 다음과 같다

```jsx
$ docker build -t [생성할 이미지명]:[태그명] [도커파일의 위치]
```

Dockerfile 명령어와 데몬
이제 본격적으로 도커 파일을 만들어 보자. 이를 위해서는 어떠한 이미지를 베이스 이미지로 사용할 것인가에서부터 순차적인 명령어의 배치와 최종적으로 컨테이너로 실행되었을 때 어떠한 데몬을 실행시킬 것인가를 사전에 정리해 두고 작성에 들어가야 한다.

## 명령실행(RUN)

컨테이너에는 FROM 명령에서 지정한 베이스 이미지에 대해 애플리케이션/미들웨어 등을 설치하거나 환경 구축을 위한 명령을 실행하기 위하여 RUN을 사용한다. 도커파일에서 가장 많은 사용빈도를 보인다고 할 수 있다.

Dockerfile에서 RUN 은 Shell 형식과 Exec 형식으로 명령을 작성할 수 있다.

Shell 형식으로 작성

# Installing Nginx
RUN apt-get -y install nginx

Exec 형식으로 작성

# Installing Nginx
RUN ["/bin/bash", "-c", "apt-get -y install nginx"]

shell 형식으로 명령을 기술하면 /bin/sh에서 실행되지만 Exec 형식으로 기술하면 쉘을 경유하지 않고 직접 실행한다. 따라서 $HOME 과 같은 환경 변수를 지정할 수 없게된다. 문자열을 지정할 때에는 ‘(작은 따옴표)를 사용한다.

## 데몬실행(CMD)

RUN 명령은 이미지를 작성하기 위해 실행하는 명령을 기술하지만, 이미지를 바탕으로 생성 된 컨테이너 안에서 명령을 실행하려면 CMD 명령을 사용한다. Dockerfile 내에서 CMD는 한번만 기술할 수 있으며 만약 여러번 기술 되었다면 마지막 CMD 만 유효하게 된다

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f%202.jpg](Docker%20ecc89c70aa3f4e05aa818244f1a2125f%202.jpg)

Shell 형식으로 기술

CMD nginx -g 'daemon off;'

Exec 형식으로 기술

CMD ["nginx", "-g", "daemon off;"]

## 데몬실행(ENTRYPOINT)

ENTRYPOINT 명령에서 지정한 명령은 Dockerfile에서 빌드한 이미지로부터 Docker 컨테너를 시작하기 때문에 docker container run 명령을 실행했을 때 실행된다.

Shell 형식으로 기술

ENTRYPOINT nginx -g 'daemon off;'

Exec 형식으로 기술

ENTRYPOINT ["nginx", "-g", "daemon off;"]

CMD vs. ENTRYPOINT
둘의 차이는 docker container run을 했을 때의 동작에 있다. CMD 명령은 컨
테이너 시작 시에 실행하고 싶은 명령을 지정해도 docker container run 명령 실행 시에 인수로 새로운 명령을 지정한 경우 이것을 우선 실행한다. ENTRYPOINT는 명령에서 지정한 명령은 반드시 컨테이너에서 실행되는데, 실행 시에 명령 인수를 지정하고 싶을 때는 CMD 명령과 조합하여 사용한다
예를 들어, top 명령 실행 시 아래와 같이 구성할 수 있다.

Dockerfile                                 CMD 명령에서 지정한 10초로 실행

FROM ubuntu                           $ docker container run -it test

ENTRYPOINT ["top"]                 2초 간격으로 갱신을 바꾸고자 할 때

CMD ["-d", "10"]                       $ docker contaienr run -it test -d 2

## 빌드 완료 후에 실행되는명령(ONBUILD)

ONBUILD 는 그 다음 빌드에서 실행할 명령을 이미지 안에 설정하기 위한 명령이다. 예를 들어 Dockerfile 에 ONBUILD 명령을 사용하여 어떤 명령을 실행하도록 설정하여 빌드하고 이미지를 작성한 뒤 해당 이미지를 다른 Dockerfile에서 베이스 이미지로 설정하면 빌드 했을 때 ONBUILD 명령에서 지정한 명령을 실행 시킬 수 있다.

## 컨테이너의 헬스 체크(HEALTHCHECK)

컨테이너 안의 프로세스가 정상적으로 작동하고 있는지를 체크하고 싶을 때에 사용한다. 일반적인 명령의 구문은 다음과 같다

```jsx
HEALTHCHECK [옵션] CMD 실행할 명령
```

       옵션                내용                  기본값
--interval=n    헬스 체크 간격           30s
--timeout=n   헬스 체크 타임아웃    30s
--retries=N     타임아웃 횟수              3

예를 들어 5분마다 가동 중인 웹 서버의 메인 페이지(http://localhost/)를 3초안에 표시할 수 있는지 여부를 확인하려면 Dockerfile 에 아래와 같이 작성한다

```jsx
HEALTHCHECK --interval=5m --timeout=3s CMD curl -f [http://localhost/](http://localhost/) || exit 1
```

헬스 체크의 결과는 docker container inspect 명령으로 확인이 가능하다

## 환경변수 설정(ENV)

Dockerfile 안에서 환경변수를 설정하고 싶을 때는 ENV 명령을 사용하며 다음 두 서식 중 하나로 기술할 수 있다.

ENV [key] [value] 형식으로 지정 (각 줄에 기술)

```jsx
ENV MYNAME "JIHINE"
ENV MYORDER "COFFEE"
```

ENV [key]=[value] 형식으로 지정 (한 줄로 기술)

```jsx
ENV MYNAME="JIHUNE" \ <- 
 MYORDER="COFFEE"
```

## 작업디렉토리 지정(WORKDIR)

Dockerfile에서 정의한 명령을 실행하기 위한 작업용 디렉토리를 지정하고자 할 때 사용하
며 다음과 같은 명령을 실행하기 위하여 지정이 가능하다.

∎ RUN
∎ CMD
∎ ENTRYPOINT
∎ COPY
∎ ADD

만일 지정한 디렉토리가 존재하지 않으면 새로 작성한다. 또한 WORKDIR 명령은Dockerfile 내에서 여러번 사용할 수 있다. 상대 경로를 지정한 경우는 이전 WORKDIR 명령의 경로에 대한 상대 경로로 지정된다. 아래의 결과는 실행 후 /first/second/third가 출력된다

```jsx
WORKDIR /first
WORKDIR second
WORKDIR third
RUN ["pwd"]
```

또한 ENV 명령에서 지정한 환경변수를 사용할 수 있다. 예를 들어 아래의 경우에는 
/first/second 가 출력된다

```jsx
ENV DIRPATH /first
ENV DIRNAME second
WORKDIR $DIRPATH/$DIRNAME
RUN ["pwd"]
```

## 사용자 지정(USER)

이미지 실행이나 Dockerfile 의 다음과 같은 명령을 실행하기 위한 사용자를 지정할 때 사
용한다. 

∎ RUN
∎ CMD
∎ ENTRYPOINT

USER 명령에서 지정하는 사용자는 RUN 명령으로 미리 작성해 두어야 한다. 예를 들어 아
래의 예는 RUN 명령으로 test 라는 사용자를 작성한 후, USER 명령에서 test를 설정하고, 두 번째 명령을 test 라는 계정에서 실행하는 것을 보여주고 있다.

```jsx
RUN ["adduser", "test"]
RUN ["whoami"] -----------> root 계정으로 실행
USER test
RUN ["whoami"] -----------> test 계정으로 실행
```

## 라벨 지정(LABEL)

이미지에 버전 정보나 작성자 정보, 코멘트 등과 같은 정보를 제공할 때에는 LABEL 명령을 
사용한다.

```jsx
LABEL maintainer "test test@test.com"
LABEL title="webAP"
LABEL version="1.0"
LABEL description="This image ... "
$ docker image inspect --format="{{ .Config.Labels }}" sample 형식으로 검색 가능하다.
```

## 포트 설정(EXPOSE)

컨테이너의 공개 포트번호 지정할 때 사용
예를 들어 8080 포트를 공개하고자 한다면 다음과 같이 작성한다.

```jsx
EXPOSE 8080
```

## Dockerfile 내에서의 변수 설정(ARG)

Dockerfile 안에서 사용할 변수를 정의할 때에는 ARG 명령을 사용한다. ARG 명령을 사용하
면 변수의 값에 따라 생성되는 이미지의 내용을 바꿀 수 있다. ENV 와 달리 이 변수는 Dockerfile 안에서만 사용할 수 있다.

```jsx
ARG MYNAME="jihune"
RUN echo $MYNAME
```

만약 Dockerfile 빌드 시 $ docker build . --build-arg MYNAME="test" 라고 입력하면 
결과는 test 가 출력된다 “--build-arg" 옵션을 사용하지 않을 때에는 Dockerfile 에서의 기본 값이 출력된다.

## 기본 쉘 지정(SHELL)

쉘 형식으로 명령을 실행할 때 기본쉘을 설정하려면 SHELL을 사용한다. SHELL을 지정하지 
않으면 리눅스는 [“/bin/sh", "-c"], 윈도우는 [”cmd", "/S", "/C"] 가 기본이 된다

기본쉘을 /bin/bash 로 변경하여 RUN을 실행하고자 한다면 다음과 같이 설정할 수 있다.

```jsx
SHELL[“/bin/bash", "-c"]
RUN echo hello
```

## 파일 및 디렉토리 추가(ADD)

이미지에 호스트상의 파일이나 디렉토리를 추가할 때에는 ADD 명령을 사용한다. ADD 명령은 다음과 같은 형식으로 작성이 가능하다.

```jsx
∎ ADD <호스트 파일경로> <도커 이미지의 파일경로>
∎ ADD ["<호스트 파일경로>“ ”<도커 이미지의 파일경로>“]
```

## 파일 복사(COPY)

이미지에 호스트상의 파일이나 디렉토리를 복사할 때에는 COPY를 사용한다. ADD 명령과 사실상 거의 동일하지만 ADD 명령은 원격파일의 다운로드나 아카이브 압축해
제 등과 같은 기능을 갖고 있지만, COPY 명령은 호스트상의 파일을 이미지 안으로 ‘복사’하
는 처리만 한다. 따라서 단순히 이미지 내에 파일을 배치하고자 할 때에는 COPY를 사용한
다

## 볼륨 마운트(VOLUME)

이미지에 볼륨을 할당하고자 할 때 사용한다. VOLUME ["/마운트포인트“] 와 같은 형식으로 구성하면 호스트나 다른 컨테이너에서 마운트
를 수행한다. 구성하는 형식은 다음과 같다. 

∎ VOLUME ["/var/log/"]
∎ VOLUME /var/log
∎ VOLUME /var/log /var/db

컨테이너는 영구 데이터를 저장하는 데는 적합하지 않다. 따라서 영구 저장이 필요한 경우
에는 외부 스토리지에 저장하는 것을 추천한다. 영구데이터는 Docker의 호스트 머신상의 볼륨에 마운트하거나 공유 스토리지를 볼륨으로 마운트 하는 것이 가능하다

================================================================

이미지 저장하기

```
docker save [option] [image:tag] -o [저장할파일명.tar]
```

이미지 불러오기

```
docker load < [tar파일 이름]
```

이미지 말고도 컨테이너도 저장하고 불러올 수 있다.

컨테이너 저장하기

```
docker export [container name] > [저장할파일명.tar]
```

컨테이너 불러오기

```
docker import [tar파일 이름]
```

================================================================

## 도커 컴포즈(docker-compose)

Docker Compose 란

다중 컨테이너 도커 애플리케이션을 정의하고 동작하게 해주는 툴이다.

YAML 파일로 작성되어지며 작성된 yaml 파일을 읽어 들여 모든 서비스들을 생성 및 시작을 하나의 명령어로 실행할 수 있다.

docker-compose.yml 작성

```jsx
version: '3'

services:
nginx:
image: nginx:latest
ports:
- 60080:80
volumes:
- /usr/share/nginx/html:/usr/share/nginx/html

```

웹접속시 띄워질 index.html 파일 작성

```
# vim usr/share/nginx/html/index.html

<html>
<body>
<h1>Hello Docker-Compose</h1>
</body>
</html>
```

작성된 yml 파일 실행

```jsx
# docker-compose up -d
Creating network "bin_default" with the default driver
Creating bin_nginx_1 ... done
```

컨테이너 동작 확인

```jsx
# docker container ls

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                   NAMES
486fca5e59ed        nginx:latest        "/docker-entrypoin..."   6 minutes ago       Up 6 minutes        0.0.0.0:60080->80/tcp   bin_nginx_1
```

HOST_IP:60080 접속

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f%203.jpg](Docker%20ecc89c70aa3f4e05aa818244f1a2125f%203.jpg)

docker-compose.yml 작성 문법

```
# 도커 컴포즈의 스키마 버전입니다. 이 스키마 버전은 docker의 버전에 따라 지원되는 버전이 달라집니다.
# 되도록 최근의 버전을 사용하는 것이 좋습니다.
version: "3"

# 애플리케이션의 일부로 실행하려는 서비스 목록을 정의 합니다.
# 서비스 이름은 임의로 선택 할 수 있습니다.
# 저는 이전글의 도커 파일로 생성했던 이미지를 한번 사용해 보았습니다.
services:
  app1:
    #build를 사용하게 된다면 image 항목을 사용하지 않아도 도커 컴포즈가 실행됩니다.
    #build :
      # 빌드 명령을 실행할 디렉터리 경로
      #context: .
      # 도커 이미지를 빌드하는데 사용할 도커 파일 위치
      #dockerfile: ./Dockerfile

    # 이미지 셋팅입니다
    image: demo:latest

    # 커맨드의 변경이 필요하다면 여기서 재 정의를 할 수 있습니다
    #command: /bin/bash -c "java -jar demo-0.0.1-SHAPSHOT.jar"

    # 노출시킬 포트 입니다.
    # - 로 여러개의 포트를 노출 시킬 수 있습니다
    ports:
    - 8080:8080
    # 작업 디렉토리를 지정해 줄 수 있습니다.
    # working_dir: /app

    # 마운트 할 볼륨입니다. 이 부분은 docker로 생성할 때 지정했던 부분과 거의 일치 합니다.
    # 상대경로로 입력도 가능합니다. ex) ./:/app
    volumes:
     - C:/Users/admin/Desktop/volume/log:/volume
    depends_on:
    # 의존 관계 설정
    - database

    # 데이터 베이스가 필요하거나 다른 컨테이너와의 통신이 필요하다면, 이 항목을 통해 연결할 수 있습니다.
    # 단, 파일내 정의된 다른 서비스여야 연결이 가능합니다.
    # 만약 버전을 도커 컴포즈 3 버전 이상을 사용했다면 docker-compose.yml 안에 있는 서비스들은 별도로 지정하지 않으면 하나의 네트워크에 속합니다.

    # links:
    #  - database

    # 네트워크 모드를 설정할 수 있습니다. 기본적으로는 도커안의 내부 네트워크를 사용하게 됩니다.
    # network_mode: host

  database:
    # 'database'서비스에서 참조할 이미지
    image: mariadb:latest
    ports:
    - 3306:3306
    # 만약 컨테이너가 예상치 못한 일로 kill 되어도 바로 다시 띄울 수 있는 옵션 입니다.
    restart: always
    environment:
        # 환경 설정에 필요한 설정들 입니다.
      MYSQL_ROOT_PASSWORD: 1234
      MYSQL_DATABASE : database
      MYSQL_USER: root
      MYSQL_PASSWORD: 1234
```

docker-compose를 사용할 때 자주 사용되는 커맨드

```
# 도커 컴포즈 컨테이너들을 백그라운드로 띄우기
$ docker-compose up -d

# 도커 컴포즈 컨테이너들을 포어그라운드로 띄우기
$ docker-compose up

# 도커 컴포즈 컨테이너들을 내리기
$ docker-compose down

# 도커 컴포즈 컨테이너들을 다시 시작하기
$ docker-compose restart

# 도커 컴포즈 컨테이너들의 로그를 계속해서 읽기
$ docker-compose logs -f

# 도커 컴포즈 컨테이너들의 상태 확인
$ docker-compose ps

# 도커 컴포즈 설정을 확인
# 주로 -f 옵션으로 여러 개의 설정 파일을 사용할 때, 최종적으로 어떻게 설정이 적용되는지 확인해볼 때 유용하다.
$ docker-compose config

# 다른 경로에 있는 도커 컴포즈 파일 사용
# 도커 컴포즈로 다른 이름이나 경로의 파일을 Docker Compose 설정 파일로 사용하고 싶다면 -f 옵션으로 명시를 해준다.
$ docker-compose -f /app/docker-compose.yml up
# 여러개의 도커 컴포즈 설정 파일을 사용할 수 있다. 이 때는 나중에 나오는 설정이 앞에 나오는 설정보다 우선하게 된다.
$ docker-compose -f docker-compose.yml -f docker-compose-test.yml up
```

```jsx
docker-compose start // 정지한 컨테이너를 재개
docker-compose start mysql // mysql 컨테이너만 재개

docker-compose restart // 이미 실행 중인 컨테이너 다시 시작
docker-compose restart redis // 이미 실행중인 redis 재시작

docker-compose stop // gracefully stop함.
docker-compose stop wordpress

docker-compose down // stop 뿐만 아니라 컨테이너 삭제까지

docker-compose logs
docker-compose logs -f // 로그 watching

docker-compose ps // 컨테이너 목록

docker-compose exec [컨테이너] [명령어]
docker-compose exec wordpress bash // wordpress에서 bash 명령어 실행

docker-compose build // build 부분에 정의된 대로 빌드
docker-compose build wordpress // wordpess 컨테이너만 빌드

docker-compose run [service] [command] // 이미 docker-compose 가동 중인 것과 별개로 하나 더 올릴 때
docker-compose run nginx bash
```

## Docker-compose 로 Nginx + php-fpm + mariaDB 서비스

및 띄워진 컨테이너 HAproxy로 라운드로빈 로드밸런싱

실행파일들은 [https://github.com/virtuall12/Nginx-php-fpm-mariaDB-docker-compose.git](https://github.com/virtuall12/Nginx-php-fpm-mariaDB-docker-compose.git)에 저장

docker-compose.yaml

```
version: '3'
services:

  db:
    container_name: mariadb
    image: mariadb
    restart: always
    ports:
          - 3306:3306
    volumes:
          - ./mariadb/data:/var/lib/mysql
          - ./mariadb/config:/etc/mysql/conf.d

    environment:
          - MYSQL_ROOT_PASSWORD=mypass
          - TZ=Asia/Seoul

  php:
    container_name: php-fpm
#    image: php:fpm		#official image but modules are not included
    image: ifnlife/php-ext:v7.4.3
    volumes:
       - ./www:/www  #home diretory
       - ./php-fpm/php.ini-development:/usr/local/etc/php/php.ini
    user: "1000:1000"
    environment:
        - TZ=Asia/Seoul

  nginx:
     container_name: nginx
     image: nginx:latest
     ports:
         - "8001:80"
     volumes:
        - ./www:/www  #home diretory
        - ./nginx/conf.d:/etc/nginx/conf.d
        - ./nginx/logs:/var/log/nginx
          
     environment:
         - TZ=Asia/Seoul

```

docker-compose 실행

```jsx
# docker-compose up -d 
```

실행중인 컨테이너 확인 

```jsx
# docker ps -a

CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                    NAMES
f036daf39488        mariadb                  "docker-entrypoint..."   About an hour ago   Up About an hour    0.0.0.0:3307->3306/tcp   mariadb
cb53c3df4dcf        nginx:latest             "/docker-entrypoin..."   About an hour ago   Up About an hour    0.0.0.0:8001->80/tcp     nginx
adf276c787f7        ifnlife/php-ext:v7.4.3   "docker-php-entryp..."   About an hour ago   Up About an hour    9000/tcp                 php-fpm
```

웹 접속 http://HOST_IP:<PORT>

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f%204.jpg](Docker%20ecc89c70aa3f4e05aa818244f1a2125f%204.jpg)

HAproxy 를 이용한 라운드 로빈 로드밸런싱

frontend  main *:80
acl url_static       path_beg       -i /static /images /javascript /stylesheets
acl url_static       path_end       -i .jpg .gif .png .css .js

```
frontend  main *:80
acl url_static       path_beg       -i /static /images /javascript /stylesheets
acl url_static       path_end       -i .jpg .gif .png .css .js
use_backend static          if url_static
default_backend             app
#---------------------------------------------------------------------
static backend for serving up images, stylesheets and such
#---------------------------------------------------------------------
backend static
balance     roundrobin
server      static 127.0.0.1:4331 check
#---------------------------------------------------------------------
round robin balancing between the various backends
backend app
balance     roundrobin
server  app1 211.183.3.101:8001 check
server  app2 211.183.3.101:8002 check
#---------------------------------------------------------------------
# HAproxy stats 대시보드 입력 값
**listen stats # "stats"라는 이름으로 listen 지정
    bind :9001 # 접속 포트 지정
    stats enable
    stats realm Haproxy\ Statistics  # 브라우저 타이틀
    stats uri /haproxy_stats  # stat 를 제공할 URI
    stats auth admin:admin # 인증이 필요하면 추가한다**

```

[http://211.183.3.101:9001/haproxy_stats](http://211.183.3.101:9001/haproxy_stats)로 접속 해 대시보드 확인

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f%205.jpg](Docker%20ecc89c70aa3f4e05aa818244f1a2125f%205.jpg)

접속된 웹페이지를 새로고침 하여 라운드로빈 방식으로 돌아가며 할당 되는지 확인 

8001포트로 접속 → 8002포트로 접속 반복

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f%206.jpg](Docker%20ecc89c70aa3f4e05aa818244f1a2125f%206.jpg)

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f%207.jpg](Docker%20ecc89c70aa3f4e05aa818244f1a2125f%207.jpg)

순차적으로 할당 되는 것 확인

![Docker%20ecc89c70aa3f4e05aa818244f1a2125f%208.jpg](Docker%20ecc89c70aa3f4e05aa818244f1a2125f%208.jpg)

================================================================

## **도커 이미지 다루기 (이미지를 tar로 저장해서 옮기기)**

도커를 쓰다보니

registry를 이용하지 않고(docker hub) 이용 x

옮겨야 하는 상황이 발생한다.

**Docker image를 tar 파일로 저장**

(export/import/save/load)

Docker build나 commit으로 만들어진 이미지는 일반적으로 docker hub와 같은 registry에 push되고, 이를 다시 pull 받는 방식으로 사용된다. 하지만, 간혼 docker 이미지를 registry 거치지 않고 이동해야 할 때가 있다.

이럴 때 사용자는 docker 이미지 혹은 컨테이너를 tar 파일로 만들 수 있다.

**Docker Save (docker image -> tar)**

Docker 이미지를 tar 파일로 저장하기

$docker save [option] {파일명} {이미지명}

Ex)

Docker save -o nginx.tar nginx:latest

**Docker Load (tar -> docker image)**

tar파일로 만들어진 이미지를 다시 docker image로 되돌리기 위해서는 docker load 커맨드를 사용해야 한다.

$docker load -I tar 파일명

**Docker export (docker container -> tar)**

Docker는 이미지 뿐 아니라 container를 tar 파일로 저장하는 명령어를 제공한다.

$docker export {container id or name} > ~.tar

**Docker import (tar -> docker image)**

Export 커맨드를 통해 만들어진 tar 파일을 다시 docker image로 생성하는 명령어.

$docker image {파일 or URL} - IMAGE NAME:TAG NAME

================================================================

## **exec 와 attach 명령어 차이**

### 1. 명령어 차이

(1) docker exec -it [container_name] /bin/bash

: 외부에서 컨테이너 진입할 때 사용한다.

(2) docker attach [container_name 또는 container_ID]

: container 실행시 사용한다.

모든 작업을 시작할 때 우선

$ docker start [conatiner] 를 해야 합니다. 그래야 컨테이너에 붙는다(올린다).

이런 식으로 사용한다.

(1) 처음에 컴퓨터를 껐다가 켰다. exec를 하기 귀찮다. 그렇다면

$ docker attach를 쓴다.

# docker start, attach 하지 않고 바로 시작하려면 처음에 만들 때 restart 명령어를 줄 수도 있다.

(2) 중간 작업 중에 패키지 설치가 더 필요하다.

$ docker exec ~~~ 를 쓴다.
