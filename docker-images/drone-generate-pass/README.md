![](/images/container-registry.png "Azure Container Registry")
# Drone Tool: Generate Pass

## Introducción

Este proyecto contempla la creación de una herramienta que genera un password de manera dinámica, dejando el resultado en [vault-retail](https://vault.walmartretail.cl).

## Uso de la herramienta

Para utilizar la herramienta, debemos configurar un step en un pipeline de Drone. Usaremos el siguiente ejemplo:

---- 
```
[STEP_NAME]:
    group: [GROUP_NAME]
    pull: true
    image: [CONTAINER_REGISTRY]/drone-generate-pass:latest
    vault_secret_path: [VAULT_PATH]
    environment:
      - VAULT_ADDR= [VAULT_ADDR]
    secrets:
      - source: vault_token
        target: VAULT_TOKEN
```
---- 

Para utilizar la herramienta, debemos previamente configurar en drone los siguientes secretos:

- Registry Secrets

- Vault-Token 

Los anteriores deben ser solicitados al hombre de la semana por Slack #the-10th-man

Una vez ejecutado este pipeline, el resultado será almacenado en Vault en el [VAULT_PATH] definido en el pipeline.


## Referencias

  - [Generate a strong password in Linux](https://www.ostechnix.com/4-easy-ways-to-generate-a-strong-password-in-linux/)
  - [Vault KV Commands](https://www.vaultproject.io/docs/commands/kv/index.html)
