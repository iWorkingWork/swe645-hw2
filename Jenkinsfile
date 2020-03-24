node {
  def dockerImage
  environment {
    registry = "luissncs/swe645-hw2-luis"
    registryCredential = ‘dockerhub’
  }


  stage('Clone repository') {
      /* Let's make sure we have the repository cloned to our workspace */

      checkout scm
  }

  stage('Compile war file') {
      /* Let's make sure we have the repository cloned to our workspace */

      ./build.sh
  }

  stage('Build image') {
      /* This builds the actual image; synonymous to
       * docker build on the command line */

      dockerImage = docker.build("swe645-hw2-luis:latest")
  }

  stage('Test image') {
      /* Ideally, we would run a test framework against our image.
       * For this example, we're using a Volkswagen-type approach ;-) */

      dockerImage.inside {
          sh 'echo "Tests passed"'
      }
  }

  stage('Push Image') {
    steps{
      script {
        docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
        }
      }
    }
  }

  stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
}
