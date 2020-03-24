node {
  def dockerImage

  stage('Clone repository') {
      /* Let's make sure we have the repository cloned to our workspace */

      checkout scm
  }

  stage('Compile war file') {
      /* Let's make sure we have the repository cloned to our workspace */

      sh './build.sh'
  }

  stage('Build image') {
      /* This builds the actual image; synonymous to
       * docker build on the command line */

      dockerImage = docker.build('luissncs/swe645-hw2-luis')
  }

  stage('Test image') {
      /* Ideally, we would run a test framework against our image.
       * For this example, we're using a Volkswagen-type approach ;-) */

      dockerImage.inside {
          sh 'echo "Tests passed"'
      }
  }

  stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            dockerImage.push('latest')
        }
    }

  stage("Deploy to kubernetes") {
        sh 'kubectl apply -f swe645-hw2-kubernetes.yaml'
        sh 'kubectl apply -f swe645-hw2-kubernetes.yaml'
  }
}
