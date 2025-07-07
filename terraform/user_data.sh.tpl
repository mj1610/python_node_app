#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -xe

# Basic setup
apt update -y
apt install -y python3 python3-pip python3.12-venv git curl jq unzip sudo

# Install AWS CLI (manually since it's not in apt anymore)
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install Node.js (LTS 18)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# Clone your repo
cd /home/ubuntu
git clone https://github.com/mj1610/python_node_app.git

# Fetch Mongo URI from SSM Parameter Store
MONGO_URI=$(aws ssm get-parameter --name "/app/mongo_uri" --with-decryption --region ap-south-1 | jq -r '.Parameter.Value')
echo "MONGO_URI=$MONGO_URI" > /home/ubuntu/python_node_app/backend/.env
chown ubuntu:ubuntu /home/ubuntu/python_node_app/backend/.env

# Set permissions
chown -R ubuntu:ubuntu /home/ubuntu/python_node_app

# Install backend dependencies
cd /home/ubuntu/python_node_app/backend
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
nohup venv/bin/python app.py &

# Install frontend dependencies and start it
cd /home/ubuntu/python_node_app/frontend
npm install
nohup node app.js &