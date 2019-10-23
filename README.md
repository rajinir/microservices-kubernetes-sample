# microservices-kubernetes-sample

Hope you have a VM with ubuntu and atleast 2VCPUs, 8GB RAM and 30GB HardDisk

## Pre-Reqs – Done
 
Login using ssh and run the pre_reqs

```
git clone https://github.com/rajinir/microservices-kubernetes-sample 

cd microservices-kubernetes-sample/setup  

install_pre-reqs.sh 
```

## Start Here 

### Deploy Minikube 

#### Install minikube and kubectl 

```
setup\install_minikube.sh 
```
Or 


#### Install kubectl

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl 
chmod +x ./kubectl 
sudo mv ./kubectl /usr/local/bin/kubectl 
```

#### Install minikube 
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 
chmod +x minikube 
sudo mv minikube /usr/local/bin/ 
```

#### Minikube 

Start minikube– takes few minutes(3-4 mins ). Downloads the minikube iso VM boot image, creates a tiny virtual box Vm with 2 CPUs, 2GB RAM and 20GB disk. Prepares kubernetes v1.6.0 which is the stable release, pulls the images into the docker engine, launches kubernetes etc.. 

```
$minikube start 
```

Run minikube status, minikube – vm is at ip 198.168.99.100 

```
$minikube status 
```

Run minikube ssh and check the images 
```
minikube ssh 
docker images 
exit 
```

Bring up the dashboard 

```
$minikube dashboard  
```

Open aanother ssh window
Run few kubectl commands 

```
kubectl get deployments 
kubectl get pods 
kubectl get service 
```

## Deploy MongoDB Pod  

Deploy the mongodb in a pod using the script build_and_deploy_mongo.sh or run each command  

```
cd microservers-kubernetes-sample 
```

Set the docker env 
```
eval $(minikube docker env) 
```

Pull the mongo latest container image into the docker 
```
docker pull mongo:latest 
```

List the images and verify 

```
docker images | grep mongo 
```

Now cd kubernetes folder 

```
cd kubernetes 
```

Deploy the mongo into kubernetes, open mongo.yaml and learn about persistant volume, persistant volume Cliams etc... 

```
kubectl create –f mongo.yaml 
```

Expose the deployment as a service 

```
kubectl expose deployment mongo –type=Nodeport 
```

Now verify 

```
kubectl get pv 

kubectl get pvc 

kubectl get deployment 

kubectl get pods 
```

Get the mongo db service url and noted own the port in the string (have to fix this hardcoded port) “http://192.168.99.100:<port>" 

```
minikube service mongo –url 

```

## Deploy Users-Tasks Sample Application 

Build and Deploy microservice apps tasks and users 

```
cd app/usersservice 

vi main.py and modify the port of mongodb 

```
Repeat for tasksservice 

Examine the code in the userservice and taskservice – main.py, requirements.txt, DokcerFile etc 

Build the docker images of the users and tasks microservices ( can run build_and_deploy.sh or commands below) 

```
cd app/userservice 

docker build –f Dockerfile –t users:latest 

cd ..  

cd app/taskservice 

docker build –f Dockerfile –t tasks:latest 

cd .. && cd .. 

```

Apply the deployment files 

```
cd kubernetes 

kubectl apply -f deployment_users.yaml 

kubectl apply -f deployment_tasks.yaml 

```

Verify deployments 

```
kubectl get pods 

kubectl get deployment 

kubectl get service 

minikube service users-service –url 

minikube service tasks-service –url 

```

## Test Sample Application 

Test the application in the browser 

```
minikube service users-service 

minikube service tasks-service 
```

 

 
