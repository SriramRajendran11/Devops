kubectl port-forward svc/kube-prometheus-stack-prometheus 9090:9090 -n metrics 2>&1 
#kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1
