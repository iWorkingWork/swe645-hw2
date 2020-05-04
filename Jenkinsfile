node {
  def dockerImage

  stage('Clone repository') {
      // Checkout my GitHub repository
      checkout scm
  }

  stage('Compile war file') {
      // This script builds a war file.
      sh './build.sh'
  }

  stage('Build image') {
      // Build my docker image.
      dockerImage = docker.build("luissncs/swe645-hw2-luis:latest")
  }

  stage('Push image') {
        // Push image to dockerhub
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            dockerImage.push("latest")
        }
    }

  stage("Deploy to kubernetes (EKS)") {
        // Run script that deploys our updated images        
        sh 'sudo runuser -l ubuntu -c "${WORKSPACE}/kubernetes_deploy.sh"'
  }
}
