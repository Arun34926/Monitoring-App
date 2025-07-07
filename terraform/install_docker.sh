#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user
docker run -d -p 5000:5000 YOUR_ECR_IMAGE_URL:latest
