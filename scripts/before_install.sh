#!/bin/bash
# Update system
sudo apt update -y

# Enable and install nginx 
sudo apt-get install nginx -y

# Start and enable nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Install Node.js from Amazon
sudo apt-get install nodejs -y

# Install CodeDeploy Agent
sudo apt install ruby-full -y
cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo systemctl status codedeploy-agent

# Clean previous deployment
sudo rm -rf /var/www/html/*