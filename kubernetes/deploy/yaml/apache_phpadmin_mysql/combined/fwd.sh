kubectl port-forward svc/lamp 9090:80 -n lampdemo 2>&1 & 
kubectl port-forward svc/lamp-apache 9084:80 -n lampdemo 2>&1 &  
