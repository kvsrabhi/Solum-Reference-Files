#!/bin/bash

kubectl delete configmap inbound-configmap
kubectl delete configmap outbound-configmap
kubectl delete configmap imagegenerator-configmap
kubectl delete configmap api-configmap
kubectl delete configmap scheduler-configmap
kubectl delete configmap dboperator-configmap
kubectl delete configmap ld-configmap
kubectl delete configmap lbs-configmap
kubectl delete configmap onlinesw-configmap
kubectl delete configmap dashboard-configmap
kubectl delete configmap ikea-configmap
kubectl delete configmap realtime-configmap
kubectl delete configmap squarepos-configmap