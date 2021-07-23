# KISA 보안가이드라인 or PAM

================================================================

# **root 홈, 패스 디렉터리 권한 및 패스 설정**

### 취약점 개요

### 점검 내용

- root 계정의 PATH 환경변수에 "."이 포함되어 있는지 점검

### 점검 목적

- 비인가자가 불법적으로 생성한 디렉터리를 우선으로 가리키지 않도록 설정하기 위해 환경변수 점검이 필요함

### 보안 위협

- 관리자가 명령어(예: ls, mv, cp 등)를 수행했을 때 root 계정의 PATH 환경변수에 "."(현재 디렉터리 지칭)이 포함되어 있으면 현재 디렉터리에 명령어와 같은 이름의 악성 파일이 실행되어 악의적인 행위가 일어날 수 있음.

### 참고

- **환경변수:** 프로세스가 컴퓨터에서 동작하는 방식에 영향을 미치는 동적인 값들의 집합으로 Path 환경변수는 실행파일을 찾는 경로에 대한 변수

---

### 점검대상 및 판단기준

### 대상

- SOLARIS, LINUX, AIX, HP-UX 등

### 판단기준

> 양호

- PATH 환경변수에 "." 이 맨 앞이나 중간에 포함되지 않은 경우

> 취약

- PATH 환경변수에 "." 이 맨 앞이나 중간에 포함되어 있는 경우

### 조치방법

- root 계정의 환경변수 설정파일("/.profile", "/.cshrc" 등)과 "/etc/proflie" 등에서 PATH 환경변수에 포함되어 있는 현재 디렉터리를 나타내는 "."을 PATH 환경변수의 마지막으로 이동 "/etc/profile", root 계정의 환경변수 파일, 일반계정의 환경변수 파일을 순차적으로 검색하여 확인

---

### 점검 및 조치 사례

### OS별 점검 파일 위치 및 점검 방법

> SOLARIS, LINUX, AIX, HP-UX

- #echo $PATH/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin/X11:/usr/local/bin:/usr/bin:/usr/X11R6/bin:/root/bin위와 같이 출력되는 PATH 변수 내에 "." 또는 "::" 포함 여부 확인

**PATH 변수 내에 ".", "::" 이 맨 앞에 존재하는 경우 아래의 보안설정방법에 따라 설정을 변경함**

- SHELL에 따라 참조되는 환경 설정 파일 /bin/sh - /etc/profile, $HOME/.profile /bin/csh - $HOME/.cshrc, $HOME/.login, /etc/.login /bin/ksh - /etc/profile, $HOME/.profile, $HOME/kshrc /bin/bash - /etc/profile, $HOME/.bash_profile

> SOLARIS, LINUX, ALX, HP-UX

- Step 1) vi 편집기를 이용하여 root 계정의 설정파일(~/.profile 과 /etc/profile) 열기 #vi /etc/profile
- Step 2) 아래와 같이 수정 (수정 전) PATH=.: $PATH:$HOME/bin (수정 후) PATH=$PATH:$HOME/bin:.

================================================================

# **Session Timeout 설정**

### 취약점 개요

### 점검 내용

- 사용자 쉘에 대한 환경설정 파일에서 session timeout 설정 여부 점검

### 점검 목적

- 사용자의 고의 또는 실수로 시스템에 계정이 접속된 상태로 방치됨을 차단하기 위함

### 보안 위협

- Session timeout 값이 설정되지 않은 경우 유휴 시간 내 비인가자의 시스템 접근으로 인해 불필요한 내부 정보의 노출 위험이 존재함

### 참고

- session: 프로세스들 사이에 통신을 수행하기 위해서 메시지 교환을 통해 서로를 인식한 이후부터 통신을 마칠 때까지의 연결

---

### 점검대상 및 판단기준

### 대상

- SOLARIS, LINUX, AIX, HP-UX 등

### 판단기준

> 양호

- Session Timeout이 600초(10분) 이하로 설정되어 있는 경우

> 취약

- Session Timeout이 600초(10분) 이하로 설정되지 않은 경우

### 조치방법

- 600초(10분) 동안 입력이 없을 경우 접속된 Seesion을 끊도록 설정

---

### 점검 및 조치 사례

### OS별 점검 파일 위치 및 점검 방법

> SOLARIS, LINUX, AIX, HP-UX

**<sh, ksh, bash 사용 시>**

- #cat /etc/profile(.profile)TMOUT=600export TMOUT

**<csh 사용 시>**

- #cat /etc/csh.login 또는, #cat/etc/csh/cshrcset authlogout=10

> 위 설정이 적용되지 않는 경우

**<sh, ksh, bash 사용 시>**

- Step 1) vi 편집기를 이용하여 "/etc/profile(.profile)" 파일 열기Step 2) 아래와 같이 수정 또는, 추가

**<csh 사용 시>**

- Step 1) vi 편집기를 이용하여 "/etc/csh.login" 또는, "/etc/csh/cshrc" 파일 열기Step 2) 아래와 같이 수정 또는, 추가 set autologout=10 (단위:분)

### 조치 시 영향

- 모니터링 용도일 경우 세션 타임 설정 시 모니터링 업무가 불가 할 수 있으므로 예외처리 필요

================================================================

# **패스워드 최소 사용기간 설정**

### 취약점 개요

### 점검 내용

- 시스템 정책에 패스워드 최소 사용기간 설정이 적용되어 있는지 점검

### 점검 목적

- 패스워드 최소 사용 기간 설정이 적용되어 있는지 점검하여 사용자가 자주 패스워드를 변경할 수 없도록 하고 관련 설정(최근 암호 기억)과 함께 시스템에 적용하여 패스워드 변경 전에 사용했던 패스워드를 재사용할 수 없도록 방지하는지 확인하기 위함

### 보안 위협

- 패스워드 변경 후 최소 사용 기간이 설정되지 않은 경우 사용자에게 익숙한 패스워드로 즉시 변동이 가능하여, 이를 재사용함으로써 원래 암호를 같은 날 다시 사용할 수 있음
- 패스워드 변경 정책에 따른 주기적인 패스워드 변경이 무의미해질 수 있으며, 이로 인해 조직의 계정 보안성을 낮출 수 있음

### 참고

- **최근 암호 기억:** 사용자가 현재 암호 또는 최근에 사용했던 암호와 동일한 새 암호를 만드는 것을 방지하는 설정, 예를 들어 값 1은 마지막 암호만 기억한다는 의미이며 값 5는 이전 암호 5개를 기억한다는 의미

---

### 점검대상 및 판단기준

### 대상

- SOLARIS, LINUX, AIX, HP-UX 등

### 판단기준

> 양호

- 패스워드 최소 사용기간이 설정되어 있는 경우

> 취약

- 패스워드 최소 사용기간이 설정되어 있지 않은 경우

### 조치방법

- 패스워드 정책 설정 파일을 수정하여 패스워드 최소 사용기간을 1일(1주)로 설정)

---

### 점검 및 조치 사례

### OS별 점검 파일 위치 및 점검 방법

> LINUX

- #cat /etc/login.defsPASS_MIN_DAYS 1

**위에 제시한 설정이 해당 파일에 적용되지 않은 경우 아래의 보안설정방법에 따라 설정을 변경함**

> LINUX

- Step 1) vi 편집기를 이용하여 "/etc/login.defs" 파일 열기Step 2) 아래와 같이 수정 또는 신규 삽입 (수정 전) PASS_MIN_DAYS (수정 후) PASS_MIN_DAYS (단위: 일)

================================================================

# **패스워드 최대 사용기간 설정**

### 취약점 개요

### 점검 내용

- 시스템 정책에 패스워드 최대(90일 이하) 사용기간 설정이 적용되어 있는지 점검

### 점검 목적

- 패스워드 최대 사용 기간 설정이 적용되어 있는지 점검하여 시스템 정책에서 사용자 계정의 장기간 패스워드 사용을 방지하고 있는지 확인하기 위함

### 보안 위협

- 패스워드 최대 사용기간을 설정하지 않은 경우 비인가자의 각종 공격(무작위 대입 공격, 사전 대입 공격 등)을 시도할 수 있는 기간 제한이 없으므로 공격자 입장에서는 장기적인 공격을 시행할 수 있어 시행한 기간에 비례하여 사용자 패스워드가 유출될 수 있는 확률이 증가함

---

### 점검대상 및 판단기준

### 대상

- SOLARIS, LINUX, AIX, HP-UX 등

### 판단기준

> 양호

- 패스워드 최대 사용기간이 90일 (12주) 이하로 설정되어 있는 경우

> 취약

- 패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있지 않는 경우

### 조치방법

- 패스워드 정책 설정 파일을 수정하여 패스워드 최대 사용기간을 90일(12주)로 설정

---

### 점검 및 조치 사례

### OS별 점검 파일 위치 및 점검 방법

> LINUX

- #cat /etc/login.defsPASS_MAX_DAYS 90

**위에 제시한 설정이 해당 파일에 적용되지 않은 경우 아래의 보안설정방법에 따라 설정을 변경**

LINUX

- Step 1) vi 편집기를 이용하여 "/etc/login.defs" 파일 열기Step 2) 아래와 같이 수정 또는 신규 삽입 (수정 전) PASS_MAX_DAYS 9999 (수정 후) PASS_MAX_DAYS 90 (단위: 일)

================================================================

# **패스워드 최소 길이 설정**

### 취약점 개요

### 점검 내용

- 시스템 정책에 패스워드 최소(8자 이상) 길이 설정이 적용되어 있는지 점검

### 점검 목적

- 패스워드 최소 길이 설정이 적용되어 있는지 점검하여 짧은(8자 미만) 패스워드 길이로 발생하는 취약점을 이용한 공격(무작위 대입 공격, 사전 대입 공격 등)에 대한 대비(사용자 패스워드 유출)가 되어 있는지 확인하기 위함

### 보안 위협

- 패스워드 최소 길이 설정이 적용되어 있지 않은 경우 비인가자의 각종 공격(무작위 대입 공격, 사전 대입 공격 등)에 취약하여 사용자 계정 패스워드 유출 우려가 있음

### 참고

- 공공기관인 경우 국가정보보안기본지침에 의해 패스워드를 9자리 이상의 길이로 설정해야 함

---

### 점검대상 및 판단기준

### 대상

- SOLARIS, LINUX, AIX, HP-UX 등

### 판단기준

> 양호

- 패스워드 최소 길이가 8자 이상으로 설정되어 있는 경우 (공공기관의 경우 9자리 이상)

> 취약

- 패스워드 최소 길이가 8자 미만으로 설정되어 있는 경우 (공공기관의 경우 9자리 미만)

### 조치방법

- 패스워드 정책 설정 파일을 수정하여 패스워드 최소 길이를 8자 이상으로 설정(공공기관의 경우 9자리 이상으로 설정)

---

### 점검 및 조치 사례

### OS별 점검 파일 위치 및 점검 방법

> LINUX

- #cat /etc/login.defsPASS_MIN_LEN 8

**위에 제시한 설정 파일이 해당 파일에 적용되지 않은 경우 아래의 보안설정방법에 따라 설정을 변경함**

> LINUX

- Step 1) vi 편집기를 이용하여 "/etc/login.defs"Step 2) 아래와 같이 수정 또는 신규 삽입 (수정 전) PASS_MIN_LEN 6 (수정 후) PASS_MIN_LEN 8 (or 9)

================================================================

# **root 계정 su 제한**

### 취약점 개요

### 점검 내용

- 시스템 사용자 계정 그룹 설정 파일(예 /etc/group)에 su 관련 그룹이 존재하는지 점검
- su 명령어가 su 관련 그룹에서만 허용되도록 설정되어 있는지 점검

### 점검 목적

- su 관련 그룹만 su 명령어 사용 권한이 부여되어 있는지 점검하여 su 그룹에 포함되지 않은 일반 사용자의 su 명령 사용을 원천적으로 차단하는지 확인하기 위함

### 보안 위협

- su 명령어를 모든 사용자가 사용하도록 설정되어 있는 경우 root 계정 권한을 얻기 위해 패스워드 무작위 대입 공격(Brute Force Affack)이나 패스워드 추측 공격(Password Guessing)을 시도하여 root 계정 패스워드가 유출될 위협이 있음

---

### 점검대상 및 판단기준

### 대상

- SOLARIS, LINUX, AIX, HP-UX 등

### 판단기준

> 양호

- su 명령어를 특정 그룹에 속한 사용자만 사용하도록 제한되어 있는 경우

> 취약

- su 명령어를 모든 사용자가 사용하도록 설정되어 있는 경우

### 조치방법

> 일반 사용자의 su 명령어 사용 제한

- Step 1) Group 생성(생성할 그룹 요청, 일반적으로 wheel 사용)
- Step 2) su 명령어 그룹을 su 명령어 허용할 그룹으로 변경
- Step 3) su 명령어 권한 변경(4750)
- Step 4) su 명령어 사용이 필요한 계정을 새로 생성한 그룹에 추가(추가할 계정 요청)

**LINUX의 경우, PAM(Pluggable Authentiation Module)을 이용한 설정 가능**

**PAM(Pluggable Authentication Module):** 사용자 인증하고 그 사용자의 서비스에 대한 액세스를 제어하는 모듈화 된 방법을 말하며, PAM은 관리자가 응용프로그램들의 사용자 인증 방법을 선택할 수 있도록 해줌

---

### 점검 및 조치 사례

### OS별 점검 파일 위치 및 점검 방법

> SOLARIS, LINUX, HP-UX, AIX

- Step 1) "wheel" 그룹 (su 명령어 사용 그룹) 및 그룹 내 구성원 존재 여부 확인) #cat /etc/group wheel:x:10:root, admin
- Step 2) wheel 그룹이 su 명령어를 사용할 수 있는지 설정 여부 확인
- Step 3) 파일 권한 확인 #ls -l /usr/bin/su -rwsr-x--- /usr/bin/su (파일 권한이 4750인 경우 양호)

> LINUX PAM 모듈 이용 시

- Step 1) "wheell" 그룹 (su 명령어 사용 그룹) 및 그룹 내 구성원 존재 여부 확인 #cat /etc/group wheel:x:10:root, admin=
- Step 2) 허용 그룹 (su 명령어 사용 그룹) 설정 여부 확인 #cat /etc/pam.d/su auth required /lib/security/pam_wheel.so debug group=wheel 또는, auth required /lib/security/$ISA/pam_wheel.so use_id

**위에 설정이 적용되지 않는 경우아래의 보안설정방법에 따라 설정을 변경함**

> SOLARIS, LINUX, HP-UX

- Step 1) wheel group 생성 (wheel 그룹이 존재하지 않는 경우) #groupadd wheel
- Step 2) su 명령어 그룹 변경 #chgrp wheel /usr/bin/su
- Step 3) su 명령어 사용권한 변경 #chmod 4750 /usr/bin/su
- Step 4) wheel 그룹에 su 명령 허용 계정 등록 #usermod -G wheel <user_name> 또는 직접 /etc/group 파일을 수정하여 필요한 계정 등록 wheel:x:10: -> wheel:x:10:root,admin

> LINUX PAM 모듈을 이용한 설정 방법

- Step 1) "/etc/pam.d/su" 파일을 아래와 같이 설정(주석 제거) auth sufficient /lib/security/pam_rootok.so auth required /lib/security/pam_wheel.so debug group=wheel 또는, auth sufficient /lib/security/$ISA/pam_rootok.so auth required /lib/security/$ISA/pam_wheel.so use_uid
- Step 2) wheel 그룹에 su 명령어를 사용할 사용자 추가 #usermod -G wheel <user_name> 또는, 직접 "/etc/group" 파일을 수정하여 필요한 계정 추가 wheel:x:10: -> wheel:x:10:root,admin

================================================================

# **root 계정 원격 접속 제한**

### 취약점 개요

### 점검 내용

- 시스템 정책에 root 계정의 터미널 접속 차단 설정이 적용되어 있는지 점검

### 점검 목적

- root 계정 원격 접속 차단 설정 여부를 점검하여 외부 비인가자의 root 계정 접근 시도를 원천적으로 차단하는지 확인하기 위함

### 보안 위협

- 각종 공격(무작위 대입 공격, 사전 대입 공격 등)을 통해 root 원격 접속 차단이 적용되지 않은 시스템의 root 계정 정보를 비인가자가 획득할 경우, 시스템 계정 정보 유출, 파일 및 디렉터리 변조 등의 행위 침해사고가 발생할 수 있음

### 참고

- **root 계정:** 여러 사용자가 사용하는 컴퓨터에서 전체적으로 관리할 수 있는 총괄 권한을 가진 유일한 특별 계정. 유닉스 시스템의 root는 시스템 관리자인 운용 관리자(Super User)로서 윈도우의 관리자(Administrator)에 해당하며, 사용자 계정을 생성하거나 소프트웨어를 설치하고, 환경 및 설정을 변경하거나 시스템의 동작을 감시 및 제어할 수 있다.
- **무작위 대입 공격(BruteForce Attack):** 특정한 암호를 풀기 위해 가능한 모든 값을 대입하는 공격 방법
- **사전 대입 공격(Dictionary Attack):** 사전에 있는 단어를 입력하여 암호를 알아내거나 암호를 해독하는 데 사용되는 컴퓨터 공격 방법

---

### 점검대상 및 판단기준

### 대상

- SOLARIS, LINUX, AIX, HP-UX 등

### 판단기준

> 양호

- 원격 터미널 서비스를 사용하지 않거나, 사용 시 root 직접 접속을 차단한 경우

> 취약

- 원격 터미널 서비스 사용 시 root 직접 접속을 허용한 경우

### 조치방법

- 원격 접속 시 root 계정으로 바로 접속할 수 없도록 설정파일 수정

---

### 점검 및 조치사례

### OS별 점검 파일 위치 및 점검 방법

> LINUX

- Step 1) "/etc/securetty" 파일에서 pts/0 ~ pts/x 설정 제거 또는, 주석 처리
- Step 2) "/etc/pam.d/login" 파일 수정 또는 신규 삽입 (수정 전) #auth requried /lib/security/pam_securetty (수정 후) auth requied /lib/security/pam_securetty

================================================================

# **사용자 shell 점검**

### 취약점 개요

### 점검 내용

- 로그인이 불필요한 계정(adm, sys, deamon 등)에 쉘 부여 여부 점검

### 점검 목적

- 로그인이 불필요한 계정에 쉘 설정을 제거하여, 로그인이 필요하지 않은 계정을 통한 시스템 명령어를 실행하지 못하게 하기 위함

### 보안 위협

- 로그인이 불필요한 계정은 일반적으로 OS 설치 시 기본적으로 생성되는 계정으로 쉘이 설정되어 있을 경우, 공격자는 기본 계정들은 통하여 중요 파일 유출이나 악성코드를 이용한 root 권한 획득 등의 공격을 할 수 있음.

### 참고

- 쉘(shell): 대화형 사용자 인터페이스로써, 운영체제(OS) 가장 외곽 계층에 존재하여 사용자의 명령어를 이해하고 실행함

---

### 점검대상 및 판단기준

### 대상

- SOLARIS, LINUX, AIX, HP-UX 등

### 판단기준

> 양호

- 로그인이 필요하지 않은 계정에 /bin/false(/sbin/nologin) 쉘이 부여되어 있는 경우

> 취약

- 로그인이 필요하지 않은 계정 /bin/false(/sbin/nologin) 쉘이 부여되지 않은 경우

### 조치방법

- 로그인이 필요하지 않은 계정에 대해 /bin/false(/sbin/nologin) 쉘 부여

---

### 점검 및 조치 사례

### OS별 점검 파일 위치 및 점검 방법

> SOLARIS, LINUX, AIX, HP-UX

- #cat /etc/passwd | egrep"^daemon|^bin|^sys|^adm|^listen|^nobody|^nobody4|^noaccess|^diag|^operator|^games|^gopher" | grep -v "admin"

![https://blog.kakaocdn.net/dn/pc1Eb/btqGqWjcYMo/xqfj6jJ7zBAlcoipBYtHE0/img.png](https://blog.kakaocdn.net/dn/pc1Eb/btqGqWjcYMo/xqfj6jJ7zBAlcoipBYtHE0/img.png)

**시스템에 불필요한 계정을 확인한 후 /bin/false(nologin) 쉘이 부여되어 있지 않은 경우 보안 설정 방법**

> SOLARIS, LINUX, AIX, HP-UX

- Step 1) vi 편집기를 이용하여 "/etc/passwd" 파일 열기
- Step 2) 로그인 쉘 부분인 계정 맨 마지막에 /bin/false(/sbin/nologin) 부여 및 변경 (수정 전) daemon:x:1:1::/:/sbin/ksh (수정 후) daemon:x:1:1::/:/bin/false 또는, daemon:x:1:1::/:/sbin/nologin

================================================================

# **계정이 존재하지 않는 GID 금지**

### 취약점 개요

### 점검 내용

- 그룹 (예 /etc/group) 설정 파일에 불필요한 그룹(계정이 존재하지 않고 시스템 관리나 운용에 사용되지 않는 그룹, 계정이 존재하고 시스템 관리나 운용에 사용되지 않는 그룹 등) 이 존재하는지 점검

### 점검 목적

- 시스템에 불필요한 그룹이 존재하는지 점검하여 불필요한 그룹의 소유권으로 설정되어 있는 파일의 노출에 의해 발생할 수 있는 위험에 대한 대비가 되어 있는지 확인하기 위함

### 보안 위협

- 시스템에 불필요한 그룹이 존재할 경우 해당 그룹 소유의 파일이 비인가자에게 노출될 수 있는 위험이 존재함

### 참고

- GID(Group Identification): 다수의 사용자가 특정 개체를 공유할 수 있게 연계시키는 특정 그룹의 이름으로 주로 계정처리 목적으로 사용되며, 한 사용자는 여러 개의 GID를 가질 수 있음.
- /etc/group 파일만으로 구성원이 없는 group 파일만으로 구성원이 없는 group이라 판단하기 힘들다. /etc/passwd와 /etc/group을 같이 확인하여 판단하기를 권고

---

### 점검대상 및 판단기준

### 대상

- SOLARIS, LINUX, AIX, HP-UX 등

### 판단기준

> 양호

- 시스템 관리나 운용에 불필요한 그룹이 삭제되어 있는 경우

> 취약

- 시스템 관리나 운용에 불필요한 그룹이 존재할 경우

### 조치방법

- 불필요한 그룹이 있을 경우 관리자와 검토하여 제거

---

### 점검 및 조치 사례

### OS별 점검 파일 위치 및 점검 방법

> SOLARIS, LINUX, AIX, HP-UX

- #cat /etc/group

![https://blog.kakaocdn.net/dn/cFcav4/btqGqbtVDcq/jnJ39noJKtJktArkR3xIq0/img.png](https://blog.kakaocdn.net/dn/cFcav4/btqGqbtVDcq/jnJ39noJKtJktArkR3xIq0/img.png)

> LINUX

- #cat /etc/gshadowgshadow 파일: "shadow" 파일에 사용자 계정의 암호가 저장되어 있는 것처럼 시스템 내 존재하는 그룹의 암호 정보 저장 파일로 그룹 관리자 및 구성원 설정 가능

**불필요한 그룹이 존재하는 경우 제거 방법**

- #groupdel <group_name> (구성원이 없거나, 더 이상 사용하지 않는 그룹명 삭제)

================================================================

# **PAM의 사용예**

1.  특정계정에 대해 telnet 접속은 막고, ftp접속만 허가하도록 해보자.

1) /etc/pam.d/login파일을 열어서 아래라인을 추가한다.

```
auth       required     /lib/security/[pam_listfile.so](https://sysops.tistory.com/pam_listfile.so) item=user sense=deny file=/etc/loginusers onerr=succeed
```

1. /etc/loginusers 파일을 만들고 telnet 접속을 막을 계정을 적는다.

```
# cat /etc/loginusers
song

=> song 이라는 계정은 텔넷은 사용할 수 없고 ftp만 사용가능하다.
```

1.  /etc/loginusers파일에 등록된 사용자만 로그인을 허용하도록 해보자

1) /etc/pam.d/login파일을 열어 아래라인을 추가한다.

```
auth       required     /lib/security/[pam_listfile.so](https://sysops.tistory.com/pam_listfile.so) item=user sense=allow file=/etc/loginusers onerr=fail
```

2) /etc/loginusers 파일을 만들고 접속하고자 하는 계정을 한줄에 하나씩 적는다.

1.  사용자 패스워드 길이 제한하기

1) 설명: 리눅스에서 패스워드 기본설정과 관련된 파일이 /etc/[login.defs이다.](https://sysops.tistory.com/login.defs%EC%9D%B4%EB%8B%A4.)

이 파일에서 패스워드의 길이는 최소 5자로 설정하고 있다. 이 파일에서 설정해도 되지만 PAM을 이용하여패스워드의 길이를 설정할 수 있다. 기본 설정파일은 /etc/pam.d/passwd이다.

2) 설정하기

ㄱ. /etc/pam.d/passwd파일의 기본설정상태

```
# cat /etc/pam.d/passwd

#%PAM-1.0

auth       required     /lib/security/pam_stack.so service=system-auth

account    required     /lib/security/pam_stack.so service=system-auth

password   required     /lib/security/pam_stack.so service=system-auth

=> 현재 패스워드관련 정책은 /etc/pam.d/system-auth의 설정을 따른다는 뜻이다.
```

=> 현재 패스워드관련 정책은 /etc/pam.d/system-auth의 설정을 따른다는 뜻이다.

ㄴ. 패스워드와 관련된 /etc/pam.d/passwd파일의 기본설정상태 확인

```
# cat /etc/pam.d/system-auth

#%PAM-1.0

# This file is auto-generated.

# User changes will be destroyed the next time authconfig is run.

auth        required      /lib/security/pam_env.so

auth        sufficient    /lib/security/pam_unix.so likeauth nullok

auth        required      /lib/security/pam_deny.so pam_deny.so

account     required      /lib/security/pam_unix.so

password    required      /lib/security/pam_cracklib.so) retry=3 type=

password    sufficient    /lib/security/pam_unix.so) nullok use_authtok md5 shadow

password    required      /lib/security/pam_deny.so

session     required      /lib/security/pam_limits.so)

session     required      /lib/security/pam_unix.so)
```

ㄷ. 패스워드 길이제한을 위한 /etc/pam.d/passwd 파일 수정: 내용중 3번째줄을 삭제하고 아래와

같이 3줄을 추가한다.

```
# cat /etc/pam.d/passwd

#%PAM-1.0

auth       required     /lib/security/pam_stack.so service=system-auth

account    required     /lib/security/pam_stack.so service=system-auth

#password   required    /lib/security/pam_stack.so service=system-auth

password   required     /lib/security/pam_cracklib.so retry=3 minlen=12 type=LINUX

password   sufficient   /lib/security/pam_unix.so) nullok use_authok md5 shadow

password   required     /lib/security/pam_deny.so
```

=> 현재 기존의 내용을 주석처리하였다. 새로이 설정한 내용은 패스워드를 /etc/pam.d/system-auth파일의 설정을 따르지 않고 새로운 모듈로 설정하였다.

ㄹ. /etc/pam.d/system-auth의 내용수정: 패스워드 관련된 부분을 /etc/pam.d/passwd에서 직접 관여하므로 이 파일에서 password관련 3개의 항목을 제거한다.

```
# cat /etc/pam.d/system-auth

#%PAM-1.0

# This file is auto-generated.

# User changes will be destroyed the next time authconfig is run.

auth        required      /lib/security/pam_env.so

auth        sufficient    /lib/security/pam_unix.so likeauth nullok

auth        required      /lib/security/pam_deny.so

account     required      /lib/security/pam_unix.so

session     required      /lib/security/pam_limits.so

session     required      /lib/security/pam_unix.so
```

### 테스트

```
# passwd

Changing password for user song.

Changing password for song

(current) UNIX password:

New LINUX password:                // LINUX라는 문구열이 보인다.

Retype new LINUX password:         // LINUX라는 문구열이 보인다.

Enter new UNIX password:

Retype new UNIX password:

passwd: all authentication tokens updated successfully

=> retry=3 으로 설정해서 3번물어본다.
```

 

================================================================

## root 계정 su 사용 제한 설정

일반 사용자로 공격자가 접속을 성공하였다면 다음으로 su 명령어를 통해 root 권한을 획득 할 수 있다. 실제로 root 계정은 원격 접속을 막고 일반 계정으로만 원격 접속이 가능하도록 보안 설정을 하는 곳이 많다. 이럴 때는 반드시 허가된 사용자 ID 로만 su 명령어를 통해 root 권한을 획득 할 수 있도록 해야한다.

이를 막기 위해 pam.wheel.so 라이브러리를 활용할 수 있다. 이는 root 권한을 얻을 수 있는 사용자를 **wheel**이라는 그룹으로 묶어 관리할 수 있도록 지원해주는 기능이다.

**1. pam 모듈 활성화하기**

pam.d경로에 su 설정 파일을 열고 빨간글씨 부분을 주석 처리하거나 없다면 추가한다.

```
# vi /etc/pam.d/su

#%PAM-1.0

auth            sufficient      /usr/lib64/security/pam_rootok.so

# Uncomment the following line to implicitly trust users in the "wheel" group.

#auth           sufficient      pam_wheel.so trust use_uid

# Uncomment the following line to require a user to be in the "wheel" group.

auth            required        /usr/lib64/security/pam_wheel.so debug group=wheel

auth            substack        system-auth

auth            include         postlogin

account         sufficient      pam_succeed_if.so uid = 0 use_uid quiet
```

**2. wheel 그룹에 su를 허가할 사용자를 추가한다.**

usermod -G wheel test2 명령어 또는 vi 편집 사용.

wheel group에 test, root 계정이 포함하도록 설정하였다.

```
# cat /etc/group | grep wheel

wheel:x:10:test,root
```

**3. su 파일 그룹 권한 변경**

su 파일의 접근 권한의 그룹을 변경한다.

```
# chgrp wheel /bin/su[root@localhost ~]# ls -al /bin/su-rwxr-xr-x. 1 root wheel 32128 Oct  1 02:46 /bin/su
```

그리고 root로 접속 시도하면 /var/log/secure 에 로그가 남게된다.

```
# cat /var/log/secure

Jan  2 10:53:51 localhost su: pam_wheel(su-l:auth): Access denied to 'test2' for 'root'
```

**4. 파일 권한 차단**

su 파일은 bin 디렉토리 밑에 존재한다. su 파일은 setuid가 적용되어 있다. setuid란 euid를 잠시 동안 root 권한으로 변경 시켜 이를 root가 아닌 다른 사용자도 사용할 수 있게 해주는 권한(?)이다. 즉, 일반 유저가 이 파일을 실행하면 종료될 때까지 root권한을 획득하여 파일을 실행시키는 것이다.

```
# ls -al /bin/su-rwsr-xr-x. 1 root root 32128 Oct  1 02:46 /bin/su
```

이를 **4750 퍼미션**으로 변경해보았다. root 유저와 같은 그룹에 있는 계정만 su 파일을 실행할 수 있도록 변경하였다.

```
# chmod 4750 /bin/su[root@localhost ~]# ls -al /bin/su-rwsr-x---. 1 root wheel 32128 Oct  1 02:46 /bin/su
```

================================================================