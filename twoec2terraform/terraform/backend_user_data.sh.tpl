#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -xe

apt update -y
apt install -y python3 python3-pip python3.12-venv git curl

cd /home/ubuntu
git clone https://github.com/mj1610/python_node_app.git

cd /home/ubuntu/python_node_app/backend
echo "MONGO_URI=${mongo_uri}" > .env

python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
nohup venv/bin/python app.py &
