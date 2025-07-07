pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    IMAGE_NAME = 'system-monitor-app'
    ECR_URL = '<425561689602.dkr.ecr.us-east-1.amazonaws.com/system-monitor-app>'
  }

  stages {
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE_NAME ./monitor-app'
      }
    }

    stage('Login to ECR') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh '''
            aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
            aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
            aws configure set default.region $AWS_REGION

            aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
          '''
        }
      }
    }

    stage('Tag and Push Image') {
      steps {
        sh '''
          docker tag $IMAGE_NAME:latest $ECR_URL/$IMAGE_NAME:latest
          docker push $ECR_URL/$IMAGE_NAME:latest
        '''
      }
    }

    stage('Terraform Deploy') {
      steps {
        dir('terraform') {
          sh 'terraform init'
          sh 'terraform apply -auto-approve -var="key_name=devops"'
        }
      }
    }
  }
}
