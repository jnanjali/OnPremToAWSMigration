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
  - [ CloudBees Docker Build and Publish] (https://plugins.jenkins.io/docker-build-publish/)
  - [ CloudBees AWS Credentials ] (https://plugins.jenkins.io/aws-credentials/)
  - [ BlueOcean] (https://plugins.jenkins.io/blueocean/) 
  - [ Credentials] (https://plugins.jenkins.io/credentials/)
  - [ Pipeline AWS Steps] (https://plugins.jenkins.io/pipeline-aws/)
  - [ Pipeline SCM Step] (https://plugins.jenkins.io/workflow-scm-step/)
- eksctl cli to deploy Kubernetes clusters on AWS
- aws cli
- Kubectl 


## Steps

### Build a local docker image for a nginx based Webserver
- create index.html with a custom message
- create Dockerfile 

### Test this docker image locally using Docker Desktop
docker build -t anjalicurie/mynginx
docker run -p 80:80 anjalicurie/mynginx

curl localhost:80

you should see your customized response here

### Setup a dockerub account


### Push your docker image to dockerhub

### Setup Kubernetes using docker for desktop

### deploy your nginx webserver in kubernetes on docker Desktop

### Setup a EC2 Server on AWS with Ubuntu image

This is currently done using the AWS console. Later this project will be enhanced to do this
using CloudFormation.

### Install Jenkins on EC2 Server running Ubuntu
Steps are present in jenkins/install-jenkins.sh

### Install docker on EC2 Server running Ubuntu
Steps are present in jenkins/install-docker.sh


### Install aws cli on EC2 Server running Ubuntu

### Install kubectl cli on EC2 Server running Ubuntu


### Install eksctl cli on EC2 Server running Ubuntu


### Install EKS Cluster using eksctl

### Configure jenkins server

#### Store dockerhub credentials


#### Store AWS credentials

#### Store git token credentials 

### Connect your github repo with Jenkins server

### Create Jenkinsfile in your git repo

#### Stage 1 Clone repository

#### Stage 2 Build docker image with build number as docker tag

#### Stage 3 Push built docker image to dockerhub with right tag

#### Stage 4 Get the kubeconfig file for the deployed Kubernetes cluster from AWS
 
#### Stage 5 Deploy a blue version of your application container using Kubernetes

#### Stage 6 Test it using port forwarding

### Tear down everything and save cost
