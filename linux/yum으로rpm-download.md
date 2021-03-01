## yum 으로 rpm Dounload 받기



### 필수 패키지 설치 

```
yum -y install yum-utils.noarch
Loaded plugins: product-id, search-disabled-repos, subscription-manager
Resolving Dependencies
--> Running transaction check
---> Package yum-utils.noarch 0:1.1.31-54.el7_8 will be installed
--> Processing Dependency: python-kitchen for package: yum-utils-1.1.31-54.el7_8.noarch
--> Running transaction check
---> Package python-kitchen.noarch 0:1.1.1-5.el7 will be installed
--> Processing Dependency: python-chardet for package: python-kitchen-1.1.1-5.el7.noarch
--> Running transaction check
---> Package python2-chardet.noarch 0:3.0.4-7.el7ost will be installed
--> Finished Dependency Resolution

Dependencies Resolved

========================================================================================================================================================================================================================
 Package                                            Arch                                      Version                                              Repository                                                      Size
========================================================================================================================================================================================================================
Installing:
 yum-utils                                          noarch                                    1.1.31-54.el7_8                                      rhel-7-server-rpms                                             122 k
Installing for dependencies:
 python-kitchen                                     noarch                                    1.1.1-5.el7                                          rhel-7-server-rpms                                             266 k
 python2-chardet                                    noarch                                    3.0.4-7.el7ost                                       rhel-7-server-ose-3.11-rpms                                    186 k

Transaction Summary
========================================================================================================================================================================================================================
Install  1 Package (+2 Dependent packages)

Total download size: 574 k
Installed size: 2.6 M
Downloading packages:
(1/3): yum-utils-1.1.31-54.el7_8.noarch.rpm                                                                                                                                                      | 122 kB  00:00:00
(2/3): python2-chardet-3.0.4-7.el7ost.noarch.rpm                                                                                                                                                 | 186 kB  00:00:02
(3/3): python-kitchen-1.1.1-5.el7.noarch.rpm                                                                                                                                                     | 266 kB  00:00:02
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                                                   215 kB/s | 574 kB  00:00:02
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : python2-chardet-3.0.4-7.el7ost.noarch                                                                                                                                                                1/3
  Installing : python-kitchen-1.1.1-5.el7.noarch                                                                                                                                                                    2/3
  Installing : yum-utils-1.1.31-54.el7_8.noarch                                                                                                                                                                     3/3
  Verifying  : python2-chardet-3.0.4-7.el7ost.noarch                                                                                                                                                                1/3
  Verifying  : python-kitchen-1.1.1-5.el7.noarch                                                                                                                                                                    2/3
  Verifying  : yum-utils-1.1.31-54.el7_8.noarch                                                                                                                                                                     3/3

Installed:
  yum-utils.noarch 0:1.1.31-54.el7_8

Dependency Installed:
  python-kitchen.noarch 0:1.1.1-5.el7                                                                      python2-chardet.noarch 0:3.0.4-7.el7ost

Complete!

```

### rpm 다운로드

```
yum list --showduplicates docker 
yum downgrade docker-1.13.1-109.gitcccb291.el7_7.x86_64



yumdownloader  2:docker-1.13.1-109.gitcccb291.el7_7.x86_64   2:docker-client-1.13.1-109.gitcccb291.el7_7.x86_64 2:docker-common-1.13.1-109.gitcccb291.el7_7.x86_64  2:docker-client-1.13.1-109.gitcccb291.el7_7.x86_64  2:docker-rhel-push-plugin-1.13.1-109.gitcccb291.el7_7.x86_64
 
[root@gpuinstall rhel-7-server-ansible-2.9-rpms]# ll
합계 24256
-rw-r--r--. 1 root root     2139 11월  6  2019 078bdcd5-96a5-45d2-b838-9414c0bc1a84
-rw-r--r--. 1 root root    19661  1월 20 03:11 38df02720c52b73fe7b83ea70ab494a6fb74c9dbf126264a4204209a4fcd1ce7-primary.sqlite.bz2
-rw-r--r--. 1 root root     5266  1월 20 03:11 968107cc342aa0fed229ceab0a8b14bb9b0ee6bf399075c37492f779dcd656dc-updateinfo.xml.gz
-rw-r--r--. 1 root root      124  1월 20 03:11 a27718cc28ec6d71432e0ef3e6da544b7f9d93f6bb7d0a55aacd592d03144b70-comps.xml
-rw-r--r--. 1 root root        0  1월 29 08:31 cachecookie
-rw-r--r--. 1 root root 18523108  2월  2  2020 docker-1.13.1-109.gitcccb291.el7_7.x86_64.rpm
-rw-r--r--. 1 root root  4081896  2월  2  2020 docker-client-1.13.1-109.gitcccb291.el7_7.x86_64.rpm
-rw-r--r--. 1 root root   100428  2월  2  2020 docker-common-1.13.1-109.gitcccb291.el7_7.x86_64.rpm
-rw-r--r--. 1 root root  2063396  2월  2  2020 docker-rhel-push-plugin-1.13.1-109.gitcccb291.el7_7.x86_64.rpm
drwxr-xr-x. 2 root root       31  1월 29 08:32 gen
drwxr-xr-x. 2 root root        6  1월 29 08:31 packages

```

