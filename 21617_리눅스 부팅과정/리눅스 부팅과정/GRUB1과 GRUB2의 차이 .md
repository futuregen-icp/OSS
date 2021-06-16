# GRUB1과 GRUB2의 차이

**1) /boot/grub2/grub.cfg**

GRUB2 설정 저장 파일은 menu.lst 파일을 사용하지 않고 grub.cfg 파일을 사용하며 이 파일은 에디터로 직접 수정하지 않는다.

에디터로도 수정 가능하나 수정하였을때 grub2에서 제공하는 grub2-mkconfig로 이파일을 생성하는데 문제가 발생할 수 있으며

커널이 업데이트될 때 이 파일을 업데이트할 때도 문제가 발생할 수 있다.

GRUB2버전에서는 /etc/default/grub파일과 /etc/grub.d/에 있는 파일을 수정한 후 grub2-mkconfig 명령을 이용하여 설정파일을 생성하거나 업데이트해야 한다.

**2) 파티션 명명 및 번호 변경**

하드 디스크 표기에는 변화가 없지만 GRUB1에서는 파티션을 지정해 줄 때 숫자 0부터 시작하였으나 GRUB2부터는 숫자 1부터 파티션 번호를 명시한다.

주 파티션의 수가 몇 개가 되었든간에 확장파티션으로부터 생성된 노리파티션은 숫자 5부터 시작된다.

또한 파티션을 나타낼 때에 GRUB1에서는 숫자만 지정해 주었으나 GRUB2부터는 msdos에 숫자를 붙여서 사용한다.

Ex) hd0,msdos1 -> 첫번째 하드 디스크에 있는 첫번째 파티션을 의미

hd1,msdos5 -> 두번째 하드디스크의 첫번째 논리 파티션을 의미

하지만 msdos를 붙이지않고 GRUB1의 방식대로 숫자로만 파티션을 표시하는 것도 허용한다.

**3) root 지정방법 변경**

GRUB1에서는 OS가 설치되어 있는 드라이브와 파티션을 지정해 줄 때 root(hd0,0)로 설정해 주었으나 GRUB2에서는 set root=(hd0,msdos1)로 변경되었다.

부트 메뉴에서 수동으로 하드 디스크와 파티션을 지정해 줄 때 set root= 로 사용해야 하며 set root= 까지 입력한 후 TAB 키를 사용하면 GRUB2에서

지원하는 하드 디스크 드라이브와 파티션 목록을 보여주므로 쉽게 설정할 수 있다.

**4) 커널 이미지 설정 옵션**

GRUB1에서는 커널 이미지를 명시할 때 kernel 옵션을 사용했지만 GRUB2부터는 linux 옵션을 사용함에 주의해야 한다.

linux (hd0,5)/boot/vmlinuz 형태로 지정해야한다.

---

**GRUB2 설치 경로 및 파일**

GRUB2 패키지를 설치하면 크게 /boot/grub2 와 /etc/default 경로에 파일들이 설치된다.

**1) /boot/grub2 : GRUB1의 menu.lst에 해당되는 주 설정 파일이 위치**

custom.cfg : 사용자 정의 설정 파일

grub.cfg : /etc/grub.d 스크립트, /etc/default/grub를 이용하여 생성되는 설정 파일

fonts : 글꼴 위치 경로

themes : GRUB 배경화면을 위한 테마

**2) /etc/grub.d/ : grub.cfg 파일에 부트 엔트리를 만들어주는 스크립트 파일을 포함**

00_header : /etc/default/grub에 있는 설정을 불러온다

10_linux : 설치된 리눅스 운영체제에 대한 메뉴 엔트리를 불러온다

30_os-prober : 타 운영체제를 탐색하여 부트 메뉴에 추가해 주는 역할

40_custom : 사용자 정의로 부트 메뉴에 추가해 주는 템플릿 역할

90_persistent : 사용자가  grub.cfg 파일 일부를 직접 수정할 수 있게 한다

**3) /etc/default/grub : /etc/grub.d에 있는 스크립트들에서 사용할 옵션 설정을 포함**

**4) /usr/bin**

grub2-menulst2cfg : GRUB1의 menu.lst 파일을 grub.cfg 파일로 업데이트 해 주는 실행 파일

grub2-customizer : GRUB2 설정 그래픽 인터페이스

**5) /usr/sbin**

grub2-install : grub2를 하드 디스크에 설치

grub2-mkconfig : /boot/grub2/grub.cfg 설정 파일을 생성해 주는 도구

**6) 변경 사항**

GRUB2에서는 주설정 파일이 /boot/grub/menu.lst 파일에서 /boot/grub2/grub.cfg 파일로 변경되었다.

GRUB2를 수정할 시 설정파일인 /boot/grub2/grub.cfg 를 직접 수정하는 것이 아니라

/etc/grub.d 디렉토리에 위치하는 스크립트와 /etc/default/grub 파일을 수정하여 grub2-mkconfig 명령에 의해

/boot/grub2/grub.cfg를 생성해주거나 업데이트 하는 것이다.

---

**grub 파일**

- /etc/default/grub 파일에는 부트 테마에 관련된 옵션만 있을 뿐 부트에 관련된 옵션이 포함되어 있지 않은데

# grep "export GRUB_DEFAULT" -A50 /usr/sbin/grub2-mkconfig | grep GRUB_

명령을 실행하면 grub2에서 지원하는 모든 옵션 목록을 확인할 수 있다.

**옵션**

GRUB_DEFAULT = "숫자값"

- 시스템을 재부팅 하였을 때 부트로 되어질 기본 메뉴 엔트리를 설정하는 옵션이다. 숫자값으로 지정하는데 첫번째 부트 엔트리 번호는 0부터 시작한다.

숫자외에 GRUB1의 title 옵션처럼 큰 따옴표를 이용하여 메뉴 엔트리명을 지정해 줄 수도 있다.

GRUB_SAVEDEFAULT = "true / false"

- true 값은 다음 부트시에 기본 부트 엔트리로써 부트 메뉴에서 마지막으로 선택된 운영체제가 자동으로 선택된다.

GRUB_HIDDEN_TIMEOUT = "초"

- 부트시 부트 메뉴를 숨기거나 건너뛸 수 있도록 하는 옵션으로 주어진 시간 동안 ESC키 입력이 있으면 메뉴를 보여준다.

해당 옵션은 GRUB_HIDDEN_TIMEOUT_QUIET 옵션과 함께 사용한다.

GRUB_HIDDEN_TIMEOUT_QUIET= "false"

- false 값으로 설정되어 있으면 GRUB_HIDDEN_TIMEOUT 옵션이 켜 있을 때 카운트다운 타이머가 검은화면 바탕으로 나타난다.

GRUB_TIMEOUT= "초"

- 부트 메뉴를 보여 줄 시간으로 이 시간이 경과되면 기본 부트 엔트리로 부팅이 시작된다. 다른 부트 엔트리를 선택하여 부팅하고자 한다면

주어진 시간내에 아무키나 눌러 해당 부트 엔트리를 선택하면 된다. -1  값은 부트 엔트리를 수동으로 선택하도록 할 때 사용한다.

GRUB_CMDLINE_LINUX= "string"

- 커널에 전달하고자 하는 파라미터를 지정할 때 사용하는 옵션

GRUB_CMDLINE_LINUX_DEFAULT= "string"

- 커널에 전달할 기본 파라미터를 설정

GRUB_GFXMODE= "1280x1024x24"

- GRUB 부트화면의 해상도를 지정