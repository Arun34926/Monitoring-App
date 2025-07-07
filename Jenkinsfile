pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    ECR_REGISTRY = '425561689602.dkr.ecr.us-east-1.amazonaws.com'
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/Arun34926/Monitoring-App.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t system-monitor-app ./monitor-app'
      }
    }

    stage('Login to ECR') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'YOUR_AWS_CREDENTIALS_ID']]) {
          sh '''
            aws configure set default.region $AWS_REGION
            aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
          '''
        }
      }
    }

    stage('Tag and Push Image') {
      steps {
        sh '''
          docker tag system-monitor-app:latest $ECR_REGISTRY/system-monitor-app:latest
          docker push $ECR_REGISTRY/system-monitor-app:latest
        '''
      }
    }
  }
}
