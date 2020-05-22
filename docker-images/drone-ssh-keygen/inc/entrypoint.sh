#!/bin/sh
if [ -z $PLUGIN_VAULT_SSH_SECRET_PATH ]; then
  echo "vault_secret_path plugin attribute not set"
fi

echo "Check if SSH keys already exist"
vault kv get $PLUGIN_VAULT_SSH_SECRET_PATH > /dev/null

if [ $? -eq 0 ]; then
  echo "Secret found at $PLUGIN_VAULT_SSH_SECRET_PATH, skipping key creation"
else
  echo "Secret not found, moving on to key creation"
  ssh-keygen -q -t rsa -P "" -f id_rsa -C ""
  vault kv put $PLUGIN_VAULT_SSH_SECRET_PATH id_rsa=@id_rsa id_rsa_pub=@id_rsa.pub
fi