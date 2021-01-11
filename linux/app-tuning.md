# kafka



## File Descriptor Limits

Kafka는 많은 로그 세그먼트 파일 및 네트워크 연결에서 작동하므로 브로커가 많은 파티션을 호스팅하는 경우 프로덕션 배포의 경우 설정을 늘려야 할 수 있습니다. 예를 들어, Kafka 브로커는 로그 세그먼트 파일을 추적하기 위해 적어도 다음 수의 파일 설명자가 필요합니다.Maximum Process File Descriptors

```
(number of partitions)*(partition size / segment size)
```

브로커는 외부 당사자(예: 클라이언트, 다른 브로커, 사육사, 센트리 및 Kerberos)와 네트워크 소켓을 통해 통신하기 위해 추가 파일 설명자가 필요합니다.

Cloudera Manager에서 설정을 모니터링하고 사용량이 기본값(종종 64K)보다 큰 값을 필요로 하는 경우 설정을 늘릴 수 있습니다. 사용 사례 적합성을 위해 검토해야 합니다.Maximum Process File Descriptorsulimit

- 현재 실행 중인 Kafka 브로커에 대해 설정된 FD 제한을 검토하려면 실행및 찾을 수 있습니다.cat /proc/KAFKA_BROKER_PID/limitsMax open files

- 열려 있는 파일 설명자참조를 보려면 다음을 실행합니다.

  ```
  lsof -p KAFKA_BROKER_PID
  ```

## Filesystems

noatime, nodiratime, nobarrier,data=wirteback

리눅스는 파일이 생성() 수정되고 액세스()될 때 기록됩니다. 이 값은 Linux의 파일 시스템(예: EXT4)에 대한 특수 마운트 옵션으로 파일에 액세스할 때마다 커널에 inode 정보를 업데이트하지 않도록 알려줍니다(즉, 마지막으로 읽었을 때). 이 옵션을 사용하면 쓰기 성능이 향상될 수 있습니다. 카프카는 에 의존하지 않습니다. 이 값은 유지 방법을 최적화하는 또 다른 장착 옵션입니다. 액세스 시간은 이전이 현재 수정된 시간보다 일찍 업데이트된 경우에만 업데이트됩니다.ctimemtimeatimenoatimeatimerelatimeatimeatime

장착 옵션을 보려면 실행하거나 명령합니다.mount -lcat /etc/fstab

## Virtual Memory Handling

vm.swappiness = 1

vm.dirty_ratio = 60

Kafka는 메시지를 생성하고 소비하기 위해 시스템 페이지 캐시를 광범위하게 사용합니다. Linux 커널 매개 변수는 실제 메모리에서 디스크의 가상 메모리에 대한 응용 프로그램 데이터(익명 페이지)의 교환을 제어하는 0-100값입니다. 값이 높을수록 보다 공격적으로 비활성 프로세스가 물리적 메모리에서 바뀝을 바꿔야 합니다. 값이 낮을수록 교환이 줄어들어 파일 시스템 버퍼가 비워지도록 강요합니다. 스왑 공간에 할당된 메모리가 많을수록 페이지 캐시에 더 적은 메모리를 할당할 수 있으므로 Kafka의 중요한 커널 매개 변수입니다. Cloudera는 값을 로 설정하는 것이 좋습니다.vm.swappinessvm.swappiness1

- 디스크로 교환된 메모리를 확인하려면 스왑 열을 실행하고 찾습니다.vmstat

Kafka는 디스크 I/O 성능에 크게 의존합니다. 더러운 페이지가 디스크에 플러시되는 빈도를 제어하는 커널 매개 변수입니다. 디스크에 대한 플러시 빈도가 줄어듭니다.vm.dirty_ratiovm.dirty_background_ratiovm.dirty_ratio

- 시스템에 실제 더러운 페이지 수를 표시하려면 실행 egrep "dirty|writeback" /proc/vmstat

## Networking Parameters

Kafka는 엄청난 양의 네트워크 트래픽을 처리하도록 설계되었습니다. 기본적으로 리눅스 커널이 이 시나리오에 대해 조정되지 않습니다. 사용 사례 또는 특정 Kafka 워크로드에 따라 다음 커널 설정을 조정해야 할 수 있습니다.

- net.core.wmem_default: 기본적으로 소켓 버퍼 크기를 보냅니다.
- net.core.rmem_default: 기본적으로 소켓 버퍼 크기를 받습니다.
- net.core.wmem_max: 최대 송신 소켓 버퍼 크기입니다.
- net.core.rmem_max: 최대 수신 소켓 버퍼 크기.
- net.ipv4.tcp_wmem: TCP에 예약된 메모리가 버퍼를 전송합니다.
- net.ipv4.tcp_rmem: TCP수신 버퍼에 대해 예약된 메모리입니다.
- net.ipv4.tcp_window_scaling: TCP 창 크기 조정 옵션입니다.
- net.ipv4.tcp_max_syn_backlog: 최대 미결제 TCP SYN 요청 수(연결 요청)입니다.
- net.core.netdev_max_backlog: 커널 입력 측에 대기된 패킷의 최대 수(네트워크 요청 급증에 대처하는 데 유용).

매개 변수를 지정하려면 [Cloudera 엔터프라이즈 참조 아키텍처를 ](http://www.cloudera.com/documentation/other/reference-architecture/PDF/cloudera_ref_arch_metal.pdf)지침으로 사용할 수 있습니다.





네트워킹 매개 변수 다음 매개 변수는 다양한 네트워크 동작을 최적화하기 위해 /etc/sysctl.conf에 추가됩니다. CPU 사용률을 높이기 위해 TCP 타임 스탬프를 비활성화합니다 (선택 매개 변수이며 NIC 공급 업체에 따라 다름).

net.ipv4.tcp_timestamps = 0

처리량을 향상시키기 위해 TCP sacks를 활성화합니다.

net.ipv4.tcp_sack = 1

프로세서 입력 대기열의 최대 길이를 늘리십시오.

net.core.netdev_max_backlog = 250000

setsockopt ()를 사용하여 TCP 최대 및 기본 버퍼 크기를 늘리십시오.

net.core.rmem_max = 4194304

net.core.wmem_max = 4194304

net.core.rmem_default = 4194304

net.core_wmem_default = 4194304

net.core.optmem_max = 4194304

패킷 드롭을 방지하기 위해 메모리 임계 값을 늘리십시오.

net.ipv4.tcp_rmem = "4096 87380 4194304"

net.ipv4.tcp_wmem = "4096 65536 4194304"

TCP에 대해 낮은 대기 시간 모드를 활성화합니다.

net.ipv4.tcp_low_latency = 1

TCP 창 크기와 응용 프로그램 버퍼간에 균등하게 나눌 소켓 버퍼를 설정합니다.

net.ipv4.tcp_adv_win_scale = 1





# Mysql 

## Memory settings in /etc/sysctl.conf

Swapping is not ideal for databases and should be avoided as much as possible.

```
vm.swappiness = 10
```

Maximum percentage of active memory that can be dirty pages:



```
vm.dirty_background_ratio = 3
```

Maximum percentage of total memory that can have dirty pages:

```
vm.dirty_ratio = 40
```

How long to keep data in page cache before expiring:

```
vm.dirty_expire_centisecs = 500
```

How often pdflush activates to clean dirty pages in hundredths of a seconds:

```
vm.dirty_writeback_centisecs = 100
```

## Semaphores

Recommended minimum settings for semaphores:

```
kernel.sem = 250 32000 100 128
- The first value, SEMMSL, is the maximum number of semaphores per semaphore set
- The second value, SEMMNS, defines the total number of semaphores for the system
- The third value, SEMOPM, defines the maximum number of semaphore operations per semaphore call
- The last value, SEMMNI, defines the number of entire semaphore sets for the system
```

## Edit /etc/security/limits.conf

Open file descriptors for MySQL:

```
#[domain]      [type]  [item]         [value]
mysql          hard    nofile          10000
```

## I/O Scheduler

The default CFQ I/O scheduler is appropriate for most workloads, but does not offer optimal performance for database environments.

- The **deadline** scheduler is recommended for physical systems
- The **noop** scheduler is recommended for virtual systems

## Edit /etc/my.cnf

```
innodb_buffer_pool_size  -  If you use Innodb, 70% to 80% of main memory is adequate.
key_buffer_size  -  If you use MyISAM, approx 30% of main memory is adequate.
sort_buffer_size  -  256KB to 1MB
read_buffer_size  -  128KB to 512KB
read_rnd_buffer_size  -  256KB to 1MB
```