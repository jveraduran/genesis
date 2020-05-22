#!/bin/bash
echo "Setting up environment variables"

export azure_tenant=
export azure_subscription=
export azure_client=
export azure_secret=

export ssh_key_labs=$(cat secrets/bastion-ssh-private-labs.key)
export ssh_key_prod=$(cat secrets/bastion-ssh-private-prod.key)
export ssh_deploy_public_key_labs=$(cat certs/ssh-deploy-public-key-labs.pem)
export ssh_deploy_public_key_prod=$(cat certs/ssh-deploy-public-key-prod.pem)
export ssh_deploy_private_key_labs=$(cat secrets/ssh-deploy-private-key-labs.pem)
export ssh_deploy_private_key_prod=$(cat secrets/ssh-deploy-private-key-prod.pem)
export sealed_secret_certificate_eastus2=$(cat certs/sealed-secret-certificate-eastus2.pem)
export sealed_secret_certificate_westus2=$(cat certs/sealed-secret-certificate-westus2.pem)
export sealed_secret_key_eastus2=$(cat secrets/sealed-secret-key-eastus2.pem)
export sealed_secret_key_westus2=$(cat secrets/sealed-secret-key-westus2.pem)

echo "Execute Drone pipeline"
drone exec --network genesis-dockernet

echo "Backing up local consul state"
timestamp=`date +\%Y\%m\%d\%H\%M\%S`
filename=snapshot_$timestamp.tgz
curl http://localhost:8500/v1/snapshot -o consul_backups/$filename
cp consul_backups/$filename consul_local/inicial_snapshot.tgz

if [ -f .env_file_labs ]; then
  rm .env_file_labs
fi

if [ -f .env_file_prod ]; then
  rm .env_file_prod
fi
