#!/bin/bash
if [ ! -f /usr/local/bin/drone ]; then
  echo "Drone not found!"
  echo "Installing drone"
  curl -L https://github.com/drone/drone-cli/releases/download/v0.8.6/drone_darwin_amd64.tar.gz | tar zx
  mv drone /usr/local/bin
fi

if [ ! "$(docker network ls | grep genesis-dockernet)" ]
then
  echo "Network genesis-dockernet  not found"
  echo "Creating network genesis-dockernet"
  docker network create -d bridge --subnet 192.168.0.0/24 --gateway 192.168.0.1 genesis-dockernet
else
  echo "Network already exists, do nothing"
fi

if [ ! "$(docker ps | grep consul)" ] 
then
  echo "Starting up local instance of consul"
  docker-compose -f consul_local/consul_local.yml up -d
  echo "Waiting for consul to get up"
  sleep 8

  echo "Restoring consul snapshot"
  curl --request PUT --data-binary @consul_local/inicial_snapshot.tgz http://localhost:8500/v1/snapshot
else
  echo "Consul already running"
fi

if [ ! "$(docker ps | grep vault)" ] 
then
  echo "Starting up local instance of vault"
  docker rm -f vault
  export VAULT_TOKEN="$(uuidgen)"
  echo $VAULT_TOKEN >> ~/.bashrc
  echo "El Token de Vault es: $VAULT_TOKEN"
  docker-compose -f vault-local/vault-local.yml up -d
  echo "Waiting for vault to get up"
  sleep 2
else
  docker stop vault
  export VAULT_TOKEN="$(uuidgen)"
  echo $VAULT_TOKEN >> ~/.bashrc
  echo "El Token de Vault es: $VAULT_TOKEN"
  docker-compose -f vault-local/vault-local.yml up -d
  echo "Waiting for vault to get up"
  sleep 2
  echo "Vault already running"
fi

echo "Building Docker Images"

if [ ! "$(docker images | grep drone-packer)" ] 
then
  echo "Building drone-packer Image"
  docker build -t drone-packer -f docker-images/drone-packer/Dockerfile .
else
  echo "drone-packer Image Already Exist"
  sleep 2
fi

if [ ! "$(docker images | grep drone-consul)" ] 
then
  echo "Building drone-consul Image"
  docker build -t drone-consul -f docker-images/drone-consul/Dockerfile .
else
  echo "drone-consul Image Already Exist"
  sleep 2
fi

if [ ! "$(docker images | grep drone-ssh-keygen)" ] 
then
  echo "Building drone-ssh-keygen Image"
  docker build -t drone-ssh-keygen -f docker-images/drone-ssh-keygen/Dockerfile .
else
  echo "drone-ssh-keygen Image Already Exist"
  sleep 2
fi

if [ "$(docker ps | grep vault)" ] 
then
  clear
  echo "Running Drone Pipeline"
  sh ./deploy_cluster.sh
  sleep 2
fi