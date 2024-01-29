#!/bin/bash
sudo apt update -y
sudo apt install -y ruby-full ruby-bundler build-essential

wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update -y
sudo apt install -y mongodb-org --allow-unauthenticated
sudo systemctl start mongod
sudo systemctl enable mongod

git clone -b monolith https://github.com/express42/reddit.git
sudo gem install bundler:1.16.1 
cd reddit && sudo bundle install
puma -d