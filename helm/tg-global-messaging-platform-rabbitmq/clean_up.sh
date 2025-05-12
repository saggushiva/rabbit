#!/bin/bash

kubectl delete secrets rabbitmq-definitions -n default
helm -n default uninstall rabbitmq -n default