# Migrate your Infrastructure from BareMetal to AWS

The Goal of this project is to show how we can move a CI /CD system based on 
Jenkins and Kubernetes from on-prem to AWS using IAC. 

This project involves deploying a docker based Jenkins server on a bare metal 
server and a local kubernetes cluster using docker. In this project, Jenkins 
job triggers a github push, which deploys workload to a locally running
 Kubernetes cluster.

Then it takes all the local infrastructure and convert it to IAC using 
CloudFormation scripts. The CloudFormation brings up a Jenkins server in 
AWS and use a kubernetes plugin to deploy the same workload to a kubernetes cluster 
running in AWS.   Blue green deployment methodology is implemented. 
 I run tests against one version and then tear down the old version all using Jenkins 
and Kubernetes in a public cloud.
