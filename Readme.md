# Setup a fully automated CI/CD system in public cloud

## Goal

The goal of this project is to show how to setup a fully automated CI/CD system
in public cloud. All code changes in git will trigger a build and test pipeline
that will generate a new Docker image that will be deployed using Kubernetes.

I will provide enough details in this project so that anyone can clone this repo and
will be able to follow along to replicate the exact setup


## Prerequisites
For this project, i have chosen the following tools:- 

- AWS as our choice of public cloud
- Jenkins server running on EC2(AWS)
- Jenkins plugins for various integrations:-
  - [CloudBees Docker Build and Publish](https://plugins.jenkins.io/docker-build-publish/)
  - [CloudBees AWS Credentials](https://plugins.jenkins.io/aws-credentials/)
  - [BlueOcean](https://plugins.jenkins.io/blueocean/) 
  - [Credentials](https://plugins.jenkins.io/credentials/)
  - [Pipeline AWS Steps](https://plugins.jenkins.io/pipeline-aws/)
  - [Pipeline SCM Step](https://plugins.jenkins.io/workflow-scm-step/)
- eksctl cli to deploy Kubernetes clusters on AWS
- aws cli
- Kubectl 


## Steps

### Build a local docker image for a nginx based Webserver
- create index.html with a custom message
- create Dockerfile 

### Test this docker image locally using Docker Desktop

```
docker build -t anjalicurie/mynginx .
docker run -p 80:80 anjalicurie/mynginx
curl localhost:80

<!doctype html>
<html>
  <head>
    <title>Static HTML Site</title>
  </head>
  <body>
    <p>Hello World! my name is AJ <strong>CSS</strong> or <strong>JavaScript</strong>.</p>
  </body>
</html>

```

### Setup a dockerhub account

- create a new repository

### Push your docker image to dockerhub

```
docker login -u anjalicurie
docker push anjalicurie/mynginx
```

### Setup Kubernetes using docker for desktop

### deploy your nginx webserver in kubernetes on docker Desktop

```
kubectl apply -f ./blue.yaml
```

### Setup a EC2 Server on AWS with Ubuntu image

This is currently done using the AWS console. Later this project will be enhanced to do this
using CloudFormation.


### Install Jenkins on EC2 Server running Ubuntu
Steps are present in `jenkins/install-jenkins.sh`

### Install docker on EC2 Server running Ubuntu
Steps are present in `jenkins/install-docker.sh`


### Install aws cli on EC2 Server running Ubuntu
```
sudo apt-get update
sudo apt-get install awscli
aws --version

```

### Install kubectl cli on EC2 Server running Ubuntu
```
snap install kubectl --classic
kubectl version --client
```

### Install eksctl cli on EC2 Server running Ubuntu


### Install EKS Cluster using eksctl
```
eksctl create cluster --name <name of cluster> --nodes=2
```

### Configure jenkins server

#### Store dockerhub credentials
- Manage Jenkins--->Manage Credentials
- go to Global store
- Add Credentials
- Scope Global 
- Kind is "Username with Password"

#### Store AWS credentials
Manage Jenkins--->Manage Credentials
- go to Global store
- Add Credentials
- Scope Global 
- Kind is "AWS Credentials"

#### Store git token credentials 

### Connect your github repo with Jenkins server

### Create Jenkinsfile in your git repo with the following stages

* Stage 1 Clone repository
```
checkout scm
```

* Stage 2 Build docker image with build number as docker tag
Note we use the built environment variable BUILD_ID to tag the docker image

```
app = docker.build("mynginx:${env.BUILD_ID}")
```

* Stage 3 Push built docker image to dockerhub with right tag
Login to dockerhub and push built docker image to it
```
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker tag mynginx:${env.BUILD_ID} anjalicurie/mynginx:${env.BUILD_ID}"
docker push anjalicurie/mynginx:${env.BUILD_ID}"
```

* Stage 4 Get the kubeconfig file for the deployed Kubernetes cluster from AWS
```
aws eks --region us-west-2 update-kubeconfig --name fabulous-wardrobe-1597385869
```
 
* Stage 5 Deploy a blue version of your application container using Kubernetes
Note, here we replace BUILD_TAG variable in blue.yaml with the value of the BUILD_ID environment variable
This ensures, that kubectl apply will always apply the latest built docker image to Kubernetes cluster
```
sed  -i -e \"s/BUILD_TAG/${env.BUILD_ID}/g\" blue.yaml
kubectl apply -f blue.yaml
```

* Stage 6 Test it using port forwarding
```
kubectl port-forward deployment/nginx-deployment 7000:80

curl localhost:7000
<!doctype html>
<html>
  <head>
    <title>Static HTML Site</title>
  </head>
  <body>
    <p>Hello World! my name is AJ <strong>CSS</strong> or <strong>JavaScript</strong>.</p>
  </body>
</html>

```

### Tear down everything and save cost
```
eksctl delete cluster
```

### Debugging Jenkins

["No Valid Crumb was included in the request"](https://github.com/jnanjali/OnPremToAWSMigration/wiki/No-Valid-Crumb-was-included-in-the-request)
