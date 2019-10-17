echo "Deploying mongodb"

cd kubernetes

echo "Pull the latest mongo image into minikube docker"
eval $(minikube docker-env)
docker pull mongo:latest
docker images 

echo "Now deploy the mongo in kubernetes"
kubectl create -f mongo.yaml
kubectl expose deployment mongo --type=NodePort
minikube service mongo --url

cd ..

docker images | grep mongo
kubectl get deployment
kubectl get pods
minikube service mongo --url

echo "Done"
