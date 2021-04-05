

# Jenkins install 



## requiremnet

### OS 

```
yum update -y
yum install procps net-tools psmisc bind-utils wget
```



### java install

```
 yum install java-11*
```



### useradd

```
useradd jenkins
```



### Jenkins download

```
mkdir /opt/jenkins
chown jenkins.jenkins /opt/jenkins
su - jenkins
cd /opt/jenkins
wget https://get.jenkins.io/war-stable/2.277.1/jenkins.war
```



## install

### jenkins start

```
java -jar ./jenkins.war --httpPort=8080 \
                        --httpListenAddress=0.0.0.0  \
                        --httpsPort=8443 \
                        --httpsListenAddress=0.0.0.0  \
                        --ajp13Port=8009 \
                        --ajp13ListenAddress=127.0.0.1 \
#                        --prefix=jenkins \
#                        -Xmx3G -Xms3G -server -d64 -XX:+UseParallelGC \
#                        -XX:ParallelGCThreads=2 -XX:MaxPermSize=1G
```



