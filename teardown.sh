echo "Teardown"

kubectl delete deployment users
kubectl delete service users-service

kubectl delete deployment tasks
kubectl delete service tasks-service

