#!/bin/sh
if [ -z $PLUGIN_VAULT_SECRET_PATH ]; then
  echo "VAULT SECRET PATH attribute not set"
fi

echo "Check if Secret key already exist"
vault kv get $PLUGIN_VAULT_SECRET_PATH > /dev/null

if [ $? -eq 0 ]; then
  echo "Secret found at $PLUGIN_VAULT_SECRET_PATH, skipping key creation"
else
  echo "Secret not found, moving on to key creation"
  export SECRET_PASS=`openssl rand -base64 32  | cut -c1-32`
  vault kv put $PLUGIN_VAULT_SECRET_PATH password=$SECRET_PASS
fi