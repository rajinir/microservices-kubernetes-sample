echo "Set the environment to use minikube docker deamon"
eval $(minikube docker-env)

cd app
echo "Creating the docker images"
cd userservice
docker build -f Dockerfile -t users:latest .
cd ..
cd taskservice
docker build -f Dockerfile -t tasks:latest .
cd ..
cd ..

cd kubernetes
echo "Now applying the  deployment"
kubectl apply -f deployment_users.yaml
kubectl apply -f deployment_tasks.yaml
cd ..

echo "Now ssh into minikube to verif and use kubectl commnads"
docker images | grep tasks
docker images | grep users

kubectl get pods
kubectl get deployment
kubectl get service
minikube service users-service --url
minikube service tasks-service --url


