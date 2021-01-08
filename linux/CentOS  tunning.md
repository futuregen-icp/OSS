



# CentOS  tunning

## CPU Power 

### governor 

```
governor=performance
```

- OnDemand : 사용량에 따라 자동으로 CPU frequnecy가 변경됨 (빠르게 변경됨)

- OnDemandX : 배터리를 염두에 둔 OnDemand  (I/O 스케줄러에 따라 성능이 크게 좌우)

- Condervation : OnDemand 방식에서 가능하면 느린 frequnecy를 이용하도록 함 

  ​                           ex) OnDemand  : min  -> max (필요량)

  ​                                 Condervation : min -> lower-> mid -> hig 0> max(필요량)

- Interactive : OnDemand 보다 훨씬 빠르게 CPU frequnecy가 변경됨

- Performance : 항샹 최고의 성능을 유지 

- Powersave : 가능한 최저의 수중을 유지

- Userspace : 사용할 CPU frequnecy 지정 



**적용 설정 확인 방법**

```
cat /etc/sysconfig/cpupower

# See 'cpupower help' and cpupower(1) for more info
CPUPOWER_START_OPTS="frequency-set -g performance"
CPUPOWER_STOP_OPTS="frequency-set -g ondemand"
```

### energy_perf_bias

```
energy_perf_bias=performance
```

energy_perf_bias 지시문을 사용하면 지원되는 Intel 프로세서의 소프트웨어가 최적의 성능과 절전 간의 균형을 결정하는 데보다 적극적으로 기여할 수 있습니다

### min_perf_pct

```
min_perf_pct=100
```

0 ~ 100 까지 설정가능하며  숫자가 클 수록 성능이 우선시 되고 숫자가 적을 수록 절전이 우선시 됨

### force_latency

```
force_latency=1
```

1=> 1us 를  나타내며 bios상에 c-stats c1의 지연 시간 설정  (주파수 단위로 설정)



## kernel

### kernel scheduler

**sched_min_granularity_ns** : CPU에 밀접한 태스크를 위한 최소 선점 정밀도 ( 단위 나노초 )

**sched_wakeup_granularity_ns** : `SCHED_OTHER`를 위한 깨우기 정밀도 ( 단위 나노초 )

```
kernel.sched_min_granularity_ns = 10000000
kernel.sched_wakeup_granularity_ns = 15000000

```

### numa

**numa_balancing**

```
kernel.numa_balancing=0
```



## Memory

### Virtural Memory

**dirty_ratio** : vm.dirty_background_ratio와 비슷하게 전체 메모리를 기준으로 dirty page의 비율을 산정하지만 background라는 단어가 빠져있음을 눈여겨 봐야한다. 만약 이값이 10으로 설정되어 있고 전체 메모리가 16GB라고 가정한다면, A라는 프로세스가 I/O 작업을 하던 중 dirty페이지의 크기가 1.6GB가 되면 해당 프로세스의 I/O 작업을 모두 멈추게 하고 dirty page를 동기화한다. dirty page에 대한 일종의 hard limit라고 볼 수 있다.

**dirty_background_ratio** : dirty page의 내용을 백그라운드로 동기화할 때 그 기준이 되는 비율을 의미한다. 전체 메모리 양에 해당 파라미터에 설정되어있는 비율을 곱해서 나온 기준값보다 dirty page 크기가 커지면 백그라운드에서 dirty page의 내용을 디스크로 동기화한다. 만약 이 값이 10이고 전체 메모리가 16GB라고 가정한다면, dirty page의 크기가 1.6GB가 되었을 때 백그라운드 동기화를 진행한다

**swappiness** :  커널 문서에도 정의되어 있는 것처럼 메모리가 부족한 상황에서도 캐시를 비우느냐 아니면 특정 프로세스의 메모리 영역을 swap영역으로 옮기느냐를 결정한다.
이 값이 커지면 캐시를 비우지 않고 swap영역으로 옮기는 작업을 더 빨리 진행하고, 이 값이 작아지면 가능한 한 캐시를 비우는 작업을 진행한다.

```
/etc/sysctl.conf
vm.dirty_ratio=10
vm.dirty_background_ratio=3
vm.swappiness=10
```



### overcommit

```
echo "2" > /proc/sys/vm/overcommit_memory
```

0.  커널에서 사용하는 기본값  (PageCache + Swap Memory + Slab Reclaimable 합친 값이 요청한 메모리 보다 큰 경우 commit이 발생 ) 

    이는 실제 free memory 량 과는 무관하게 계산 

1. 항상 overcommit을 허용하며 언제든 메모리 할당을 가능하게 해준다.

   이는 시스템 과도한 메모리 할당으로 OOMKiller를 발생시킨다.

2.  가용한 범위내에서 메모리를 할당하지만  메모리 부족으로 프로세스가 중단되는 경우도 발생 

     

   ```
   allow = (totalram)pages - hugetlb_total_pages())
         * sysctl_overcommit_ratio / 100;
   /*
    * Leave the last 3% for root
    */
   if (!cap_sys_admin)
       allowed -= allowed / 32 ;
   allowed += total_swap_page ;
   /* Don't let a single process grow too big;
      leave 3% of the size of this process for other process */
   if (mm)
       allowed = -mm->total_vm / 32;
   if (percpu_couter_read_positive(&vm_commit_as) < allowed)
   ```

   

### hugepage

```
echo "never" > /sys/kernel/mm/transparent_hugepage/enabledcat 
echo "never" > /sys/kernel/mm/transparent_hugepage/defrag
```



## filesystem

### mount option

| 항목           | 내용                                                         |
| -------------- | ------------------------------------------------------------ |
| noatime        | access time을 기록 하지 않음                                 |
| nodiratime     | directory의 accesstime을 기록 하지 않음                      |
| nobarrier      | fsync의 기능을 사용하지 않음                                 |
| data=writeback | 메타데이터는 journal 되지만 데이타는 journal되지 않음        |
| discard        | ssd,nvme 의 전용 옵션이며 이는 주기적으로 삭제된 데이터공간을 초기화야여 바로 쓰기 가능하도록 함 |

```
mount -o remount,nobarrier,nodiratime,noatime /DATA

/etc/fstab 수정 
```



## Disk 

### readahead

device의 기분 값 (256)  :  256 * 512 = 131072 = 128 KB

​	

```
## 일반적으로 사용하는 4배수 
readahead=1024
```



```
예를들어, 32MB로 RA를 설정한다고 가정한다면,
32 * 1024 (MB)* 1024(KB) / 512 = 65536

blockdev --setra 65536 /dev/sda
```

1M 부터 차근차근 올려 보기 

레아드 컨트롤러를 사용하는 경우 캐쉬 메모리의 량에 따라 조금 더 크게 활용 가능 

### I/O scheduler

**deadline** :  sata 디스크를 제외한 기본 스케줄러 , 요청 대기시간에 대한 보장 

**cfg**            :  sata 디스크에 대한 기본 스케줄러

**noop**        :  FIFO방식의 간단한 알고리즘으로 구현 



```
echo 'noop'> /sys/block/sda/queue/scheduler
```



**deadline**

| 항목           | 내용                                                         |
| -------------- | ------------------------------------------------------------ |
| fifo_batch     | 단일 배치에서 발생하는 읽기 또는 쓰기 작업 수입니다. 기본값은 16입니다. 값이 높을 수록 처리 능력도 증가하지만 대기 시간도 늘어납니다. |
| front_merges   | 워크로드가 전면 병합을 생성하지 않은경우 이 매개 변수를 0으로 설정할 수 있습니다. 하지만 이러한 검사의 오버헤드를 측정하지 않는 한 Red Hat은 기본 설정 1을 그대로 사용할 것을 권장합니다. |
| read_expire    | 읽기 요청을 실행할 시간을 밀리초 단위로 예약 설정할 수 있습니다. 기본값은 500 (0.5 초)입니다. |
| write_expire   | 쓰기 요청을 실행할 시간을 밀리초 단위로 예약 설정할 수 있습니다. 기본값은 5000 (5 초)입니다. |
| writes_starved | 쓰기 배치를 처리하기 전 처리할 수 있는 읽기 배치 수를 지정합니다. 이 값을 높게 설정할 수록 읽기 배치가 우선적으로 처리됩니다. |

**cfg**  

| 항목                  | 내용                                                         |
| --------------------- | ------------------------------------------------------------ |
| **back_seek_max**     | `cfq`는 역방향 검색을 수행하는 최대 거리를 킬로바이트 단위로 지정합니다. 기본값은 `16` KB입니다. 일반적으로 역방향 검색은 성능에 지장이 될 수 있으므로 큰 값을 사용하는 것을 권장하지 않습니다. |
| **back_seek_penalty** | 디스크 헤드를 앞 또는 뒤로 이동할 지를 지정할 때 역방향 검색에 적용할 승수를 지정합니다. 기본값은 `2`입니다. 디스크 헤드 위치가 1024 KB이고 시스템에 등거리 요청 (예: 1008 KB 및 1040 KB)이 있을 경우 *`back_seek_penalty`*는 역박향 탐색거리에 적용되며 디스크는 앞으로 이동합니다. |
| **fifo_expire_async** | 비동기 (버퍼 쓰기) 요청이 처리되지 않은 상태로 남아 있을 수 있는 시간을 밀리초 단위로 지정합니다. 지정된 시간이 경과하면 단일 비동기 처리 요청은 디스패치 목록으로 이동합니다. 기본값은 `250` 밀리초입니다 |
| **fifo_expire_sync**  | 동기화 (읽기 또는 `O_DIRECT` 쓰기) 요청이 최리되지 않은 상태로 남아 있을 수 있는 시간을 밀리초 단위로 지정합니다. 지정된 시간이 경과하면 단일 동기화 처리 요청은 디스패치 목록으로 이동합니다. 기본값은 `125` 밀리초입니다 |
| **group_idle**        | 이 매개 변수는 기본적으로 `0` (비활성화)로 설정됩니다. `1` (활성화)로 설정되어 있을 경우 `cfq` 스케줄러는 제어 그룹에서 I/O를 발행하는 마지막 프로세스에서 유휴 상태가 됩니다. 비례 가중 I/O 제어 그룹을 사용하고 *`slice_idle`*이 `0`으로 (고속 스토리지) 설정되어 있을 때 유용합니다. |
| **low_latency**       | 이 매개 변수는 기본적으로 `1` (활성화)로 설정되어 있습니다. 활성화되어 있을 경우 `cfq`는 장치에 I/O를 발행하는 각 프로세스에 대해 최대 `300` ms로 대기 시간을 제공하여 처리량 보다 공정성을 우선으로 합니다. 이 매개 변수가 `0` (비활성화)로 설정되어 있을 경우 대상 지연 시간은 무시되고 각 프로세스는 전체 타임 슬라이스를 받습니다 |
| **quantum**           | 이 매개 변수는 `cfq`가 한 번에 하나의 장치에 보낼 수 있는 I/O 요청 수를 지정하며, 기본적으로 큐 깊이를 제한합니다. 기본값은 `8`입니다. 사용 장치는 더 깊은 큐 깊이를 지원할 수 있지만 quantum을 증가시키면 대기 시간이 늘어나며 특히 대량의 연속 쓰기 워크로드가 있을 경우 더욱 그러합니다. |
| **slice_async**       | 이 매개 변수는 비동기 I/O 요청을 발행하는 각 프로세스에 할당할 타임 슬라이스 (밀리초 단위) 길이를 지정합니다. 기본값은 `40` 밀리초입니다. |
| **slice_idle**        | 이는 추가 요청을 기다리는 동안 cfq의 유휴 상태 시간을 밀리초 단위로 지정합니다. 기본값은 `0` (큐 또는 서비스 트리 레벨에서 유휴 상태가 아님)입니다. 외부 RAID 스토리지에서의 처리량의 경우 기본값을 사용하는 것이 좋지만 이는 전체 검색 수를 증가시키므로 내부의 비 RAID 스토리지에서의 처리량을 저하시킬 수 있습니다. |
| **slice_sync**        | 이 매개 변수는 비동기 I/O 요청을 발행하는 각 프로세스에 할당할 타임 슬라이스 (밀리초 단위) 길이를 지정합니다. 기본값은 `100` 밀리초입니다 |

```
고속 스토리지에 cfq 튜닝
외장형 스토리지 어레이나 SSD와 같은 대형 탐색 패널티의 영향을 받지 않는 하드웨어의 경우 cfq 스케줄러 사용을 권장하지 않습니다. 이러한 스토리지에서 cfq를 사용해야 할 경우 다음 설정 파일을 편집해야 합니다:
/sys/block/devname/queue/ionice/slice_idle을 0로 설정
/sys/block/devname/queue/ionice/quantum을 64로 설정
/sys/block/devname/queue/ionice/group_idle을 1로 설정
```

**noop**

| 항목                | 내용                                                         |
| ------------------- | ------------------------------------------------------------ |
| **add_random**      | 일부 I/O 이벤트는 `/dev/random`의 엔트로피 풀에 적용됩니다. 이러한 적용의 오버헤드가 측정 가능할 경우 이 매개 변수를 `0`로 설정할 수 있습니다. |
| **max_sectors_kb**  | 최대 I/O 요청 크기를 KB 단위로 지정합니다. 기본값은 `512` KB입니다. 이 매개 변수의 최소값은 스토리지 장치의 논리적 블록 크기에 따라 지정됩니다. 이 매개 변수의 최대값은 *`max_hw_sectors_kb`* 값에 따라 지정됩니다.<br />I/O 요청이 내부 소거 블록 크기 보다 크면 일부 SSD 성능이 저하됩니다. 이러한 경우 Red Hat은 *`max_hw_sectors_kb`*를 내부 소거 블록 크기로 줄일 것을 권장합니다. |
| **nomerges**        | 요청 병합은 대부분의 워크로드에 효과적이지만 디버깅 목적의 경우 병합을 비활성화하는것이 유용합니다. 이 매개 변수를 `0`로 설정하여 병합을 비활성화합니다. 기본값으로 이는 비활성화 (`1`으로 설정)되어 있습니다. |
| **nr_requests**     | 한 번에 대기 큐에 둘 수 있는 최대 읽기 및 쓰기 요청 수를 지정합니다. 기본값은 `128`이며 이는 다음의 읽기 또는 쓰기 요청 프로세스를 수면 상태로 두기 전 128 개의 읽기 요청과 128 개의 쓰기 요청을 대기 큐에 둘 수 있음을 의미합니다.<br />대기 시간에 민감한 애플리케이션의 경우 이 매개 변수의 값을 낮추고 스토리지의 명령 큐 깊이를 제한하면 다시 쓰기 I/O는 쓰기 요청으로 장치 큐를 채울 수 없습니다. 장치 큐가 채워지면 I/O 동작을 실행하려고 하는 다른 프로세스는 큐를 사용할 수 있을 때 까지 수면 상태로 됩니다. 요청은 라운드 로빈 방식으로 할당되기 때문에 하나의 프로세스가 큐에서 지속적으로 소비되지 않게 합니다. |
| **optimal_io_size** | 일부 스토리지 장치는 이러한 매개 변수를 통해 최적의 I/O 크기를 보고합니다. 이러한 값이 보고되면 Red Hat은 애플리케이션이 가능한 최적의 I/O 크기로 조정되어 그 배수의 I/O를 실행할 것을 권장합니다 |
| **read_ahead_kb**   | 페이지 캐시에서 곧 필요한 정보를 저장하기 위해 연속적인 읽기 동작 동안 운영 체제가 미리 읽기할 용량 (KB)을 지정합니다. 장치 매퍼는 *`read_ahead_kb`* 값을 높게 지정하여 이점을 갖는 경우가 종종 있습니다. 각 장치의 매핑 값을 128 KB로 시작하는 것이 좋습니다. |
| **rotational**      | 일부 SSD는 솔리드 스테이트 상태를 올바르게 보고하지 않아 기존 회전 디스크로 마운트됩니다. SSD 장치가 이 값을 자동으로 `0`으로 설정하지 않으면 이를 수동으로 설정하여 스케줄러에서 필요하지 않은 검색 시간 단축 설정을 비활성화합니다. |
| **rq_affinity**     | 기본적으로 I/O 요청을 발행한 프로세서가 아닌 다른 프로세서에서 I/O 완료를 처리할 수 있습니다. *`rq_affinity`*를 `1`로 설정하여 이 기능을 해제하고 I/O 요청을 발행하는 프로세서에서만 I/O 완료를 처리하도록 합니다. 이는 프로세서 데이터 캐시의 효율성을 향상시킬 수 있습니다. |



## Network

### socket

**busy_read** : 소켓의 읽기 용 장치 큐에서 패킷을 기다리는 시간을 마이크로 초 단위로 관리 
                        ( defaults 0 , 소켓 수가 적은 경우 `50`으로 소켓 수가 많은 경우 `100`으로 설정할 것을 권장 )

**busy_poll** : 소켓 폴링 및 선택 용 장치 큐에서 패킷을 기다리는 시간을 마이크로 초 단위로 관리
                        ( Red Hat은 `50`으로 설정 )

**tcp_fastopen ** : tcp 3-hand negotiation에서 몇 단계을 생략해서 접속을 빠르게 하는 기능

​                             0 : 비활성화

​                             1 :  TFO가 나가는 연결 (클라이언트)에서만 활성화

​                             2 : 수신 소켓 (서버)에서만 사용할 수 있음

​                             3 : 둘 다 활성화

```
net.core.busy_read=50
net.core.busy_poll=50
net.ipv4.tcp_fastopen=3
```



### buffer

**tcp_rmem** :  TCP를 위해 사용할 수 있는 receive(read) buffer의 크기 ( min / pressure / max )

**tcp_wmem** :  TCP를 위해 사용할 수 있는 send(write) buffer의 크기 ( min / pressure / max )

**udp_mem** :  UDP를 위해 사용할 수 있는 메모리 크기 ( min / pressure / max )

```
net.ipv4.tcp_rmem="4096 87380 16777216"
net.ipv4.tcp_wmem="4096 16384 16777216"
net.ipv4.udp_mem="3145728 4194304 16777216"
```

단위는 page   ( 1page = 4096 byte)





tuned.conf

```
#
# tuned configuration
#

[main]
summary=Broadly applicable tuning that provides excellent performance across a variety of common server workloads

[cpu]
governor=performance
energy_perf_bias=performance
min_perf_pct=100
force_latency=1

[os_disk]
readahead=4096
type=disk
devices=vda
elevator=kyber

[data_disk]
readahead=8128
type=disk
devices=vdb
elevator=deadline

[data1_disk]
readahead=8128
type=disk
devices=vdc
elevator=none


[sysctl]
kernel.sched_min_granularity_ns = 10000000
kernel.sched_wakeup_granularity_ns = 15000000

vm.dirty_ratio=10
vm.dirty_background_ratio=3
vm.swappiness=10

net.core.busy_read=50
net.core.busy_poll=50
net.ipv4.tcp_fastopen=3
kernel.numa_balancing=0

net.ipv4.tcp_rmem="4096 87380 16777216"
net.ipv4.tcp_wmem="4096 16384 16777216"
net.ipv4.udp_mem="3145728 4194304 16777216"

[bootloader]
cmdline=skew_tick=1


[script]
script=/etc/tuned/k8s/k8s.sh

```



k8s.sh

```
#!/bin/bash
echo "1" > /proc/sys/vm/overcommit_memory

echo "never" > /sys/kernel/mm/transparent_hugepage/enabled

mount -o remount,nobarrier /d1
mount -o remount,nobarrier /d2

#echo 'cfq'> /sys/block/vda/queue/scheduler
#echo 'deadline'> /sys/block/vdb/queue/scheduler
#echo 'noop'> /sys/block/vdc/queue/scheduler

echo 128 > /sys/block/vda/queue/nr_requests
echo 256 > /sys/block/vdb/queue/nr_requests
echo 512 > /sys/block/vdc/queue/nr_requests

echo 1 > /sys/block/vda/queue/rq_affinity
echo 0 > /sys/block/vdb/queue/rq_affinity
echo 1 > /sys/block/vdc/queue/rq_affinity

echo 1 > /sys/block/vdc/queue/rotational
echo 0 > /sys/block/vdc/queue/rotational
echo 1 > /sys/block/vdc/queue/rotational

```

```
#!/bin/sh

. /usr/lib/tuned/functions

start() {
    return 0
}

stop() {
    return 0
}

verify() {
    tuna -c "$TUNED_isolated_cores" -P
    return "$?"
}

process $@
```

https://www.lesstif.com/lpt/linux-kernel-tuning-for-network-server-87949594.html