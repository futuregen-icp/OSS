# pacemaker 명령어 정리

[Chapter 2. The pcsd Web UI Red Hat Enterprise Linux 7 | Red Hat Customer Portal](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/high_availability_add-on_reference/ch-pcsd-haar)

- 클러스터 노드 상태를 보기 위한 PaceMaker 클러스터 명령.

```
# pcs cluster status
```

- 클러스터 노드 및 리소스의 자세한 상태를 보려면 PaceMaker 클러스터 명령을 사용합니다.

```
# pcs status --full
```

- 클러스터 노드 및 리소스의 상태를 보려면 PaceMaker 클러스터 명령을 사용합니다.

```
# crm_mon -r1
```

- 클러스터 노드 및 리소스의 실시간 상태를 보기 위한 PaceMaker 클러스터 명령.

```
# crm_mon r
```

- 모든 클러스터 리소스 및 리소스 그룹의 상태를 보기 위한 PaceMaker 클러스터 명령.

```
# pcs resource show
```

- 클러스터 노드를 대기 모드로 전환하는 PaceMaker 클러스터 명령.

```
# pcs cluster standby <Cluster node name>
```

- 대기 모드에서 클러스터 노드를 제거하는 PaceMaker 클러스터 명령.

```
# pcs cluster unstandby <Cluster node name>:
```

- 한 노드에서 다른 노드로 클러스터 리소스를 이동하는 PaceMaker 클러스터 명령.

```
# pcs resource move <resource name> <node name>
```

- 실행 중인 노드에서 클러스터 리소스를 다시 시작하는 PaceMaker 클러스터 명령.

```
# pcs resource restart <resource name>
```

- 현재 노드에서 클러스터 리소스를 시작하는 PaceMaker 클러스터 명령.

```
# pcs resource enable <resource name>
```

- 실행 중인 노드에서 클러스터 리소스를 중지하는 PaceMaker 클러스터 명령.

```
# pcs resource disable <resource name>:
```

- 디버그 클러스터 리소스를 시작하는 PaceMaker 클러스터 명령. `-full`더 자세한 출력을 위해 스위치 를 사용할 수 있습니다 .

```
# pcs resource debug-start <Resource Name>
```

- 클러스터 리소스 디버깅을 중지하는 PaceMaker 클러스터 명령. `-full`더 자세한 출력을 위해 스위치 를 사용할 수 있습니다 .

```
# pcs resource debug-stop <Resource Name>
```

- 클러스터 리소스 디버깅을 모니터링하는 PaceMaker 클러스터 명령. `-full`더 자세한 출력을 위해 스위치 를 사용할 수 있습니다 .

```
# pcs resource debug-monitor <Resource Name>
```

- 사용 가능한 클러스터 리소스 에이전트를 나열하는 PaceMaker 클러스터 명령.

```
# pcs resource agents
```

- PaceMaker 클러스터 명령을 사용하여 추가 정보와 함께 사용 가능한 클러스터 리소스 에이전트를 나열합니다.

```
# pcs resource list
```

- 클러스터 리소스 에이전트 및 해당 구성 또는 설정에 대한 자세한 정보를 보려면 PaceMaker 클러스터 명령을 사용합니다.

```
# pcs resource describe <Resource Agents Name>
```

- PaceMaker 클러스터 명령을 사용하여 클러스터 리소스를 생성합니다.

```
# pcs resource create <Reource Name> <Reource Agent Name> options
```

- 특정 리소스의 클러스터 구성 설정을 보기 위한 PaceMaker 클러스터 명령.

```
# pcs resource show <Resource Name>
```

- 특정 클러스터 리소스 구성을 업데이트하는 PaceMaker 클러스터 명령.

```
# pcs resource update <Resource Name> options
```

- 특정 클러스터 리소스를 삭제하는 PaceMaker 클러스터 명령.

```
# pcs resource delete <Resource Name>
```

- 특정 클러스터 리소스를 정리하는 PaceMaker 클러스터 명령.

```
# pcs resource cleanup <Resource Name>
```

- 사용 가능한 클러스터 펜스 에이전트를 나열하는 PaceMaker 클러스터 명령.

```
# pcs stonith list
```

- PaceMaker 클러스터 명령은 펜스 에이전트에 대한 세부 클러스터 구성 설정을 봅니다.

```
# pcs stonith describe <Fence Agent Name>
```

- PaceMaker 클러스터 명령은 PaceMaker 클러스터 stonith 에이전트를 생성합니다.

```
# pcs stonith create <Stonith Name> <Stonith Agent Name> options
```

- stonith 에이전트의 PaceMaker 클러스터 구성 설정을 표시합니다.

```
# pcs stonith show <Stonith Name>
```

- PaceMaker 클러스터 stonith 구성을 업데이트합니다.

```
# pcs stonith update <Stonith Name> options
```

- stonith 에이전트를 삭제하는 PaceMaker 클러스터 명령.

```
# pcs stonith delete <Stonith Name>
```

- stonith 에이전트 오류를 정리하기 위한 PaceMaker 클러스터 명령.

```
# pcs stonith cleanup <Stonith Name>
```

- 클러스터 구성을 확인하는 PaceMaker 클러스터 명령.

```
# pcs config
```

- 클러스터 속성을 확인하는 PaceMaker 클러스터 명령.

```
# pcs property list
```

- 클러스터 속성에 대한 자세한 정보를 얻으려면 PaceMaker 클러스터 명령을 사용하십시오.

```
# pcs property list --all
```

- XML 형식으로 클러스터 구성을 확인하는 PaceMaker 클러스터 명령.

```
# pcs cluster cib
```

- 클러스터 노드 상태를 확인하는 PaceMaker 클러스터 명령.

```
# pcs status nodes
```

- 현재 노드에서 클러스터 서비스를 시작하는 PaceMaker 클러스터 명령.

```
# pcs cluster start
```

- 모든 노드에서 클러스터 서비스를 시작하는 PaceMaker 클러스터 명령.

```
# pcs cluster start --all
```

- 현재 노드에서 클러스터 서비스를 중지하는 PaceMaker 클러스터 명령.

```
# pcs cluster stop
```

- 모든 노드에서 클러스터 서비스를 중지하는 PaceMaker 클러스터 명령.

```
# pcs cluster stop --all
```

- `corosync.conf`파일 을 동기화하는 PaceMaker 클러스터 명령 .

```
# pcs cluster sync
```

- PaceMaker 클러스터 명령은 클러스터를 파괴합니다.

```
# pcs cluster destroy <Cluster Name>
```

- PaceMaker 클러스터 명령을 사용하여 새 클러스터 구성 파일을 생성합니다. 이 파일은 현재 위치에 생성되며 이 구성 파일에 여러 클러스터 리소스를 추가하고 `cib-push`명령 을 사용하여 적용할 수 있습니다 .

```
# pcs cluster cib <new config name>
```

- PaceMaker 클러스터 명령은 구성 파일에서 생성된 리소스를 클러스터에 적용합니다.

```
# pcs cluster cib-push <new config name>
```

- 클러스터 리소스 그룹 목록을 보려면 PaceMaker 클러스터 명령.

```
# pcs resource group list
```

- corosync 구성 출력을 보기 위한 PaceMaker 클러스터 명령.

```
# pcs cluster corosync
```

- 클러스터 리소스 순서를 확인하는 PaceMaker 클러스터 명령.

```
# pcs constraint list
```

- 쿼럼 정책을 무시하는 PaceMaker 클러스터 명령.

```
# pcs property set no-quorum-policy=ignore
```

- stonith를 비활성화하는 PaceMaker 클러스터 명령.

```
# pcs property set stonith-enabled=false
```

- 클러스터 기본 고정 값을 설정하는 PaceMaker 클러스터 명령.

```
# pcs resource defaults resource-stickiness=100
```