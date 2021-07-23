# 드라이버 업데이트(extension driver)

## iso 파일 모듈 로드

            

> 참고

[https://access.redhat.com/documentation/ko-kr/red_hat_enterprise_linux/7/html/installation_guide/sect-driver-updates-during-installation-preparing-x86](https://access.redhat.com/documentation/ko-kr/red_hat_enterprise_linux/7/html/installation_guide/sect-driver-updates-during-installation-preparing-x86)

[https://www.intel.co.kr/content/www/kr/ko/support/articles/000058740/server-products.html](https://www.intel.co.kr/content/www/kr/ko/support/articles/000058740/server-products.html)

[CentOS 8/Redhat 8 설치시 RAID DISK 안보임](https://atelier-house.tistory.com/5)

## lsmod

현재 시스템에 설치되어 있는 모듈들의 목록을 볼 수 있다.

## insmod

## rmmod

각각 모듈을 설치하고 삭제하는 명령어이다. 잘 쓰이지 않는다.

## **modprobe**

앞서 언급한 insmod 및 rmmod는 의존성 해결에 대한 메커니즘이 없는 반면, modprobe는 기본적으 modules.dep 파일을 참고해 적재 또는 제거 시 의존성 문제를 스스로 해결한다.

**주요 옵션**

- l : 모든 모듈 목록을 출력한다.
- r : 모듈을 제거한다. 의존성 있는 모듈이 사용되고 있지 않다면 알아서 같이 제거한다.
- c : 모듈 관련 환경 설정 파일의 내용을 전부 출력한다.

**주요 파일**

/etc/modprobe.conf

/etc/modprobe.d

부팅 시에 특정 모듈을 자동으로 적재할 때 사용된다. 커널 버전 2.4까진 modprobe.conf가 사용되었지만 2.6버전부터는 /etc/modprobe.d 라는 디렉토리에 있는 모든 *.conf 파일을 읽는 방식으로 변경되었다.

/lib/modules/커널버전/modules.dep

모듈간의 의존성을 관리한다. 모듈파일명과 함께 의존성 있는 모듈의 목록이 나열 되어 있다. 의존성이 변경되면 depmod 명령어로 의존성을 갱신해 주어야 한다.

# **modinfo**

모듈의 정보를 조회한다.

# 실습

### 1. iso 이미지 다운로드

[https://elrepo.org/linux/dud/el8/x86_64/](https://elrepo.org/linux/dud/el8/x86_64/)

[다운로드 인텔® Embedded Server RAID Technology 62X 칩셋 기반 인텔® 서버 보드 및 시스템용® 2(ESRT2) Linux* 드라이버](https://downloadcenter.intel.com/ko/download/29487/?v=t)

### 2. 패키지 압축 푼후 isos 파일 이동

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/Untitled.png](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/Untitled.png)

### 3. 대상 RHEL 버전을 선택하고 파일의 풀기

### 4. dd.iso 파일을 cd/dvd 롬에 추가

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/Untitled%201.png](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/Untitled%201.png)

### 5. 설치화면에서 tab 을 눌러 명령어 옵션 켬

                  vender 사에서 릴리즈버전과 호환되는 이미지 파일 찾아 dd.iso 파일 받기

                                         받은 이미지파일을 cd/dvd 에 추가해준다.

                     그리고 인스톨 메뉴에서 TAB 키를 눌러 quiet 뒤에 한칸 띄어서 

                                       modprobe.blacklist=ahci inst.dd 입력후 엔터

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/1.jpg](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/1.jpg)

               

               sr0번은 os iso파일이고 sr1번이 추가해줄 iso 파일 드라이버다. 2 번을 입력해준다.

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/2.jpg](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/2.jpg)

                                              그 다음 os iso 파일을 선택해준다 1번입력

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/3.jpg](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/3.jpg)

                                              입력을 하면 체크박스에 x 로 체크가 된다.

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/4.jpg](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/4.jpg)

 

                                                                       다시 c 입력

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/5.jpg](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/5.jpg)

                                     그러면 초기화면으로 돌아온다. 여기서 한번 더 c 입력

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/6.jpg](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/6.jpg)

                                   새로운 드라이버가 추가 되고 있는 것을 확인 할 수 있다.

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/7.jpg](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/7.jpg)

                       설치가 완료 된 후 터미널에서 find / -name "*megasr*" 을 입력 해 확인

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/8.jpg](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/8.jpg)

               lsmod | grep megasr 을 입력 해봐도 잘 모듈이 올라가있는 것을 확인 할 수 있다.

![%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/9.jpg](%E1%84%83%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A5%20%E1%84%8B%E1%85%A5%E1%86%B8%E1%84%83%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%90%E1%85%B3(extension%20driver)%20950c1a096e8d451391a60dbb570e46e3/9.jpg)

           *다만 볼륨을 지정해주지 않았기 때문에 GUI설치과정에서는 디스크가 보이지 않는다.