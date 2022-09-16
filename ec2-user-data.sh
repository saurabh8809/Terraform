#!/bin/bash
sudo yum update -y && sudo yum install docker -y
sudo systemctl start docker 
sudo systemctl enable docker 
sudo usermod -aG docker ec2-user
sudo docker run -itd -p 8080:80 --name web-app nginx
