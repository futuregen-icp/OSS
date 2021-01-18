



## arp cache full (Neighbour table overflow.)

\# gc table sizing

```
net.ipv4.neigh.default.gc_thresh1 = 4096
net.ipv4.neigh.default.gc_thresh2 = 8192
net.ipv4.neigh.default.gc_thresh3 = 16384
net.ipv4.neigh.default.base_reachable_time = 86400
net.ipv4.neigh.default.gc_stale_time = 86400
```

​	\# gc 주기

```
net.ipv4.neigh.default.gc_interval = 30
```



​	\# gc 대상 시간  +

## 브릿지 트래픽 iptables에서 확인 

```
lsmod | grep br_netfilter
sudo modprobe br_netfilter
```

```bash
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
```



## container runtime 설정 

### containerd

```
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
```



### CRI-O

```
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
```



### Docker





 latency-performance 

```
force_latency=1
governor=performance
energy_perf_bias=performance
min_perf_pct=100
kernel.sched_min_granularity_ns=10000000
vm.dirty_ratio=10
vm.dirty_background_ratio=3
vm.swappiness=10
kernel.sched_migration_cost_ns=5000000
```



```
# Dependent on NUMA: Reclaim Ratios
/proc/sys/vm/swappiness
/proc/sys/vm/min_free_kbytes
/proc/sys/vm/zone_reclaim_mode

# Independent of NUMA: Reclaim Ratios
/proc/sys/vm/vfs_cache_pressure

# Writeback Parameters
/proc/sys/vm/dirty_background_ratio
/proc/sys/vm/dirty_ratio

# Readahead parameters
/sys/block/<bdev>/queue/read_ahead_kb
```





