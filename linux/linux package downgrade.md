## linux package downgrade



> docker package downgrade 
>
> yum 명령어를 이용



### 저장소에 저장된 버전 확인 

```
[root@gpuinstall ~]# yum list --showduplicates docker
Loaded plugins: product-id, search-disabled-repos, subscription-manager
Available Packages
docker.x86_64                                                                          0.11.1-19.el7                                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          0.11.1-22.el7                                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          1.1.2-13.el7                                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          1.2.0-1.8.el7                                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          1.3.2-4.el7                                                                                             rhel-7-server-extras-rpms
docker.x86_64                                                                          1.4.1-37.el7                                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          1.5.0-27.el7                                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          1.5.0-28.el7                                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          1.6.0-11.el7                                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          1.6.2-14.el7                                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          1.7.1-108.el7                                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          1.7.1-115.el7                                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          1.8.2-7.el7                                                                                             rhel-7-server-extras-rpms
docker.x86_64                                                                          1.8.2-8.el7                                                                                             rhel-7-server-extras-rpms
docker.x86_64                                                                          1.8.2-10.el7                                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          1.9.1-25.el7                                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          1.9.1-40.el7                                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          1.10.3-44.el7                                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          1.10.3-46.el7.10                                                                                        rhel-7-server-extras-rpms
docker.x86_64                                                                          1.10.3-46.el7.14                                                                                        rhel-7-server-extras-rpms
docker.x86_64                                                                          1.10.3-57.el7                                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.10.3-59.el7                                                                                         rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.5-14.el7                                                                                         rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.6-11.el7                                                                                         rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.6-16.el7                                                                                         rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.6-28.git1398f24.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.6-32.git88a4867.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.6-48.git0fdc778.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.6-55.gitc4618fb.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.6-61.git85d7426.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.6-68.gitec8512b.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.12.6-71.git3e8e77d.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-53.git774336d.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-58.git87f2fab.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-63.git94f4240.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-68.gitdded712.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-74.git6e3bb8e.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-75.git8633870.el7_5                                                                            rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-84.git07f3374.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-88.git07f3374.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-90.git07f3374.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-91.git07f3374.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-94.gitb2f74b2.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-96.gitb2f74b2.el7                                                                              rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-102.git7f2769b.el7                                                                             rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-103.git7f2769b.el7                                                                             rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-104.git4ef4b30.el7                                                                             rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-108.git4ef4b30.el7                                                                             rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-109.gitcccb291.el7_7                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-161.git64e9980.el7_8                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-162.git64e9980.el7_8                                                                           rhel-7-server-extras-rpms
docker.x86_64                                                                          2:1.13.1-203.git0be3e21.el7_9                                                                           rhel-7-server-extras-rpms

```



### yum을 이용항  downgrade 

```
[root@gpuinstall ~]#  yum downgrade docker-1.13.1-109.gitcccb291.el7_7.x86_64
Loaded plugins: product-id, search-disabled-repos, subscription-manager
Resolving Dependencies
--> Running transaction check
---> Package docker.x86_64 2:1.13.1-109.gitcccb291.el7_7 will be a downgrade
--> Processing Dependency: docker-client = 2:1.13.1-109.gitcccb291.el7_7 for package: 2:docker-1.13.1-109.gitcccb291.el7_7.x86_64
--> Processing Dependency: docker-common = 2:1.13.1-109.gitcccb291.el7_7 for package: 2:docker-1.13.1-109.gitcccb291.el7_7.x86_64
---> Package docker.x86_64 2:1.13.1-203.git0be3e21.el7_9 will be erased
--> Finished Dependency Resolution
Error: Package: 2:docker-1.13.1-109.gitcccb291.el7_7.x86_64 (rhel-7-server-extras-rpms)
           Requires: docker-common = 2:1.13.1-109.gitcccb291.el7_7
           Installed: 2:docker-common-1.13.1-203.git0be3e21.el7_9.x86_64 (@rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-203.git0be3e21.el7_9
           Available: docker-common-1.9.1-40.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 1.9.1-40.el7
           Available: docker-common-1.10.3-44.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 1.10.3-44.el7
           Available: docker-common-1.10.3-46.el7.10.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 1.10.3-46.el7.10
           Available: docker-common-1.10.3-46.el7.14.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 1.10.3-46.el7.14
           Available: docker-common-1.10.3-57.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 1.10.3-57.el7
           Available: 2:docker-common-1.10.3-59.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.10.3-59.el7
           Available: 2:docker-common-1.12.5-14.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.5-14.el7
           Available: 2:docker-common-1.12.6-11.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.6-11.el7
           Available: 2:docker-common-1.12.6-16.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.6-16.el7
           Available: 2:docker-common-1.12.6-28.git1398f24.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.6-28.git1398f24.el7
           Available: 2:docker-common-1.12.6-32.git88a4867.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.6-32.git88a4867.el7
           Available: 2:docker-common-1.12.6-48.git0fdc778.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.6-48.git0fdc778.el7
           Available: 2:docker-common-1.12.6-55.gitc4618fb.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.6-55.gitc4618fb.el7
           Available: 2:docker-common-1.12.6-61.git85d7426.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.6-61.git85d7426.el7
           Available: 2:docker-common-1.12.6-68.gitec8512b.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.6-68.gitec8512b.el7
           Available: 2:docker-common-1.12.6-71.git3e8e77d.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.12.6-71.git3e8e77d.el7
           Available: 2:docker-common-1.13.1-53.git774336d.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-53.git774336d.el7
           Available: 2:docker-common-1.13.1-58.git87f2fab.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-58.git87f2fab.el7
           Available: 2:docker-common-1.13.1-63.git94f4240.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-63.git94f4240.el7
           Available: 2:docker-common-1.13.1-68.gitdded712.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-68.gitdded712.el7
           Available: 2:docker-common-1.13.1-74.git6e3bb8e.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-74.git6e3bb8e.el7
           Available: 2:docker-common-1.13.1-75.git8633870.el7_5.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-75.git8633870.el7_5
           Available: 2:docker-common-1.13.1-84.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-84.git07f3374.el7
           Available: 2:docker-common-1.13.1-88.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-88.git07f3374.el7
           Available: 2:docker-common-1.13.1-90.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-90.git07f3374.el7
           Available: 2:docker-common-1.13.1-91.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-91.git07f3374.el7
           Available: 2:docker-common-1.13.1-94.gitb2f74b2.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-94.gitb2f74b2.el7
           Available: 2:docker-common-1.13.1-96.gitb2f74b2.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-96.gitb2f74b2.el7
           Available: 2:docker-common-1.13.1-102.git7f2769b.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-102.git7f2769b.el7
           Available: 2:docker-common-1.13.1-103.git7f2769b.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-103.git7f2769b.el7
           Available: 2:docker-common-1.13.1-104.git4ef4b30.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-104.git4ef4b30.el7
           Available: 2:docker-common-1.13.1-108.git4ef4b30.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-108.git4ef4b30.el7
           Available: 2:docker-common-1.13.1-109.gitcccb291.el7_7.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-109.gitcccb291.el7_7
           Available: 2:docker-common-1.13.1-161.git64e9980.el7_8.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-161.git64e9980.el7_8
           Available: 2:docker-common-1.13.1-162.git64e9980.el7_8.x86_64 (rhel-7-server-extras-rpms)
               docker-common = 2:1.13.1-162.git64e9980.el7_8
Error: Package: 2:docker-1.13.1-109.gitcccb291.el7_7.x86_64 (rhel-7-server-extras-rpms)
           Requires: docker-client = 2:1.13.1-109.gitcccb291.el7_7
           Installed: 2:docker-client-1.13.1-203.git0be3e21.el7_9.x86_64 (@rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-203.git0be3e21.el7_9
           Available: 2:docker-client-1.12.5-14.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.5-14.el7
           Available: 2:docker-client-1.12.6-11.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.6-11.el7
           Available: 2:docker-client-1.12.6-16.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.6-16.el7
           Available: 2:docker-client-1.12.6-28.git1398f24.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.6-28.git1398f24.el7
           Available: 2:docker-client-1.12.6-32.git88a4867.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.6-32.git88a4867.el7
           Available: 2:docker-client-1.12.6-48.git0fdc778.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.6-48.git0fdc778.el7
           Available: 2:docker-client-1.12.6-55.gitc4618fb.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.6-55.gitc4618fb.el7
           Available: 2:docker-client-1.12.6-61.git85d7426.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.6-61.git85d7426.el7
           Available: 2:docker-client-1.12.6-68.gitec8512b.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.6-68.gitec8512b.el7
           Available: 2:docker-client-1.12.6-71.git3e8e77d.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.12.6-71.git3e8e77d.el7
           Available: 2:docker-client-1.13.1-53.git774336d.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-53.git774336d.el7
           Available: 2:docker-client-1.13.1-58.git87f2fab.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-58.git87f2fab.el7
           Available: 2:docker-client-1.13.1-63.git94f4240.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-63.git94f4240.el7
           Available: 2:docker-client-1.13.1-68.gitdded712.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-68.gitdded712.el7
           Available: 2:docker-client-1.13.1-74.git6e3bb8e.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-74.git6e3bb8e.el7
           Available: 2:docker-client-1.13.1-75.git8633870.el7_5.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-75.git8633870.el7_5
           Available: 2:docker-client-1.13.1-84.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-84.git07f3374.el7
           Available: 2:docker-client-1.13.1-88.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-88.git07f3374.el7
           Available: 2:docker-client-1.13.1-90.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-90.git07f3374.el7
           Available: 2:docker-client-1.13.1-91.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-91.git07f3374.el7
           Available: 2:docker-client-1.13.1-94.gitb2f74b2.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-94.gitb2f74b2.el7
           Available: 2:docker-client-1.13.1-96.gitb2f74b2.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-96.gitb2f74b2.el7
           Available: 2:docker-client-1.13.1-102.git7f2769b.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-102.git7f2769b.el7
           Available: 2:docker-client-1.13.1-103.git7f2769b.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-103.git7f2769b.el7
           Available: 2:docker-client-1.13.1-104.git4ef4b30.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-104.git4ef4b30.el7
           Available: 2:docker-client-1.13.1-108.git4ef4b30.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-108.git4ef4b30.el7
           Available: 2:docker-client-1.13.1-109.gitcccb291.el7_7.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-109.gitcccb291.el7_7
           Available: 2:docker-client-1.13.1-161.git64e9980.el7_8.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-161.git64e9980.el7_8
           Available: 2:docker-client-1.13.1-162.git64e9980.el7_8.x86_64 (rhel-7-server-extras-rpms)
               docker-client = 2:1.13.1-162.git64e9980.el7_8
```

> docker  downgrade를 위해  docker-common, docker-client 두 패키지도 downgrade 가 필요함 



```
 yum downgrade Package: 2:docker-1.13.1-109.gitcccb291.el7_7.x86_64   2:docker-client-1.13.1-109.gitcccb291.el7_7.x86_64 2:docker-common-1.13.1-109.gitcccb291.el7_7.x86_64 
Loaded plugins: product-id, search-disabled-repos, subscription-manager
No package Package: available.
Resolving Dependencies
--> Running transaction check
---> Package docker.x86_64 2:1.13.1-109.gitcccb291.el7_7 will be a downgrade
---> Package docker.x86_64 2:1.13.1-203.git0be3e21.el7_9 will be erased
---> Package docker-client.x86_64 2:1.13.1-109.gitcccb291.el7_7 will be a downgrade
---> Package docker-client.x86_64 2:1.13.1-203.git0be3e21.el7_9 will be erased
---> Package docker-common.x86_64 2:1.13.1-109.gitcccb291.el7_7 will be a downgrade
--> Processing Dependency: docker-rhel-push-plugin = 2:1.13.1-109.gitcccb291.el7_7 for package: 2:docker-common-1.13.1-109.gitcccb291.el7_7.x86_64
---> Package docker-common.x86_64 2:1.13.1-203.git0be3e21.el7_9 will be erased
--> Finished Dependency Resolution
Error: Package: 2:docker-common-1.13.1-109.gitcccb291.el7_7.x86_64 (rhel-7-server-extras-rpms)
           Requires: docker-rhel-push-plugin = 2:1.13.1-109.gitcccb291.el7_7
           Installed: 2:docker-rhel-push-plugin-1.13.1-203.git0be3e21.el7_9.x86_64 (@rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-203.git0be3e21.el7_9
           Available: docker-rhel-push-plugin-1.10.3-22.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 1.10.3-22.el7
           Available: docker-rhel-push-plugin-1.10.3-44.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 1.10.3-44.el7
           Available: docker-rhel-push-plugin-1.10.3-46.el7.10.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 1.10.3-46.el7.10
           Available: docker-rhel-push-plugin-1.10.3-46.el7.14.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 1.10.3-46.el7.14
           Available: docker-rhel-push-plugin-1.10.3-57.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 1.10.3-57.el7
           Available: 2:docker-rhel-push-plugin-1.10.3-59.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.10.3-59.el7
           Available: 2:docker-rhel-push-plugin-1.12.5-14.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.5-14.el7
           Available: 2:docker-rhel-push-plugin-1.12.6-11.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.6-11.el7
           Available: 2:docker-rhel-push-plugin-1.12.6-16.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.6-16.el7
           Available: 2:docker-rhel-push-plugin-1.12.6-28.git1398f24.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.6-28.git1398f24.el7
           Available: 2:docker-rhel-push-plugin-1.12.6-32.git88a4867.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.6-32.git88a4867.el7
           Available: 2:docker-rhel-push-plugin-1.12.6-48.git0fdc778.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.6-48.git0fdc778.el7
           Available: 2:docker-rhel-push-plugin-1.12.6-55.gitc4618fb.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.6-55.gitc4618fb.el7
           Available: 2:docker-rhel-push-plugin-1.12.6-61.git85d7426.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.6-61.git85d7426.el7
           Available: 2:docker-rhel-push-plugin-1.12.6-68.gitec8512b.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.6-68.gitec8512b.el7
           Available: 2:docker-rhel-push-plugin-1.12.6-71.git3e8e77d.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.12.6-71.git3e8e77d.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-53.git774336d.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-53.git774336d.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-58.git87f2fab.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-58.git87f2fab.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-63.git94f4240.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-63.git94f4240.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-68.gitdded712.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-68.gitdded712.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-74.git6e3bb8e.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-74.git6e3bb8e.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-75.git8633870.el7_5.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-75.git8633870.el7_5
           Available: 2:docker-rhel-push-plugin-1.13.1-84.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-84.git07f3374.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-88.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-88.git07f3374.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-90.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-90.git07f3374.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-91.git07f3374.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-91.git07f3374.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-94.gitb2f74b2.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-94.gitb2f74b2.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-96.gitb2f74b2.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-96.gitb2f74b2.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-102.git7f2769b.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-102.git7f2769b.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-103.git7f2769b.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-103.git7f2769b.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-104.git4ef4b30.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-104.git4ef4b30.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-108.git4ef4b30.el7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-108.git4ef4b30.el7
           Available: 2:docker-rhel-push-plugin-1.13.1-109.gitcccb291.el7_7.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-109.gitcccb291.el7_7
           Available: 2:docker-rhel-push-plugin-1.13.1-161.git64e9980.el7_8.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-161.git64e9980.el7_8
           Available: 2:docker-rhel-push-plugin-1.13.1-162.git64e9980.el7_8.x86_64 (rhel-7-server-extras-rpms)
               docker-rhel-push-plugin = 2:1.13.1-162.git64e9980.el7_8
```

>  docker,  docker-common, docker-client  downgrade 시 
>   docker-common에서 docker-rhel-push-plugin에 의해 의존성이 발생하는 부분으로 확인 



```
[root@gpuinstall ~]#  yum downgrade 2:docker-1.13.1-109.gitcccb291.el7_7.x86_64 2:docker-client-1.13.1-109.gitcccb291.el7_7.x86_64 2:docker-common-1.13.1-109.gitcccb291.el7_7.x86_64 2:docker-rhel-push-plugin-1.13.1-109.gitcccb291.el7_7.x86_64
Loaded plugins: product-id, search-disabled-repos, subscription-manager
No package Package: available.
Resolving Dependencies
--> Running transaction check
---> Package docker.x86_64 2:1.13.1-109.gitcccb291.el7_7 will be a downgrade
---> Package docker.x86_64 2:1.13.1-203.git0be3e21.el7_9 will be erased
---> Package docker-client.x86_64 2:1.13.1-109.gitcccb291.el7_7 will be a downgrade
---> Package docker-client.x86_64 2:1.13.1-203.git0be3e21.el7_9 will be erased
---> Package docker-common.x86_64 2:1.13.1-109.gitcccb291.el7_7 will be a downgrade
---> Package docker-common.x86_64 2:1.13.1-203.git0be3e21.el7_9 will be erased
---> Package docker-rhel-push-plugin.x86_64 2:1.13.1-109.gitcccb291.el7_7 will be a downgrade
---> Package docker-rhel-push-plugin.x86_64 2:1.13.1-203.git0be3e21.el7_9 will be erased
--> Finished Dependency Resolution

Dependencies Resolved

========================================================================================================================================================================================================================
 Package                                               Arch                                 Version                                                       Repository                                               Size
========================================================================================================================================================================================================================
Downgrading:
 docker                                                x86_64                               2:1.13.1-109.gitcccb291.el7_7                                 rhel-7-server-extras-rpms                                18 M
 docker-client                                         x86_64                               2:1.13.1-109.gitcccb291.el7_7                                 rhel-7-server-extras-rpms                               3.9 M
 docker-common                                         x86_64                               2:1.13.1-109.gitcccb291.el7_7                                 rhel-7-server-extras-rpms                                98 k
 docker-rhel-push-plugin                               x86_64                               2:1.13.1-109.gitcccb291.el7_7                                 rhel-7-server-extras-rpms                               2.0 M

Transaction Summary
========================================================================================================================================================================================================================
Downgrade  4 Packages

Total download size: 24 M
Is this ok [y/d/N]: y
Downloading packages:
(1/4): docker-client-1.13.1-109.gitcccb291.el7_7.x86_64.rpm                                                                                                                                      | 3.9 MB  00:00:01
(2/4): docker-1.13.1-109.gitcccb291.el7_7.x86_64.rpm                                                                                                                                             |  18 MB  00:00:01
(3/4): docker-rhel-push-plugin-1.13.1-109.gitcccb291.el7_7.x86_64.rpm                                                                                                                            | 2.0 MB  00:00:00
(4/4): docker-common-1.13.1-109.gitcccb291.el7_7.x86_64.rpm                                                                                                                                      |  98 kB  00:00:00
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                                                    13 MB/s |  24 MB  00:00:01
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : 2:docker-rhel-push-plugin-1.13.1-109.gitcccb291.el7_7.x86_64                                                                                                                                         1/8
  Installing : 2:docker-common-1.13.1-109.gitcccb291.el7_7.x86_64                                                                                                                                                   2/8
  Installing : 2:docker-client-1.13.1-109.gitcccb291.el7_7.x86_64                                                                                                                                                   3/8
  Installing : 2:docker-1.13.1-109.gitcccb291.el7_7.x86_64                                                                                                                                                          4/8
  Cleanup    : 2:docker-1.13.1-203.git0be3e21.el7_9.x86_64                                                                                                                                                          5/8
  Cleanup    : 2:docker-client-1.13.1-203.git0be3e21.el7_9.x86_64                                                                                                                                                   6/8
  Cleanup    : 2:docker-common-1.13.1-203.git0be3e21.el7_9.x86_64                                                                                                                                                   7/8
  Cleanup    : 2:docker-rhel-push-plugin-1.13.1-203.git0be3e21.el7_9.x86_64                                                                                                                                         8/8
  Verifying  : 2:docker-common-1.13.1-109.gitcccb291.el7_7.x86_64                                                                                                                                                   1/8
  Verifying  : 2:docker-rhel-push-plugin-1.13.1-109.gitcccb291.el7_7.x86_64                                                                                                                                         2/8
  Verifying  : 2:docker-client-1.13.1-109.gitcccb291.el7_7.x86_64                                                                                                                                                   3/8
  Verifying  : 2:docker-1.13.1-109.gitcccb291.el7_7.x86_64                                                                                                                                                          4/8
  Verifying  : 2:docker-1.13.1-203.git0be3e21.el7_9.x86_64                                                                                                                                                          5/8
  Verifying  : 2:docker-common-1.13.1-203.git0be3e21.el7_9.x86_64                                                                                                                                                   6/8
  Verifying  : 2:docker-rhel-push-plugin-1.13.1-203.git0be3e21.el7_9.x86_64                                                                                                                                         7/8
  Verifying  : 2:docker-client-1.13.1-203.git0be3e21.el7_9.x86_64                                                                                                                                                   8/8

Removed:
  docker.x86_64 2:1.13.1-203.git0be3e21.el7_9   docker-client.x86_64 2:1.13.1-203.git0be3e21.el7_9   docker-common.x86_64 2:1.13.1-203.git0be3e21.el7_9   docker-rhel-push-plugin.x86_64 2:1.13.1-203.git0be3e21.el7_9

Installed:
  docker.x86_64 2:1.13.1-109.gitcccb291.el7_7   docker-client.x86_64 2:1.13.1-109.gitcccb291.el7_7   docker-common.x86_64 2:1.13.1-109.gitcccb291.el7_7   docker-rhel-push-plugin.x86_64 2:1.13.1-109.gitcccb291.el7_7

Complete!

```

