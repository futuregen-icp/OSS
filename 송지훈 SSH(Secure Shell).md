https://www.notion.so/songcloud/SSH-Secure-Shell-e4b3315f46314ebf9beec483c8bb9048

# SSH(Secure Shell)

SSH 키를 통한 리눅스 서버 SSH 접속

리눅스는 SSH(Secure Shell) 접속을 위해 다양한 인증 방법을 제공한다.

처음 설치 시 입력하는 계정과 비밀번호를 통해 접속하는 방법이 가장 기본적이다.

다만 이 경우 네트워크 상에 중요한 비밀번호가 노출될 수 있다는 문제점이 존재한다.

다른 방법은 **공개키(Public Key)**와 **개인키(Private Key)**를 생성해서 접속하는 방법이다.

이 방법은 비밀번호를 노출시키지 않고 안전하게 서버에 접속할 수 있는 방법이다.

공개키와 개인키 기반의 SSH 키로 리눅스 서버에 접속하는 방법을 알아보자.

기본적인 동작 방식은 다음과 같다.

1. 클라이언트에서 공개키와 개인키를 생성
2. 생성한 공개키를 서버에 전달
3. 서버 접속 시 클라이언트의 개인키로 로그인

**개인키는 절대 타인에게 노출되어서는 안 되는 키**이기 때문에 공개키를 서버에 전달한다.

공개키로 암호화된 것은 개인키로, 개인키로 암호화된 것은 공개키로 풀 수 있다.

**클라이언트에서 서버로 메시지가 전달**될 때는 다음과 같이 동작한다.

1. 클라이언트에서 개인키로 메시지를 암호화
2. 서버에서 공개키로 복호화

내가 생성한 개인키로 암호화한 메시지는 나의 공개키로만 풀 수 있다.

그렇기 때문에 내가 발행한 메시지라는 것을 증명하는 의미가 있다.

이 방식은 공인인증서 등에서 본인을 확인하는 용도로 활용된다.

반대로 **서버에서 클라이언트로 메시지가 전달**될 때는 다음과 같다.

1. 서버에서 공개키로 암호화
2. 클라이언트에서 개인키로 복호화

서버에서 전달되는 중요한 정보는 오직 개인키를 소지한 본인만이 해독할 수 있다.

이것으로 강력한 보안이 제공된다.

가장 먼저 필요한 작업은 클라이언트에서 공개키와 개인키를 생성하는 작업이다.

아래와 같이 ssh-keygen 명령어로 키 생성이 가능하다.

```jsx
ssh-keygen -t rsa -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa                                              ):
Created directory '/root/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rs                                              a.
Your public key has been saved in /root/.ssh/id_rsa.pu                                              b.
The key fingerprint is:
SHA256:YURmX8sjpXehdkJxDN8QsI4earVQydIX410iyEVUDqs roo                                              t@NPM
The key's randomart image is:
+---[RSA 4096]----+
|       .=. =/*B..|
|       + +oO #.* |
|        + O & * .|
|       . + O =   |
|        S E .    |
|         = o     |
|        o o      |
|       .         |
|                 |
+----[SHA256]-----+
```

1.먼저 생성된 키가 저장될 경로를 선택할 수 있다.

기본으로 설정된 홈의 .ssh 디렉터리를 사용하기 위해 그냥 **엔터**를 누르면 된다.

2.  키에 추가로 암호를 설정하는 passphrase 입력 과정이다.

  높은 보안성을 제공하는 방법이지만 입력하지 않아도 되기 때문에 그냥 엔터를 2번 누르면 된다.

```jsx

[root@NPM html]# ssh-copy-id -i ~/.ssh/id_rsa.pub [root@211.183.3.101](mailto:root@211.183.3.101)
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
[root@211.183.3.101](mailto:root@211.183.3.101)'s password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@211.183.3.101'"
and check to make sure that only the key(s) you wanted were adde
```

명령어의 username 부분은 실제 서버 접속 시 사용하는 계정을 입력해주면 된다.

처음에 접속을 계속할 것인지 물어보면 **yes**를 입력하면 된다.

다음으로 서버 주소에 입력한 **username의 비밀번호를 입력**해주면 키가 안전하게 복사된다.

마지막으로 아래 명령어로 SSH 접속을 시도해보면 비밀번호 입력 없이 연결이 되는 것을 확인할 수 있다.

```jsx
ssh root[@](mailto:username@192.168.1.15)211.183.3.101
```

이제 비밀번호 입력 없이 안전하고 편리하게 SSH 접속이 가능하다.
