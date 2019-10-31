# microservices-kubernetes-sample

Hope you have a VM with ubuntu and atleast 2VCPUs, 8GB RAM and 30GB HardDisk

## Section1. Pre-Reqs – Done
 
1. Login using ssh and run the pre_reqs

```
git clone https://github.com/rajinir/microservices-kubernetes-sample 

cd microservices-kubernetes-sample/setup  

install_pre-reqs.sh 
```


## Section2. Deploy Minikube and Kubectl

1. Install minikube and kubectl 

```
setup\install_minikube.sh 
```
Or 


2. Install kubectl

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl 
chmod +x ./kubectl 
sudo mv ./kubectl /usr/local/bin/kubectl 
```

3. Install minikube 
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 
chmod +x minikube 
sudo mv minikube /usr/local/bin/ 
```

## Section3. Minikube 

1. Start minikube– takes few minutes(3-4 mins ). Downloads the minikube iso VM boot image, creates a tiny virtual box Vm with 2 CPUs, 2GB RAM and 20GB disk. Prepares kubernetes v1.6.0 which is the stable release, pulls the images into the docker engine, launches kubernetes etc.. 

```
$minikube start 

or for more details

$minikube start -v=10
```

2. Run minikube status, minikube – vm is at ip 198.168.99.100 

```
$minikube status 
```

3. Run minikube ssh and check the images 
```
minikube ssh 
docker images 
exit 
```

4. Bring up the dashboard 

```
$minikube dashboard  
```

5. Open aanother ssh window
6. Run few kubectl commands 

```
kubectl get deployments 
kubectl get pods 
kubectl get service 
```

## Section4. Deploy MongoDB Pod  

1. Deploy the mongodb in a pod using the script build_and_deploy_mongo.sh or run each command  

```
cd microservers-kubernetes-sample 
```

2. Set the docker env 
```
eval $(minikube docker env) 
```

3. Pull the mongo latest container image into the docker 
```
docker pull mongo:latest 
```

4. List the images and verify 

```
docker images | grep mongo 
```

5. Now cd kubernetes folder 

```
cd kubernetes 
```

6. Deploy the mongo into kubernetes, open mongo.yaml and learn about persistant volume, persistant volume Cliams etc... 

```
kubectl create –f mongo.yaml 
```

7. Expose the deployment as a service 

```
kubectl apply -f mongo-service.yaml 
```

8. Now verify 

```
kubectl get pv 

kubectl get pvc 

kubectl get deployment 

kubectl get pods 
```

9. Get the mongo db service url  

```
minikube service mongo –url 

```

## Section5. Deploy Users-Tasks Sample Application 

1. Build and Deploy microservice apps tasks and users 

```
cd app
```

2. Examine the code in the userservice and taskservice – main.py, requirements.txt, DokcerFile etc 

3. Build the docker images of the users and tasks microservices ( can run build_and_deploy.sh or commands below) 

```
cd app/userservice 

docker build –f Dockerfile –t users:latest 

cd ..  

cd app/taskservice 

docker build –f Dockerfile –t tasks:latest 

cd .. && cd .. 

```

5. Apply the deployment files 

```
cd kubernetes 

kubectl apply -f deployment_users.yaml 

kubectl apply -f deployment_tasks.yaml 

```

6. Verify deployments 

```
kubectl get pods 

kubectl get deployment 

kubectl get service 

minikube service users-service –url 

minikube service tasks-service –url 

```

## Section6. Test Sample Application 

1. Test the application in the browser 

```
minikube service users-service 

minikube service tasks-service 
```

 

 
