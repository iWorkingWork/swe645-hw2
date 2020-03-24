# Homework 2 - SWE 645

## Part 1
* I used the template found here: <https://www.w3schools.com/w3css/tryw3css_templates_cafe.htm>

* I copied of the code from the w3schools website into my static website and deployed it to S3.

## Installation and Deployment:

### Instructions for CI/CD
https://aws.amazon.com/blogs/devops/setting-up-a-ci-cd-pipeline-by-integrating-jenkins-with-aws-codebuild-and-aws-codedeploy


1. Building a docker image:
```
docker build . --tag swe645-hw2-luis
```
#### Pushing image to dockerhub:

Created a DockerHub account and linked it with my existing GitHub account.

2. Login:
```
docker login --username=luissncs
```
3. Tag my docker image:
```
docker tag swe645-hw2-luis:latest luissncs/swe645-hw:swe645-hw2-luis_1
```
4. Push the image to DockerHub
```
docker push luissncs/swe645-hw
```
5. Pulling the image from DockerHub
```
docker pull luissncs/swe645-hw:swe645-hw2-luis_1
```
5. Running the the container
```
docker run -p 8080:8080 luissncs/swe645-hw:swe645-hw2-luis_1
```


### Setting up the EKS cluster.

These are the steps I used to set up my EKS cluster on AWS.
I followed the instructions here: https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html

This is a list of the steps I took:

1. Created my Amzon EKS service role in the IAM console.
2. Created my Amazon EKS Cluster VPC
  - Created a AWS CloudFormation stack.
  - stack name: eks-vpc-hw2-stack
  - SecurityGroups:	sg-074e95c97ef2d5c00
  - SubnetIds:	subnet-0cae20c8d1eaff303,subnet-002f4ca8bfa5ba07f,subnet-0e1470cafe7bfb4bf
  - VpcId:	vpc-06567fb518c2fb6c3

3. Installed kubectl
Followed these instructions to install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux

4. Installed the latest AWS CLI : https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html
-Configuring the AWS CLI:
I configured the AWS CLI, by running the following command:
```
aws configure
```
Then I input my aws credentials in the CLI prompts. I selected the JSON output format.
Then I used the aws cli tool to create a kubeconfig for my cluster with the following command:
```
aws eks --region us-east-1 update-kubeconfig --name swe645-hw2-cluster
```

I was then able to test my k8s configuration with:
```
kubectl get svc
```
This is the output I got:

| NAME        | TYPE       | CLUSTER-IP  | EXTERNAL-IP  | PORT(S)  | AGE  |
| ------------|:----------:|:-----------:|:------------:|:--------:|:----:|
| kubernetes  | ClusterIP  | 10.100.0.1  | \<none\>     | 443/TCP  | 16m  |


5. Followed the steps to create My amazon EKS Cluster named: swe645-hw2-cluster

### Launch a Managed Node Group
1. Created my Amazon EKS worker node role in the IAM console

https://console.aws.amazon.com/eks/home?region=us-east-1#/clusters/swe645-hw2-cluster

After creating my managed node group I was able to watch the status of my nodes with the following command:
```
kubectl get nodes --watch
```


### Deploying containarized application to EKS:
https://aws.amazon.com/getting-started/projects/deploy-kubernetes-app-amazon-eks/



### Jenkins

I installed Jenkins and have it running on my ec2 instance.
http://ec2-18-206-252-238.compute-1.amazonaws.com:8080/manage

Installing Jenkins and some dependecies to build my docker image.
```
sudo yum update -y
sudo yum install -y docker
sudo yum install -y jenkins
sudo yum install -y java-1.8.0-openjdk
sudo yum install -y git
sudo yum install -y java-devel
```

Install kubernetes:
```
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

```

Install the AWS CLI tool:
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Configure The AWS CLI tool
```
aws configure
```
Configure The AWS CLI to work with kubectl:
```
aws eks --region us-east-1 update-kubeconfig --name swe645-hw2-cluster
```


- Start Jenkins:
```
sudo service jenkins start
```

- Setup Jenkins to pull from my GitHub repository.

#### Compilation:

-   Import the swe645-hw1-luis project located in the source_files directory into eclipse.
    From within eclipse, right-click project and export as war.

#### Deployment on tomcat:

-   Copy war file to the webapps directory on tomcat.
-   On the bitnami tomcat AMI, copy to: /opt/bitnami/tomcat/webapps/
-   sudo is required when copying over to the webapps directory.

## AWS Links:

-   Part1 S3 Homepage:
    <http://luis-asencios-homepage-swe645.s3-website-us-east-1.amazonaws.com>

-   Part2 EC2 Survey:
    <http://ec2-54-224-213-97.compute-1.amazonaws.com/swe645-hw1-luis/survey.html>
