# PAM, kisa 보안가이드

PAM(Pluggable Authentication Modules)이란

PAM은 리눅스 시스템에서 사용하는 '인증 모듈(Pluggable Authentication Modules)'로써 응용 프로그램(서비스)에 대한 사용자의 사용 권한을 제어하는 모듈이다.

이를 해결하기 위해 PAM이 등장하게 되었으며, PAM의 동작 원리는 다음과 같다.

1. 인증이 필요한 응용프로그램은 더 이상 passwd 파일을 열람하지 않고 ‘PAM’ 모듈에 사용자 인증을 요청한다.

2. PAM은 인증을 요청한 사용자의 정보를 가지고 결과를 도출하여 응용프로그램에 전달한다.

![http://www.igloosec.co.kr/files/2019/12/27/20191227091849be997627-4147-466b-a229-7e602e5b052c.png](http://www.igloosec.co.kr/files/2019/12/27/20191227091849be997627-4147-466b-a229-7e602e5b052c.png)

[그림 1] 응용프로그램 자체적으로 사용자 인증하는 과정

![http://www.igloosec.co.kr/files/2019/12/27/201912270919020ee3f79c-5cfb-4774-8339-daf65d9fa6bd.png](http://www.igloosec.co.kr/files/2019/12/27/201912270919020ee3f79c-5cfb-4774-8339-daf65d9fa6bd.png)

[그림 2] PAM 모듈을 통한 사용자 인증 과정

pam 설정 예제

## PAM파일의 구성문법

1) 기본구조: 다음과 같이 구성되어 있다.

type   control   module-path   module-arguments

2) 기본구조의 예

[pam_nologin.so](https://sysops.tistory.com/pam_nologin.so)

```jsx
[root@www /etc/pam.d]#cat login

#%PAM-1.0

auth       required     /lib/security/[pam_securetty.so](https://sysops.tistory.com/pam_securetty.so)

auth       required     /lib/security/[pam_stack.so](https://sysops.tistory.com/pam_stack.so) service=system-auth

auth       required     /lib/security/ [pam_nologin.so](https://sysops.tistory.com/pam_nologin.so) 

account    required     /lib/security/[pam_stack.so](https://sysops.tistory.com/pam_stack.so) service=system-auth

password   required     /lib/security/[pam_stack.so](https://sysops.tistory.com/pam_stack.so) service=system-auth

session    required     /lib/security/[pam_stack.so](https://sysops.tistory.com/pam_stack.so) service=system-auth

session    optional     /lib/security/[pam_console.so](https://sysops.tistory.com/pam_console.so)
```

3) 구성의 종류

- type: 이 부분은 PAM에 어떤 타입의 인증이 사용될 것인지를 알려준다. 같은 타입의 모듈은

쌓일 수 있고, 사용자에 인증되기 위한 다중 요구사항을 만족하도록 요청할 수 있다.

다음과 같은 4개의 타입이 있다.

- account: 계정은 사용자가 해당 서비스에 접근이 허용되었는지, 패스워드가 기간이 만료가

되었는지를 결정한다.

- auth: 주로 패스워드를 통하지만 생체인증과 같은 보다 정교한 방법을 통해서 사용자가

자신이 주장하는 사용자가 맞는지를 결정한다.

- password: 패스워드는 사용자가 그들의 인증을 변경하도록 어떤 방법을 제공한다. 이것을

결정하는 것이 패스워드이다.

- session: 사용자가 인증받기 전후에 해야 할 것을 나타낸다. 사용자의 홈디렉토리를 마운

트/언마운트, 로그인/로그아웃 서비스를 제한하는 등의 포함한다.

- control: 통제를 담당하는 부분으로  PAM에 무엇을 해야할 지를 알려준다. 4가지의 형식이

있다.

- requisite: 이 모듈을 이용하는 인증이 실패할 경우, 즉시 인증을 거부하도록 한다.
- required: 인증이 거부되기 전에 비록 PAM이 이 서비스에 등록된 다른 모든 모듈들을 요구

함에도 불구하고 실패할 경우 인증을 거부하도록 한다.

- sufficient: 비록 이전에 요청되어진 모듈이 실패하더라도 이 모듈에 의해서 인증이 성공할

경우, PAM은 인증을 승인한다.

- optional : 이 모듈이 서비스에 대한 응용프로그램의 성공/실패에 중요하지 않다는 것을 의

미한다. 보통 PAM은 모듈들의 성공/실패 판단시에 이런 모듈은 무시한다. 그러나

이전/이후의 모듈들이 명확한 성공/실패가 없다면 이 모듈이 응용프로그램에게

주는 결과를 결정짓는다.

- module-path: 모듈경로는 PAM에게 어떤 모듈을 사용하고 그 경로를 알려준다. 대부분 PAM모

듈은 /lib/security에 있다.

- module-argument: 모듈-인수는 모듈에게 전달되는 인수를 나타낸다. 각각의 모듈은 각각의

인수를 가지고 있다.

[[Linux] PAM 파일 상세 설명 및 설정 방법](https://sysops.tistory.com/125)

### 특정계정에 대해 telnet 접속은 막고, ftp접속만 허가하도록 해보자.

1. /etc/pam.d/login파일을 열어서 아래라인을 추가한다.

```jsx
#%PAM-1.0
auth [user_unknown=ignore success=ok ignore=ignore default=bad] pam_securetty.so
auth       required     /lib64/security/pam listfile.so item=user sense=deny file=/etc/loginusers onerr=succeed
#auth      required     /lib64/security/pam listfile.so item=user sense=allow file=/etc/loginusers onerr=fail
```

2) /etc/loginusers 파일을 만들고 telnet 접속을 막을 계정을 적는다.

[root@www root]# cat /etc/loginusers

```jsx
[root@test1 ~]# vi /etc/loginusers
qorehd222vi /
```

qorehd222

=> qorehd222 이라는 계정은 텔넷은 사용할 수 없고 ftp만 사용가능하다.

### /etc/loginusers파일에 등록된 사용자만 로그인을 허용하도록 해보자

1) /etc/pam.d/login파일을 열어 아래라인을 추가한다.

```jsx
#%PAM-1.0
auth [user_unknown=ignore success=ok ignore=ignore default=bad] pam_securetty.so
#auth       required     /lib64/security/pam listfile.so item=user sense=deny file=/etc/loginusers onerr=succeed
auth      required     /lib64/security/pam listfile.so item=user sense=allow file=/etc/loginusers onerr=fail
```

2) /etc/loginusers 파일을 만들고 접속하고자 하는 계정을 한줄에 하나씩 적는다.

### su명령어를 특정사용자에게만 허가하기

1) 설명: PAM서는 특정사용자만 특정한 그룹(보통 wheel)에 속하도록 하여 그 그룹에 속한 사용자만 특정한 권한을 가도록 하기 위해 [pam_wheel.so라는](https://sysops.tistory.com/pam_wheel.so%EB%9D%BC%EB%8A%94) 모듈을 제공한다. 또한 리눅스에서는 기본적으로 wheel이라는 그룹이 생성되어 있으므로 이 두가지를 이용하면 된다.

2) 설정하기

ㄱ. /etc/group파일에서 wheel그룹에 su명령어를 사용할 사용자를 추가한다.

```jsx
[root@test1 ~]# usermod -G wheel qorehd02
[root@test1 ~]# tail -2 /etc/passwd
qorehd222:x:1000:1000::/home/qorehd222:/bin/bash
qorehd02:x:1001:10::/home/qorehd02:/bin/bash

[root@test1 ~]# cat /etc/group | grep wheel
wheel:x:10:qorehd02,root
[root@test1 ~]# vi /etc/pam.d/su
#%PAM-1.0
auth            sufficient      pam_rootok.so
auth            required        /lib64/security/pam_wheel.so debug group=wheel

```

확인

```jsx
ssh qorehd02@192.168.222.20
qorehd02@192.168.222.20's password:
X11 forwarding request failed on channel 0
Last login: Wed Jul 21 10:59:52 2021 from 192.168.222.1
[qorehd02@test1 ~]$ su -
Password:
Last login: Wed Jul 21 11:01:26 KST 2021 on pts/1
Last failed login: Wed Jul 21 11:15:20 KST 2021 on pts/1
There were 11 failed login attempts since the last successful login.
--------------------------------------------------------------------
[root@test1 ~]# exit
ssh qorehd222@192.168.222.20
qorehd222@192.168.222.20's password:
X11 forwarding request failed on channel 0
Last login: Wed Jul 21 11:13:12 2021 from 192.168.222.1
[qorehd222@test1 ~]$ su
Password:
su: Permission denied
```

“login” 및 “gdm”(Graphical Login) 제한 설정이 설정파일은 로그인 프로그램 또는 gdm(graphical login)에 사용자 인증의 기본 설정값을 알려준다.

PAM module: pam_access.so이 모듈은 로그인명과 호스트명, IP주소 등 몇몇가지를 기반으로 하여 로그인 접속 제어를 로그데몬 방식으로 제공한다. 이것의 설정은 /etc/security/access.conf 파일에서 할 수 있다./lib/security/pam_access.so /etc/security/access.conf 파일을 이용하여 모든 계정의 로그인 매개변수 검사

/etc/pam.d/login 예제/etc/pam.d/login 파일을 사용하는 방법에 대한 예제가 아래에 있다.:

auth required /lib/security/pam_securetty.soauth required /lib/security/pam_stack.so service=system-authauth required /lib/security/pam_nologin.soaccount required /lib/security/pam_access.soaccount required /lib/security/pam_stack.so service=system-authpassword required /lib/security/pam_stack.so service=system-authsession required /lib/security/pam_stack.so service=system-authsession optional /lib/security/pam_console.so

“login”, “gdm”(Graphical Login), SSH, 등등을 위한 로그인 제한아래와 같이 설정하기 위해서는 PAM 설정파일에 pam_access 모듈이 설정되어 있어야 된다. /etc/security/access.conf 에 설정되어 있는 ssh 접속에 대해서 즉시 적용되길 원한다면, /etc/pam.d/sshd 파일에 /lib/security/pam_access.so 에 대한 설정이 있어야 한다.

PAM 설정 파일의 마지막 부분에 pam_access.so 를 설정하길 권장한다.:/etc/pam.d/sshd/etc/pam.d/login/etc/pam.d/gdm

/etc/security/access.conf 예제일반적으로 사용자 계정은 “users” 그룹에 포함되게 된다. 공유 계정 또는 시스템 계정은 “users” 그룹에 포함되어서는 안된다. 시스템이 있다고 가정한다면, 우리는 직접적인 로그인은 “users” 계정에 포함된 계정(예를 들면 모든 사용자 계정)만 작동하게 규정할 수 있다. 사용자 계정이 아닌 계정 즉, “users” 그룹에 포함되지 않은 계정(예를 들면 공유 계정과 시스템 계정)에 대한 직접적인 로그인은 불가능 해야 한다.그 이유는 공유계정으로 로그인 한 사용자에 대한 역추적이 불가능하기 때문이다. 만약 공유 계정에 대해서 직접적인 로그인을 불가능하게 하고, 공유 계정에 su 명령을 허락한다면 공유 계정에서 su 명령을 통해서 전환한 사용자에 대해서 역추적을 할 수 있다.

위와 같이 로그인을 제한하기 위해서는 다음과 같은 라인을 추가해야 한다.:

- :ALL EXCEPT users :ALL참고 : 위의 경우, /etc/passwd 파일에 “users”라는 사용자 계정이 없어야만 제대로 작동한다.

### 사용자 패스워드 길이 제한하기

1) 설명

리눅스에서 패스워드 기본설정과 관련된 파일이 /etc/[login.defs이다.](https://sysops.tistory.com/login.defs%EC%9D%B4%EB%8B%A4.)

이 파일에서 패스워드의 길이는 최소 5자로 설정하고 있다. 

이 파일에서 설정해도 되지만 PAM을 이용하여 패스워드의 길이를 설정할 수 있다. 

기본 설정파일은 /etc/pam.d/passwd이다.

2) 설정하기

ㄱ. /etc/pam.d/passwd파일의 기본설정상태

```jsx
[root@test1 ~]# vi /etc/pam.d/passwd
#%PAM-1.0
#///////////// 주석부분은 centos7 기본 설정 값들 /////////////
#auth       include     system-auth
#account    include     system-auth
#password   substack    system-auth
#-password   optional   pam_gnome_keyring.so use_authtok
#password   substack    postlogin  
#/////////// 설정 추가 부분 ////////////////ㄷ. 패스워드 길이제한을 위한 /etc/pam.d/passwd 파일 수정: 내용중 3번째줄을 삭제하고 아래와같이 3줄을 추가한다.
auth       required     /lib64/security/pam_stack.so service=system-auth
account    required     /lib64/security/pam_stack.so service=system-auth
#password   required     /lib64/security/pam_stack.so service=system-auth => 현재 패스워드관련 정책은 /etc/pam.d/system-auth의 설정을 따른다는 뜻이다.
																								 => 현재 기존의 내용을 주석처리하였다. 
																									새로이 설정한 내용은 패스워드를 /etc/pam.d/system-auth파일의 설정을 따르지 않고 새로운 모듈로 설정하였다.
#/////////// 아래 부분 system-auth 참조하지 않고 passwd 설정에 추가 ///////
password   required     /lib64/security/pam_cracklib.so retry=3 minlen=12 type=LINUX
password   sufficient     /lib64/security/pam_unix.so nullok use_authok md5 shadow
password   required     /lib64/security/pam_deny.so
```

ㄴ. 패스워드와 관련된 /etc/pam.d/passwd파일의 기본설정상태 확인

```jsx
[root@www root]# cat /etc/pam.d/system-auth

#%PAM-1.0

# This file is auto-generated.

# User changes will be destroyed the next time authconfig is run.

auth        required      /lib/security/pam_env.so

auth        sufficient    /lib/security/pam_unix.so likeauth nullok

auth        required      /lib/security/pam_deny.so

account     required      /lib/security/pam_unix.so

password    required      /lib/security/pam_cracklib.so retry=3 type=

password    sufficient    /lib/security/pam_unix.so nullok use_authtok md5 shadow

password    required      /lib/security/pam_deny.so

session     required      /lib/security/pam_limits.so

session     required      /lib/security/pam_unix.so
```

3) 테스트

[posein@www posein]$ passwd

Changing password for user posein.

Changing password for posein

(current) UNIX password:

New LINUX password:                // LINUX라는 문구열이 보인다.

Retype new LINUX password:         // LINUX라는 문구열이 보인다.

Enter new UNIX password:

Retype new UNIX password:

passwd: all authentication tokens updated successfully

=> retry=3 으로 설정해서 3번물어본다.

### [pam_cracklib.so](https://sysops.tistory.com/pam_cracklib.so)

ㄱ. 설명: 이 모듈은 password를 설정한 정책과 비교,검사한다.

ㄴ. 모듈인자

- debug

=> 모듈이 동작을 보여주기 위해 syslog에 정보를 남기는데 이 옵션을 사용하면 패스워드정보를 남기지 않는다.

- type=LINUX

=> 모듈의 기본 동작은 패스워드를 물어볼 때 "New UNIX password: "라고 묻는데, 이 옵션을 사용하여 'UNIX'라는 말 대신 'LINUX'로 바꿀 수 있다.

- retry=N

=> 새 패스워드를 물어보는 횟수로서 기본값은 1이다. 이 옵션을 사용하면 N만큼 횟수를 늘릴 수 있다.

- difok=N

=> 새 패스워드에서 예전 패스워드에 있지 않는 문자들을 몇자나 사용해야 하는지 나타내는 수로 기본값은 10이고 새 패스워드에서 1/2이상의 글자가 이전과 다르다면 새 패스워드로 받아들여 진다.

- minlen=N

=> 새 패스워드의 최소 크기에 1을 더한 크기이다. 새 패스워드엔 사용된 문자열의 길이외에 각 문자종류(숫자, 대문자, 소문자, 특수문자)를 사용한 것에 대해 각각 크레디트(credit)를 준다.

- dcredit=N

=> 숫자문자가 가질 수 있는 크레디트값을 지정한다. 기본값은 1이다.

- ucredit=N

=> 대문자가 가질 수 있는 크레디트값을 지정한다. 기본값은 1이다.

- lcredit=N

=> 소문자가 가질 수 있는 크레디트값을 지정한다. 기본값은 1이다.

- ocredit=N

=> 특수문자가 가질수 있는 크레디트값을 지정한다. 기본값은 1이다.

- use_authok

=> 이 인자는 사용자에게 새 패스워드를 묻지말고 앞서 실행된 패스워드모듈에서 받은 것을 사용하도록 모듈에게 강제한다.

- ㄷ. minlen값과 크레디트(credit)

이 모듈은 크레디트(credit)라는 것을 사용한다. 만약 minlen=12 이면 실제적으로 보면 최소패스워드의 길이 12가 되어야 한다.

소문자를 사용함으로 1크레디트, 숫자를 사용하여 1크레디트, 특수문자를 사용하여 1크레디트를 얻으므로 도합 3크레디트를 얻는다.

이런 경우 총문자의 길이는 12-3임으로 실제적으로 9자이상이면 가능하다.

```jsx
[root@test1 ~]# vi /etc/pam.d/system-auth
#//////////////기존 centos7 기본 설정 확인 ///////////////
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        required      pam_faildelay.so delay=2000000
auth        sufficient    pam_unix.so nullok try_first_pass
auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success
auth        required      pam_deny.so

account     required      pam_unix.so
account     sufficient    pam_localuser.so
account     sufficient    pam_succeed_if.so uid < 1000 quiet
account     required      pam_permit.so
#/////ㄹ. /etc/pam.d/system-auth의 내용수정: 패스워드 관련된 부분을 /etc/pam.d/passwd에서 직접 관여하므로 이 파일에서 password관련 3개의 항목을 제거한다.
#password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=
#password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok
#password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
-session     optional      pam_systemd.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so
```

**■ /etc/pam.d/system-auth**

password    requisite     pam_cracklib.so try_first_pass retry=5 type= minlen=8 lcredit=-1

ucredit=-1 dcredit=-1 ocredit=-1=> system auth 에서 설정까지 한꺼번에 등록 해버림

retry=3 : password 변경 때 3번 틀리면 변경 실패

minlen=8 : 최소 8자리 이상의 문자

lcredit=-1 : 최소 1개 이상의 소문자 포함

ucredit=-1 : 최소 1개 이상의 대문자 포함

dcredit=-1 : 최소 1개 이상의 숫자 포함

ocredit=-1 : 최소 1개 이상의 특수문자 포함

**■CENT OS 7**

**■  pam_cracklib.so이 pam_pwquality.so로 변경된점이 차이점**

**/etc/security/pwquality.conf**

minlen = 8              // 최소 암호 길이

dcredit = -1            // 패스워드에 숫자 필요

ucredit = -1            // 패스워드에 영문 대문자 필요

lcredit = -1             // 패스워드에 영문 소문자 필요

ocredit = -1            // 패스워드에 특수문자 필요=> -1이 절대값 판정으로 1 과 같다고 함 즉 1개 이상 필요

※ 위 네가지(숫자, 대문자, 소문자, 특수문자)를 모두 포함하는 설정은 "minclass"

**■ pwquality.conf를 읽도록 pam 모듈에 추가**

vi /etc/pam.d/system-auth-ac

password    required      pam_pwquality.so enforce_for_root

vi /etc/pam.d/password-auth-ac

password    required      pam_pwquality.so enforce_for_root=> system auth 에서 pwquality만 등록 함

- system-auth과 password-auth차이점

=>  system-auth는 보통 로컬 로그인 , password-auth은 원격로그인 담당하는 경우 => x-window 같은 경우  system-auth의 정책을 받음 이와 같이 예외의 경우도 있다.

### 임계값 설정

```jsx
[root@test1 ~]# vi /etc/pam.d/system-auth
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        required      pam_faildelay.so delay=2000000
auth        sufficient    pam_unix.so nullok try_first_pass
auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success
auth        required      pam_deny.so
#
auth        required      pam_tally2.so deny=5 unlock_time=120 no_magic_root
account     required      pam_tally2.so no_magic_root reset
#
account     required      pam_unix.so
[root@test1 ~]# vi /etc/pam.d/password-auth
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        required      pam_faildelay.so delay=2000000
auth        sufficient    pam_unix.so nullok try_first_pass
auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success
auth        required      pam_deny.so
#
auth        required      pam_tally2.so deny=5 unlock_time=60 no_magic_root
account     required      pam_tally2.so no_magic_root reset
#
```

# pam_tally2 → 잠금 계정 정보를 출력

Login Failures Latest failure From

pamtest 6 08/30/19 13:50:28 pts/2

# pam_tally2 -r -u pamtest → 잠금 계정 해제

Login Failures Latest failure From

pamtest 6 08/30/19 13:50:28 pts/2

### 패스워드 관리

```jsx
[root@test1 ~]# pwunconv
[root@test1 ~]# vi /etc/passwd

qorehd222:x:1000:1000::/home/qorehd222:/bin/bash
qorehd02:x:1001:10::/home/qorehd02:/bin/bash
qorehd123:x:1002:1002::/home/qorehd123:/bin/bash

[root@test1 ~]# pwconv
[root@test1 ~]# vi /etc/passwd

qorehd222:$6$nU8kHOlK$kvtJ5zxYdPTBhkub5aD3.RJYI4wgdsGDb9VjH.olgyQK0HLySQd3swyINJe5sTvShsl9eOgtannu1zZrZWudN/:1000:1000::/home/qorehd222:/bin/bash
qorehd02:$6$kyTRrWEU$85KEIc2YTq4qKIgXmWSgHR0xKlaAUz1gCmHSIPeT6Y2foS22BxYFVZIkkFxitYdBnNaGSaBA9rUs3IY9/Htqu/:1001:10::/home/qorehd02:/bin/bash
```