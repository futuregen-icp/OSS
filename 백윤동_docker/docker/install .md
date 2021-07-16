# install

selinux 끄기

```jsx
vi /etc/selinux/config
vi /etc/sysconfig/selinux 설정 편집

SELINUX=disabled
reboot
```

```jsx
#ClientAliveInterval 0
#ClientAliveCountMax 3
```

[Install Docker Engine on CentOS](https://docs.docker.com/engine/install/centos/#install-from-a-package)

- repository 추가로 설치

    Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.

    새 호스트 머신에 처음으로 Docker Engine을 설치하기 전에 Docker 저장소를 설정해야 합니다. 그런 다음 저장소에서 Docker를 설치하고 업데이트할 수 있습니다.

    ### **Set up the repository**

    Install the `yum-utils` package (which provides the `yum-config-manager` utility) and set up the **stable** repository.

```jsx
sudo yum install -y yum-utils
 sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io

yum list docker-ce --showduplicates | sort -r

sudo systemctl start docker

docker version -- 설치 확인
Client:
 Version:      1.12.6
 API version:  1.24
 Go version:   go1.6.4
 Git commit:   78d1802
 Built:        Wed Jan 11 00:23:16 2017
 OS/Arch:      darwin/amd64

Server:
 Version:      1.12.6
 API version:  1.24
 Go version:   go1.6.4
 Git commit:   78d1802
 Built:        Wed Jan 11 00:23:16 2017
 OS/Arch:      linux/amd64
```

혹시, 특이한 부분을 찾으셨나요? 버전정보가 클라이언트와 서버로 나뉘어져 있습니다. 도커는 하나의 실행파일이지만 실제로 클라이언트와 서버역할을 각각 할 수 있습니다. 도커 커맨드를 입력하면 도커 클라이언트가 도커 서버로 명령을 전송하고 결과를 받아 터미널에 출력해 줍니다.

![https://subicura.com/assets/article_images/2017-01-19-docker-guide-for-beginners-2/docker-host.png](https://subicura.com/assets/article_images/2017-01-19-docker-guide-for-beginners-2/docker-host.png)

*docker client-host*

기본값이 도커 서버의 소켓을 바라보고 있기 때문에 사용자는 의식하지 않고 마치 바로 명령을 내리는 것 같은 느낌을 받습니다. 이러한 설계가 mac이나 windows의 터미널에서 명령어를 입력했을때 가상 서버에 설치된 도커가 동작하는 이유입니다.

- RPM 설치

[Index of linux/centos/](https://download.docker.com/linux/centos/)

1. Go to [https://download.docker.com/linux/centos/](https://download.docker.com/linux/centos/) and choose your version of CentOS. Then browse to `x86_64/stable/Packages/` and download the `.rpm` file for the Docker version you want to install.

    > Note: To install a nightly or test (pre-release) package, change the word stable in the above URL to nightly or test. Learn about nightly and test channels.

2. Install Docker Engine, changing the path below to the path where you downloaded the Docker package.

    Docker 엔진을 설치하고 아래 경로를 Docker 패키지를 다운로드한 경로로 변경하십시오.

    ```jsx
    $ sudo yum install /path/to/package.rpm
    ```

    Docker is installed but not started. The `docker` group is created, but no users are added to the group.

3. Start Docker.

    ```jsx
    $ sudo systemctl start docker
    ```

4. Verify that Docker Engine is installed correctly by running the `hello-world` image.

    ```jsx
    $ sudo docker run hello-world
    ```

    This command downloads a test image and runs it in a container. When the container runs, it prints an informational message and exits.

Docker Engine is installed and running. You need to use `sudo` to run Docker commands. Continue to [Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/) to allow non-privileged users to run Docker commands and for other optional configuration steps.

혹시, 특이한 부분을 찾으셨나요? 버전정보가 클라이언트와 서버로 나뉘어져 있습니다. 도커는 하나의 실행파일이지만 실제로 클라이언트와 서버역할을 각각 할 수 있습니다. 도커 커맨드를 입력하면 도커 클라이언트가 도커 서버로 명령을 전송하고 결과를 받아 터미널에 출력해 줍니다.

![https://subicura.com/assets/article_images/2017-01-19-docker-guide-for-beginners-2/docker-host.png](https://subicura.com/assets/article_images/2017-01-19-docker-guide-for-beginners-2/docker-host.png)

*docker client-host*

기본값이 도커 서버의 소켓을 바라보고 있기 때문에 사용자는 의식하지 않고 마치 바로 명령을 내리는 것 같은 느낌을 받습니다. 이러한 설계가 mac이나 windows의 터미널에서 명령어를 입력했을때 가상 서버에 설치된 도커가 동작하는 이유입니다.

# **sudo 없이 사용하기**

docker는 기본적으로 root권한이 필요합니다. root가 아닌 사용자가 sudo없이 사용하려면 해당 사용자를 `docker`그룹에 추가합니다.

```jsx
sudo usermod -aG docker $USER *# 현재 접속중인 사용자에게 권한주기*
sudo usermod -aG docker your-user *# your-user 사용자에게 권한주기*
```

# 컨테이너 실행하기

도커를 실행하는 명령어는 다음과 같습니다.

`docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]`

다음은 자주 사용하는 옵션들입니다.

[제목 없음](install%20f0872fc57260413abc3932d5b78d90cc/%E1%84%8C%E1%85%A6%E1%84%86%E1%85%A9%E1%86%A8%20%E1%84%8B%E1%85%A5%E1%86%B9%E1%84%82%E1%85%B3%E1%86%AB%20%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%A5%E1%84%87%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%89%E1%85%B3%20584f23ab111743e084ccaf705344b156.csv)

run명령어를 사용하면 사용할 이미지가 저장되어 있는지 확인하고 없다면 다운로드(pull)를 한 후 컨테이너를 생성(create)하고 시작(start) 합니다.

```jsx
docker pull nginx -- 레지스트리에서 이미지를 로컬에 다운로드 할때 사용
docker build -- 베이스 이미지에 기능을 추가하여 새로운 이미지를 만들때 사용
docker images -- 이미지 목록 확인하기 (docker images [OPTIONS] [REPOSITORY[:TAG]])
docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
$ docker tag 0e5574283393 fedora/httpd:version1.0 
docker run -d -p 81:80 nginx:qorehd222
docker ps -a

```

```jsx
docker push 
docker login
docker tag yunspatch:1.0 qorehd222/yunspatch:1.0
docker push qorehd222/yunspatch:1.0
```

# dockerfile 이미지 빌드

Dockerfile을 이용하여 베이스 이미지를 지정한 뒤, 필요한 미들웨어 설치 및
명렁어 추가 등을 통해 원하는 형태의 이미지를 작성하는 방법

· Dockerfile 작성하기
· Dockerfile 명령어와 데몬
· 도커 레지스트리를 이용한 사설 저장소 구축

- vsphere 에서 옵션 추가

    ![install%20f0872fc57260413abc3932d5b78d90cc/Untitled.png](install%20f0872fc57260413abc3932d5b78d90cc/Untitled.png)

- 도커 파일

```jsx
## docker 파일 디렉토리 생성
mkdir docker/Dockerfile -- 대문자 지정!

vi Dockerfile
FROM centos:7 --이미지 명 만을 지정할 경우에는 도커허브에서 제공하는 최신버전의 이미지를 사용
RUN yum -y update
RUN yum -y install httpd
EXPOSE 80
CMD ["/bin/bash"]
------------------------------------------------------------------------------------
FROM centos:7 --  base (기본)이미지 --apline 사용 권장(필요한 최소 이미지) 
RUN yum -y update -- 쉘 명령어 실행
RUN yum -y install httpd
ADD /start.sh /start.sh -- 파일또는 디렉토리 추가. URL/ZIP 사용 가능
# COPY /start.sh /start.sh -- 파일또는 디렉토리 추가.
RUN chmod 755 /start.sh
EXPOSE 80  --- 오픈되는 포트 정보 
ENTRYPOINT ["sh","/start.sh"] -- 컨테이너 기본 실행 명령어
#CMD ["/bin/bash"] -- 컨테이너 기본 실행 명령어 ( Entrypoint 의 인자로 사용)
#CMD ["/usr/bin/httpd"]
-----------------------------------------------------------------------------------
# docker build -t [생성할 이미지명]:[태그명] [도커파일의 위치]

docker build -t yunspatch:1.0 -- -t 옵션으로 빌드될 이미지 이름 설정
docker container run -it -d -p 8008:80 yunspatch:1.0

```

![install%20f0872fc57260413abc3932d5b78d90cc/Untitled%201.png](install%20f0872fc57260413abc3932d5b78d90cc/Untitled%201.png)

명령실행(RUN)

FROM 명령에서 지정한 베이스 이미지에 대해 애플리케이션/미들웨어 등을
설치하거나 환경 구축을 위한 명령을 실행하기 위하여 RUN을 사용한다. 도커파일에서 가장 많은 사용빈도를 보인다고 할 수 있다. Dockerfile에서 RUN 은 Shell 형식과 Exec 형식으로 명령을 작성할 수 있다.

- shell 형식 으로 작성

```jsx
# Installing Nginx
RUN apt-get -y install nginx
위의 방법은 컨테이너 내에서 /bin/sh -c를 이용하여 명령을 실행했을 때와 동일하게 작동
하며 기본 쉘을 변경하고자 한다면 SHELL을 이용하여 변경이 가능하다.
```

- Exec 형식으로 작성

```jsx
# Installing Nginx
RUN ["/bin/bash", "-c", "apt-get -y install nginx"]
shell 형식으로 명령을 기술하면 /bin/sh에서 실행되지만 Exec 형식으로 기술하면 쉘을 경유
하지 않고 직접 실행한다. 따라서 $HOME 과 같은 환경 변수를 지정할 수 없게된다.
##Run 실행 예 
FROM ubuntu
RUN echo 안녕하세요 쉘 형식입니다. RUN ["echo", "안녕하세요 Exec 형식입니다“]
RUN ["/bin/bash", "-c", "echo '안녕하세요 Exec 형식에서 bash를 사용 했습니다‘ “]
```

이미지 태그설정 (docker image tag ; docker tag)
이미지태그는 일반적으로 버전을 표기한다. 도커 허브에 이미지를 등록하려면 <도커허브
ID>/이미지명:[태그명] 으로 작성된 이미지를 사용해야 하는데 아래는 다운로드 된 이미지를
사용하여 별도의 이미지로 태그를 작성한 예 이다.

이미지 삭제 (docker image rm ; docker rmi)
이미지를 삭제하고자 할 때에는 image rm을 사용하여 삭제할 수 있다. 만약 해당 이미지를
이용하여 동작중인 컨테이너가 있어 삭제할 수 없다는 내용이 나오면 -f 옵션을 사용하여
강제로 삭제할 수 있다

- 컨테이너 네트워크

```jsx
[root@apps docker]# docker network ls ---도커 네트워크의 목록
NETWORK ID     NAME      DRIVER    SCOPE
7a0541ff7a8f   bridge    bridge    local
d90f73077d19   host      host      local
c7cb82ecef37   none      null      local

[root@apps docker]# docker network create --driver=bridge \
> --subnet=20.20.0.0/16 --ip-range=20.20.20.0/24 net-test
1ba161bbbc48ba654c90c3da7e5c48290dff918ea2ebacc6db8b90955ea7a047
## 새로운 네트워크 net-test 생성 ## 

[root@apps docker]# docker network ls
NETWORK ID     NAME       DRIVER    SCOPE
7a0541ff7a8f   bridge     bridge    local
d90f73077d19   host       host      local
1ba161bbbc48   net-test   bridge    local
c7cb82ecef37   none       null      local
[root@apps docker]#
[root@apps docker]# docker ps
CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS          PORTS
95f32367cba7   yunspatch:1.0   "/bin/bash"   19 minutes ago   Up 19 minutes   0.0.0
[root@apps docker]#
[root@apps docker]#
[root@apps docker]# docker network connect --ip=20.20.20.20 net-test 95f32367cba7 == 생성된 컨테이너를 도커 네트워크에 연결 
[root@apps docker]#
[root@apps docker]#
[root@apps docker]# docker container inspect 95f32367cba7 | grep IP
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2", -- 기존 ip
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
                    "IPAMConfig": null,
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "IPAMConfig": {
                        "IPv4Address": "20.20.20.20" -- 추가된 ip
                    "IPAddress": "20.20.20.20",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
[root@apps docker]# docker network disconnect bridge 95f32367cba7
[root@apps docker]# docker container inspect 95f32367cba7 | grep IP
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "",
            "IPPrefixLen": 0,
            "IPv6Gateway": "",
                    "IPAMConfig": {
                        "IPv4Address": "20.20.20.20"
                    "IPAddress": "20.20.20.20",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
[root@apps docker]# docker network ls
NETWORK ID     NAME       DRIVER    SCOPE
7a0541ff7a8f   bridge     bridge    local
d90f73077d19   host       host      local
1ba161bbbc48   net-test   bridge    local
c7cb82ecef37   none       null      local
[root@apps docker]#
[root@apps docker]#
[root@apps docker]# docker container ls
CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS          PORTS
95f32367cba7   yunspatch:1.0   "/bin/bash"   22 minutes ago   Up 22 minutes   0.0.0
[root@apps docker]#
[root@apps docker]#
[root@apps docker]# ifconfig
br-1ba161bbbc48: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 20.20.20.0  netmask 255.255.0.0  broadcast 20.20.255.255
        inet6 fe80::42:18ff:febe:bbe6  prefixlen 64  scopeid 0x20<link>
        ether 02:42:18:be:bb:e6  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::42:a2ff:fe9b:79e9  prefixlen 64  scopeid 0x20<link>
        ether 02:42:a2:9b:79:e9  txqueuelen 0  (Ethernet)
        RX packets 48078  bytes 2639808 (2.5 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 84074  bytes 339353519 (323.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

![install%20f0872fc57260413abc3932d5b78d90cc/Untitled%202.png](install%20f0872fc57260413abc3932d5b78d90cc/Untitled%202.png)

docker push 올리는법

```jsx
# docker images
REPOSITORY   TAG        IMAGE ID       CREATED          SIZE
yunspatch    1.0        9aaf758b416e   41 minutes ago   591MB
httpd        latest     bd29370f84ea   4 days ago       138MB
nginx        latest     4cdc5dd7eaad   6 days ago       133MB
ubuntu       18.04      7d0d8fa37224   3 weeks ago      63.1MB
centos       7          8652b9f0cb4c   8 months ago     204MB
centos       7.4.1708   9f266d35e02c   2 years ago      197MB
# docker login
# docker tag yunspatch:1.0 qorehd222/yunspatch:1.0
# docker push qorehd222/yunspatch:1.0

```

# docker mount (-v) 명령

-v /my/won/datadir : /var/lib/mysql