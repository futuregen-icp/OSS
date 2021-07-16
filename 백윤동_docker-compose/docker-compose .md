# docker-compose

docker-compose.yml 파일

도커 컴포즈를 사용하면 컨테이너 실행에 필요한 옵션을 docker-compose.yml이라는 파일에 적어둘 수 있고, 컨테이너 간 실행 순서나 의존성도 관리할 수 있습니다.

docker-compose.yml은 장황한 도커 실행 옵션을 미리 적어둔 문서라고 볼 수 있습니다.

```jsx
[root@apps LEMP_docker]# vim docker-compose.yml
version: '3' #--파일의 규격에 따라 지원하는 옵션이 달라지는데, “3”이라만 적으면 3으로 시작하는 최신 버전을 사용한다는 의미
services:  #-- 이 항목 밑에 실행하려는 컨테이너들을 정의, 컴포즈에서는 컨테이너 대신 서비스라는 개념을 사용
    db:
        container_name: mariadb
        image: mariadb
        restart: always
        ports: ### docker run 명령어의 -p 옵션에 해당하는 부분
              - 3316:3306 
        volumes:
              - ./mariadb/data:/var/lib/mysql
              - ./mariadb/config:/etc/mysql/conf.d
## volumes 
#docker run으로 db 컨테이너를 실행할 때 --volume 옵션을 사용하여 데이터베이스의 데이터를 로컬 컴퓨터에 저장했던 부분과 같습니다. 
#다만 docker-compose.yml의 volumes에는 상대 경로를 지정할 수 있어서 편리합니다.
#docker run으로 db 컨테이너를 실행할 때와 마찬가지로, 프로젝트 루트 아래의 docker/data 디렉터리에 데이터를 저장하기로 했습니다.

        environment: # docker run 명령어의 -e 옵션 환경변수 지정 
              - MYSQL_ROOT_PASSWORD=mypass
              - TZ=Asia/Seoul

## command 
## docker run으로 앱 컨테이너를 실행할 때 가장 마지막에 적었던 명령어 부분입니다.

    php:
        container_name: php-fpm
#        image: php:fpm         #official image but modules are not included
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
             - "8080:80"
        volumes:
             - ./www:/www  #home diretory
             - ./nginx/conf.d:/etc/nginx/conf.d
             - ./nginx/logs:/var/log/nginx

        environment:
             - TZ=Asia/Seoul

## docker-compose 명령어
# docker-compose up -d # docker-compose.yml 파일의 내용에 따라 이미지를 빌드하고 서비스를 실행
# 서비스 실행 과정 
#1 서비스를 띄울 네트워크 설정
#2 필요한 볼륨 생성(혹은 이미 존재하는 볼륨과 연결)
#3 필요한 이미지 풀(pull)
#4 필요한 이미지 빌드(build)
#5 서비스 의존성에 따라 서비스 실행
# -d: 서비스 실행 후 콘솔로 빠져나옵니다
# --force-recreate: 컨테이너를 지우고 새로 만듭니다.
# --build: 서비스 시작 전 이미지를 새로 만듭니다.
```

[haproxy roundrobin 설정 및 확인 ](docker-compose%2045ad8fbaaadc4afc943c73591504b263/haproxy%20roundrobin%20%E1%84%89%E1%85%A5%E1%86%AF%E1%84%8C%E1%85%A5%E1%86%BC%20%E1%84%86%E1%85%B5%E1%86%BE%20%E1%84%92%E1%85%AA%E1%86%A8%E1%84%8B%E1%85%B5%E1%86%AB%206ba0d4360888417289fa6d31cf2cbe45.md)