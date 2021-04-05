



promethus down 

```
git clone https://github.com/helm/charts.git
cd charts/stable/prometheus-operator
```



### Prometheus Operator 설치하기







```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

```
helm repo update
```

```
kubectl create namespace cluster-monitoring
```

```
helm install cluster-monitoring prometheus-community/kube-prometheus-stack -n cluster-monitoring

AME: cluster-monitoring
LAST DEPLOYED: Thu Mar 18 06:36:06 2021
NAMESPACE: cluster-monitoring
STATUS: deployed
REVISION: 1
NOTES:
kube-prometheus-stack has been installed. Check its status by running:
 kubectl --namespace cluster-monitoring get pods -l "release=cluster-monitoring"


```

```
NAMESPACE            NAME                                                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                        AGE
cluster-monitoring   alertmanager-operated                                ClusterIP   None            <none>        9093/TCP,9094/TCP,9094/UDP     16m
cluster-monitoring   cluster-monitoring-grafana                           ClusterIP   10.111.68.16    <none>        80/TCP                         16m
cluster-monitoring   cluster-monitoring-kube-pr-alertmanager              ClusterIP   10.100.235.25   <none>        9093/TCP                       16m
cluster-monitoring   cluster-monitoring-kube-pr-operator                  ClusterIP   10.106.75.178   <none>        443/TCP                        16m
cluster-monitoring   cluster-monitoring-kube-pr-prometheus                ClusterIP   10.102.151.19   <none>        9090/TCP                       16m
cluster-monitoring   cluster-monitoring-kube-state-metrics                ClusterIP   10.97.179.250   <none>        8080/TCP                       16m
cluster-monitoring   cluster-monitoring-prometheus-node-exporter          ClusterIP   10.99.45.65     <none>        9100/TCP                       16m
cluster-monitoring   prometheus-operated                                  ClusterIP   None            <none>        9090/TCP                       16m
```

```
[root@kube-master-01 ~]# kubectl get pod -A
NAMESPACE            NAME                                                       READY   STATUS      RESTARTS   AGE
cluster-monitoring   alertmanager-cluster-monitoring-kube-pr-alertmanager-0     2/2     Running     0          16m
cluster-monitoring   cluster-monitoring-grafana-54dbf6d948-pwth8                2/2     Running     0          16m
cluster-monitoring   cluster-monitoring-kube-pr-operator-86c6b68446-zdqdw       1/1     Running     0          16m
cluster-monitoring   cluster-monitoring-kube-state-metrics-5c5f58b47b-ccjdq     1/1     Running     0          16m
cluster-monitoring   cluster-monitoring-prometheus-node-exporter-2h2jp          1/1     Running     0          16m
cluster-monitoring   cluster-monitoring-prometheus-node-exporter-6h5px          1/1     Running     0          16m
cluster-monitoring   cluster-monitoring-prometheus-node-exporter-d7bgb          1/1     Running     0          16m
cluster-monitoring   cluster-monitoring-prometheus-node-exporter-t4zrq          1/1     Running     0          16m
cluster-monitoring   prometheus-cluster-monitoring-kube-pr-prometheus-0         2/2     Running     1          16m

```





### ingress



```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: grafana
  namespace: cluster-monitoring
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - host: ga.xxx.xyz
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: cluster-monitoring-3-grafana
            port:
              number: 80
  - host: po.xxx.xyz
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: cluster-monitoring-3-kube-prometheus
            port:
              number: 9090
  - host: al.xxx.xyz
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: cluster-monitoring-3-kube-alertmanager
            port:
              number: 9093

```



### Grafana 초기 패스워드확인

```
kubectl get secret --namespace cluster-monitoring cluster-monitoring-3-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

