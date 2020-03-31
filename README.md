# Homework 2 - SWE 645
Disclaimer: I've only tested my project on an Ubuntu machine. Steps to run things might vary for other OSes.

## Part 1
* I used the template found here: <https://www.w3schools.com/w3css/tryw3css_templates_cafe.htm>

* I copied the template code from the w3schools website into my static website modified as needed and deployed the updated files to S3.

### AWS S3 Link:
http://swe645-hw2.s3-website-us-east-1.amazonaws.com/


## Part 2:
### Containerize the application
- I containerized my app and created a Dockerfile.
- How to build a image and run a container locally:
  - First, head over to the source_files/swe645-hw2-luis directory
  ```
   cd source_files/swe645-hw2-luis directory
   ```
  - Then, build a war file of the application.
  ```
  ./build.sh
  ```
  - That should build this file: swe645-hw2-luis.war
  - Then, build a docker image:
  ```
    docker build -t luissncs/swe645-hw2-luis:latest .
  ```
  - Run the container:
  ```
  docker run -p 80:80 luissncs/swe645-hw2-luis:latest
  ```
  - You should now be able to go to the app's url:http://localhost:8080/swe645-hw2-luis/survey.html
  - You can also go to the homepage: http://localhost:8080/swe645-hw2-luis/

### Pushing/Pulling image to/from dockerhub:
- I run the following commands to push my image to my public dockerhub repository:
```
docker login --username=luissncs
docker push luissncs/swe645-hw2-luis:latest
```
- We can then pull the image and run the container:
```
docker pull luissncs/swe645-hw2-luis:latest
docker run -p 80:80 luissncs/swe645-hw2-luis:latest
```

### Deploy the containerized application
  - I used EKS to install kubernetes on a c2 cluster.
  - I followed the instructions here to provision EKS using the AWS consoloe:
  https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html

  - I provisioned a EC2 instance running Ubuntu18.04. This is where I installed kubectl, the aws cli client, and Jenkins.

  - I installed kubectl following these instructions:
  https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux

  -I install the AWS CLI version 2 on my Ubuntu EC2 instance following these instructions:
  https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2
  -linux.html

  - Then I created my Amazon EKS Cluster

  - Then I created a kubeconfig file for my cluster with the AWS CLI update-kubeconfig command:
  ```
  aws eks --region us-east-1 update-kubeconfig --name hw2-cluster
  kubectl get svc
  ```
  - This is the output of my configuration:


  - Finally, I launched my managed node group:
