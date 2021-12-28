# HA

[ha cluster 실습](HA%2067acf272b69b4bd187aeaeae76f6c04c/ha%20cluster%20%E1%84%89%E1%85%B5%E1%86%AF%E1%84%89%E1%85%B3%E1%86%B8%20f3d2721c73d64dda9cd8ffd72905ac4a.md)

[FENCING:STONITH](HA%2067acf272b69b4bd187aeaeae76f6c04c/FENCING%20STONITH%20cf899e41831149f1930427ea93dcb938.md)

[DRBD](HA%2067acf272b69b4bd187aeaeae76f6c04c/DRBD%2038b1738368cc431bbaaa7918cf52e9b2.md)

## **[HA란?](https://honglab.tistory.com/126#HA%EB%-E%--%-F)**

- **High Availability (고가용성)**
- 즉 애플리케이션의 다운타임을 최소화하는 것이다
- 이를 구현하려면 2개 이상의 호스트들을 묶어서(Clustering) 하나의 호스트가 죽을 시 다른 호스트가 그 역할을 대신 이어나가야 한다
- 즉 [이중화 구성](https://run-it.tistory.com/41)을 하는 것
- 윈도우같은 경우는 MSCS를 통해 GUI로 구현 가능

## **[Pacemaker란?](https://honglab.tistory.com/126#Pacemaker%EB%-E%--%-F)**

- 리눅스의 이중화 도구
- 오픈소스 **HA Cluster Resource Manager**
- 즉, 여러 대의 호스트들을 Cluster로 묶고 그 호스트들의 자원을 관리한다

## **[Pacemaker의 내부 구성 요소](https://honglab.tistory.com/126#Pacemaker%EC%-D%--%--%EB%--%B-%EB%B-%--%--%EA%B-%AC%EC%--%B-%--%EC%-A%--%EC%--%-C)**

![https://blog.kakaocdn.net/dn/cy5oEB/btq2krn8SDb/beREUklSVGOkV6wHEeiQV0/img.png](https://blog.kakaocdn.net/dn/cy5oEB/btq2krn8SDb/beREUklSVGOkV6wHEeiQV0/img.png)

- **CRMd (Cluster Resource Management daemon)**
    - main controlling process
    - 모든 리소스 작업 라우팅
- **CIB (Cluster Information Base)**
    - 설정 정보 관리 데몬 - XML 파일로 설정
- **PEngine (PE, Policy Engine)**
    - 현재 클러스터 상태 및 구성을 기반으로 다음 상태 결정
- **LRMd (Local Resource Management daemon)**
    - CRMd와 각 리소스 사이의 인터페이스 역할 / CRMd의 명령을 agent에 전달
    - CRM이 수행되어 보고된 결과에 따라 start/stop/monitor 동작
- **STONITHd (Shoot The Other Node In The Head daemon)**
    - 그대로 번역한다면 **"다른 노드의 머리를 쏜다"**
    - 즉, 오류가 발생한 호스트(노드)나 리소스를 비활성화 시키는 **Fencing 기능** 수행
    - 다른 노드의 서비스 이상이나 Power-off 등이 감지되면 해당 노드나 서비스를 재시작한다
    - 서비스가 중복으로 실행되어 충돌나는것을 방지

![https://blog.kakaocdn.net/dn/dJ5rOO/btq2gXWrqGv/ktqqklEMr3NQ3cHmsfwfHk/img.png](https://blog.kakaocdn.net/dn/dJ5rOO/btq2gXWrqGv/ktqqklEMr3NQ3cHmsfwfHk/img.png)

## **[CoroSync](https://honglab.tistory.com/126#CoroSync)**

- Pacemaker가 현재 호스트에서 서비스들이 잘 동작하고 있는지 확인하는 역할이라면
- Corosync는 호스트간에 메시지를 주고받는 역할을 수행
- Pacemaker는 Resource Manager / Corosync는 **Messaging Layer**

## **[Heartbeat](https://honglab.tistory.com/126#Heartbeat)**

- Corosync랑 비슷한 역할이긴 하나 조금 다른듯해서 쓴다
- 클라이언트에 클러스터 인프라(통신 및 멤버십) 서비스를 제공하는 데몬
- 이를 통해 클라이언트는 다른 호스트에서의 서비스 이상 등을 감지할 수 있고 메시지를 쉽게 교환할 수 있다고 한다

## **[RA (Resource Agent)](https://honglab.tistory.com/126#RA%---Resource%--Agent-)**

- Pacemaker가 서비스를 관리할 수 있는 추상 개념
- local resource의 start/stop/monitor 스크립트 제공
- LRM에 의해서 호출됨
- Pacemaker 제공 RA 지원 타입
    - LSB : Linux Standard Base "init scripts"
    - **OCF : Open Cluster Framework**
    - etc...

## **[Pacemaker 클러스터 유형](https://honglab.tistory.com/126#Pacemaker%--%ED%--%B-%EB%-F%AC%EC%-A%A-%ED%--%B-%--%EC%-C%A-%ED%--%--)**

![https://blog.kakaocdn.net/dn/xv2Vr/btq2hY1kZZl/hHtcKUk53xTyXakgpUuSk1/img.png](https://blog.kakaocdn.net/dn/xv2Vr/btq2hY1kZZl/hHtcKUk53xTyXakgpUuSk1/img.png)

![https://blog.kakaocdn.net/dn/bBWAFL/btq2kDoF1en/9dMYD4BhKSpMtNdWKnIzX1/img.png](https://blog.kakaocdn.net/dn/bBWAFL/btq2kDoF1en/9dMYD4BhKSpMtNdWKnIzX1/img.png)

![https://blog.kakaocdn.net/dn/1XwWc/btq2h2W2OuG/hrDLsIOh6hPRosGX6x6FHk/img.png](https://blog.kakaocdn.net/dn/1XwWc/btq2h2W2OuG/hrDLsIOh6hPRosGX6x6FHk/img.png)

## **[pcs (pacemaker configuration system)](https://honglab.tistory.com/126#pcs%---pacemaker%--configuration%--system-)**

- Pacemaker, Corosync, Heartbeat 등의 데몬들 제어하는 CLI 명령어 도구
- pcs <parameter1> <parameter2> .. 이런 식으로 쓰인다
- parameter : **cluster, resource, stonith, constraints, property, status, config**

## **[DRBD (Distributed Replicated Block Device)](https://honglab.tistory.com/126#DRBD%---Distributed%--Replicated%--Block%--Device-)**

- HA 클러스터를 구성하기 위해 **Block 단위로 분산 복제하는 장치**
- Active 상태의 서버 disk에 데이터를 저장하면서 네트워크를 통해 standby 서버에 미러링하는 방식으로 이중화
- 즉, 네트워크를 통한 디스크 미러링!

![https://blog.kakaocdn.net/dn/vDZgT/btq2INep8NN/t2wOsJO6WvWTJLkKjXBZz0/img.png](https://blog.kakaocdn.net/dn/vDZgT/btq2INep8NN/t2wOsJO6WvWTJLkKjXBZz0/img.png)

# **2. Pacemaker와 corosync**

**2.1 Pacemaker, corosync란 무엇인가?**

대부분의 pacemaker 레퍼런스는 자세한 개념을 설명해주지 않아 여러모로 삽질을 많이 했다. 일반적으로 pacemaker를 사용할 때는 corosync라는 도구를 함께 쓰는데, 그 역할은 아래와 같다.

**1. corosync** : 저수준의 인프라를 관리해주는 역할이라고 많은 사람들이 두루뭉술하게 설명하는데, 이를 좀 더 구체적으로 설명하자면 "노드 간의 멤버쉽, 쿼럼, 메시징" 정도가 될 수 있다. 즉, corosync는 클러스터 내의 노드 간 Discovery, 통신, 동기화 작업 등을 담당한다. 한 가지 특이한 점은, etcd같은 분산 코디네이터 없이 Mesh 형태로 동작하는 것으로 보인다.

**2. pacemaker :** corosync의 기능을 이용해 ****클러스터의 리소스 제어 및 관리를 수행하며, 사용자 입장에서 클러스터의 특정 기능을 사용할 때는 대부분 pacemaker를 호출하게 된다. 예를 들어, Virtual IP 리소스를 생성하려면 pacemaker의 CLI를 사용하지만, pacemaker는 Virtual IP 리소스 할당을 위해 내부적으로 corosync의 인프라 정보를 사용한다.

![https://mblogthumb-phinf.pstatic.net/MjAyMDAxMjdfMjI2/MDAxNTgwMTE0Mjc1NTIw.mRY2dH8acpnYk_ZjzcvNirLFuEL3UTN3zpmt2EcppScg.XNH_epaajhOKPjNaKNClHMbdrGk-zmtd8iNvUBVbDmMg.JPEG.alice_k106/pacemaker.jpg?type=w2](https://mblogthumb-phinf.pstatic.net/MjAyMDAxMjdfMjI2/MDAxNTgwMTE0Mjc1NTIw.mRY2dH8acpnYk_ZjzcvNirLFuEL3UTN3zpmt2EcppScg.XNH_epaajhOKPjNaKNClHMbdrGk-zmtd8iNvUBVbDmMg.JPEG.alice_k106/pacemaker.jpg?type=w2)

pacemaker와 corosync와는 별개로 **pcs (pacemaker/corosync configuration system)** 이라는 도구가 따로 존재하는데, pcs는 pacemaker와 corosync를 좀 더 쉽게 설정할 수 있도록 도와주는 CLI 명령어 도구이다. 역으로 말하자면 굳이 pcs를 사용하지 않아도 pacemaker 클러스터를 구축하고 사용할 수는 있지만, 대부분의 레퍼런스가 pcs를 기준으로 설명하고 있으므로 웬만하면 pcs를 사용하는 것이 권장된다.