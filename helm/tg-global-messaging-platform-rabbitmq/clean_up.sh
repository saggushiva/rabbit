#!/bin/bash

kubectl delete secrets load-definition -n default
helm -n default uninstall rabbitmq -n default