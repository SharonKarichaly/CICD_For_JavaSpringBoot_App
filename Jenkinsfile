pipeline {
  agent {
    docker {
      image 'kishgi/maven-docker-agent:v1'
      args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
      reuseNode true
    }
  }

  stages {
    stage('Clean Workspace') {
      steps {
        sh 'rm -rf target'
      }
    }

    stage('Checkout') {
      steps {
        sh 'echo passed'
        git branch: 'master', url: 'https://github.com/SharonKarichaly/CICD_For_JavaSpringBoot_App.git'
      }
    }

    stage('Build and Test') {
      steps {
        sh 'ls -ltr'
        sh 'mvn clean package' // build the project and create a JAR file
      }
    }

    stage('Static Code Analysis') {
      environment {
        SONAR_URL = "http://172.24.163.82:9000"
      }
      steps {
        withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
          sh 'mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}'
        }
      }
    }

    stage('Build and Push Docker Image') {
      environment {
        REGISTRY_CREDENTIALS = credentials('docker-cred') // Jenkins credential ID
      }
      steps {
        script {
          def dockerImage = "ksharon/ultimate-cicd:${BUILD_NUMBER}"

          sh "docker build -t ${dockerImage} ."

          withDockerRegistry([credentialsId: 'docker-cred', url: 'https://index.docker.io/v1/']) {
            sh "docker push ${dockerImage}"
          }
        }
      }
    }

    stage('Update Deployment File') {
      environment {
        GIT_REPO_NAME = "CICD_For_JavaSpringBoot_App"
        GIT_USER_NAME = "SharonKarichaly"
      }
      steps {
        withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
          sh '''
            git clone https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}.git
            cd ${GIT_REPO_NAME}
            git config user.email "ksharon093@gmail.com"
            git config user.name "SharonKarichaly"
            BUILD_NUMBER=${BUILD_NUMBER}
            sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" manifests/deployment.yaml
            git add manifests/deployment.yaml
            git commit -m "Update deployment image to version ${BUILD_NUMBER}"
            git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
          '''
        }
      }
    }
  }
}
