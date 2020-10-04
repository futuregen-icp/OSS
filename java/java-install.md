# java binary install

##  java install

### java install directory create

```
mkdir /ICS/java
```

### java archive file extract and move



Java 8 install 

```
cd /ICS/src
tar xvfpz jdk-8u261-linux-x64.tar.gz
mv jdk1.8.0_261 /ICS/java/jdk1.8.0_261
```



java 11 install

```
cd /ICS/src
tar zxvfp jdk-11.0.8_linux-x64_bin.tar.gz
mv jdk-11.0.8 /ICS/java/jdk-11.0.8
```



## default java select

### alternatives 설정 확인

```
alternatives --config java

1 개의 프로그램이 'java'를 제공합니다.

  선택    명령
-----------------------------------------------
*+ 1           java-1.8.0-openjdk.x86_64 (/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.265.b01-0.el8_2.x86_64/jre/bin/java) 
```



### alternatives 설정 추가 

```
alternatives --install /usr/bin/java java /ICS/java/jdk1.8.0_261/bin/java 2
alternatives --install /usr/bin/java java /ICS/java/jdk-11.0.8/bin/java 3
```



### alternatives 설정

```
[root@oss src]# alternatives --config java

3 개의 프로그램이 'java'를 제공합니다.

  선택    명령
-----------------------------------------------
*+ 1           java-1.8.0-openjdk.x86_64 (/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.265.b01-0.el8_2.x86_64/jre/bin/java)
   2           /ICS/java/jdk1.8.0_261/bin/java
   3           /ICS/java/jdk-11.0.8/bin/java

현재 선택[+]을 유지하려면 엔터키를 누르고, 아니면 선택 번호를 입력하십시오:3

[root@oss src]# alternatives --config java

3 개의 프로그램이 'java'를 제공합니다.

  선택    명령
-----------------------------------------------
*  1           java-1.8.0-openjdk.x86_64 (/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.265.b01-0.el8_2.x86_64/jre/bin/java)
   2           /ICS/java/jdk1.8.0_261/bin/java
 + 3           /ICS/java/jdk-11.0.8/bin/java
```



### java version

```
[root@oss src]# java --version
java 11.0.8 2020-07-14 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.8+10-LTS)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.8+10-LTS, mixed mode)
```



## javac  설정

```
[root@oss src]# alternatives --install /usr/bin/javac javac /ICS/java/jdk-11.0.8/bin/javac 2
[root@oss src]# alternatives --install /usr/bin/javac javac /ICS/java/jdk1.8.0_261/bin/javac 1
[root@oss src]# alternatives --config javac

2 개의 프로그램이 'javac'를 제공합니다.

  선택    명령
-----------------------------------------------
*+ 1           /ICS/java/jdk-11.0.8/bin/javac
   2           /ICS/java/jdk1.8.0_261/bin/javac
   
[root@oss src]# javac --version
javac 11.0.8
```

