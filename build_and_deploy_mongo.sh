echo "Deploying mongodb"

cd kubernetes

echo "Pull the latest mongo image into minikube docker"
eval $(minikube docker-env)
docker pull mongo:latest
docker images 

echo "Now deploy the mongo in kubernetes"
kubectl create -f mongo.yaml
kubectl apply -f mongo-service.yaml 

cd ..
kubectl get deployment
kubectl get pods
minikube service mongo --url

echo "Done"
