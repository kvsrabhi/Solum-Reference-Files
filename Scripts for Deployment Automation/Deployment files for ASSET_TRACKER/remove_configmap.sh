#!/bin/bash

kubectl delete configmap rest-inbound-configmap
kubectl delete configmap ws-inbound-configmap
kubectl delete configmap data-server-frontend-configmap
kubectl delete configmap data-server-backend-configmap
kubectl delete configmap db-outbound-configmap
kubectl delete configmap azure-info-configmap