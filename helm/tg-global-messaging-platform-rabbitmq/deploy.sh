#!/bin/bash


CURRENT_DIR=$(
    cd $(dirname $0)
    pwd
)

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update


namespace=default

function utils::get_helm_mode() {
    if helm status $* >/dev/null 2>&1;  then
        echo "Helm chart  '$1' already exist => upgrade mode" >&2
        echo "upgrade"
    else
        echo "Helm chart '$1' doesnot exist => install mode" >&2
        echo "install"
    fi
}

mode=$(utils::get_helm_mode rabbitmq -n $namespace)

kubectl create secret generic rabbitmq-definitions --from-file=load_definition.json=files/definitions.json -n $namespace
#kubectl create configmap load-definition --from-file=load_definition.json=files/definitions.json -n $namespace

helm $mode rabbitmq /helm/tg-global-messaging-platform-rabbitmq -f values.yaml -n $namespace \
 --set rabbitmq.auth.username=admin \
 --set rabbitmq.auth.password=bitnami

if [ $? -ne 0 ]; then 
    echo "Failed to deploy Rabbit MQ"
    exist 1
fi