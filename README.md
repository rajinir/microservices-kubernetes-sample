# microservices-kubernetes-sample

Hope you have a VM with ubuntu and atleast 2VCPUs, 16GB RAM and 30GB HardDisk

## Section1. Pre-Reqs – Done
 
1. Login using ssh and run the pre_reqs script


```
git clone https://github.com/rajinir/microservices-kubernetes-sample 

cd microservices-kubernetes-sample/setup  

install_pre-reqs.sh 
```


## Section2. Deploy Minikube and Kubectl

1. Install minikube and kubectl 

Run the script install_minikube.sh 

```
setup\install_minikube.sh 
```


Or run them individually


2. Installing kubectl

Download latest stable release of kubectl and install


```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl 
chmod +x ./kubectl 
sudo mv ./kubectl /usr/local/bin/kubectl 

```

Test to ensure the version you installed is up-to-date:

```
kubectl version

```

3. Install minikube 

Installing minikube via directl download

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 
chmod +x minikube 
sudo mv minikube /usr/local/bin/ 
```

## Section3. Running Minikube 

1. Start minikube and create a cluster

Takes few minutes(3-4 mins ). Downloads the minikube iso VM boot image, creates a tiny virtual box Vm with 2 CPUs, 2GB RAM and 20GB disk. Prepares kubernetes v1.6.0 which is the stable release, pulls the images into the docker engine, launches kubernetes etc.. 

```
minikube start 

or for more details use the verbose option

minikube start -v=10
```

2. Run minikube status and verify, minikube – vm is at ip 198.168.99.100 

```
minikube status 
```

3. Run minikube ssh and check the images in the local docker engine
```
minikube ssh 
docker images 
exit 
```

4. Bring up the minikube dashboard and explore

```
minikube dashboard  
bg&

```

5. Interact with kube ctl 

Run few kubectl commands 

```
kubectl get deployments 
kubectl get pods 
kubectl get service 
```

## Section4. Deploy MongoDB Pod  

To setup mongodb on kubernets, you need these descriptors 
Examing the mongo.yaml and mongo-service.yaml

- PersistantVolume
- PersistantCliam
- Deployment 
- Service 

1. Deploy the mongodb in a pod using the script build_and_deploy_mongo.sh or run each command  

```
cd microservers-kubernetes-sample\kubernetes

vi mongo.yaml
vi mongo-service.yaml

```

2. Set the docker env to the docker engine running on the minikube
```
eval $(minikube docker-env) 
```

3. Pull the mongo latest container image into the docker 
```
docker pull mongo:latest 
```

4. List the images and verify 

```
docker images | grep mongo 
```


5. Deploy the mongo into kubernetes, open mongo.yaml and learn about persistant volume, persistant volume Cliams etc... 

```
kubectl create –f mongo.yaml 
```

6. Expose the deployment as a service 

```
kubectl apply -f mongo-service.yaml 
```

7. Now verify the deployments

Use kubectl and list the persistant volumes, cliams, deployments, services and pods


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

docker build -f Dockerfile -t users:latest .

cd ..  

cd app/taskservice 

docker build -f Dockerfile -t tasks:latest .

cd .. && cd .. 

```

5. Apply the deployment files 

```
cd kubernetes 

kubectl apply -f deployment_users.yaml 

kubectl apply -f deployment_tasks.yaml 

```

6. Verify deployments using kubectl

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

 

 
