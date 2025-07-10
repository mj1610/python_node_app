#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -xe

apt update -y
apt install -y nodejs npm git

cd /home/ubuntu
git clone https://github.com/mj1610/python_node_app.git

cd /home/ubuntu/python_node_app/frontend

echo "BACKEND_URL=${backend_url}" > .env
chown ubuntu:ubuntu .env

npm install
nohup node app.js &