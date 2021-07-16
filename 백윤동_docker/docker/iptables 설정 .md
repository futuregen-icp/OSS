# iptables 설정

- host 서버 nat enables

```jsx
vi /etc/sysctl.conf

net.ipv4.ip_forward = 1
```

```jsx
echo 1 > /proc/sys/net/ipv4/ip_forward
```

- iptables DOCKER-USER chain 생성 및 설정

```jsx
iptables -I DOCKER-USER -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -N DOCKER-USER // 생성 (없을시 생성)
iptables -I DOCKER-USER -p tcp -m conntrack --ctorigdstport 82 --ctdir ORIGINAL -j ACCEPT
iptables -I DOCKER-USER -p tcp -m conntrack --ctorigdstport 8080 --ctdir ORIGINAL -j ACCEPT
iptables -I DOCKER-USER -p tcp -m conntrack --ctorigdstport 3316 --ctdir ORIGINAL -j ACCEPT
```

> 참고사이트

[Docker 강좌 - 3. Docker 네트워크 1 - 소개 및 Bridge](https://youngmind.tistory.com/entry/%EB%8F%84%EC%BB%A4-%EA%B0%95%EC%A2%8C-3-%EB%8F%84%EC%BB%A4-%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC-1)

[iptables 를 이용한 Port Forwarding 설정하기](https://sugerent.tistory.com/392)

[Docker Network 구조(3) - container 외부 통신 구조](https://bluese05.tistory.com/53)

[https://webdir.tistory.com/170](https://webdir.tistory.com/170)