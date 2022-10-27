#!/bin/bash

BASE_PATH="/home/assettracker/cloud_assettracker"

if [ "$1" = "restapi" ]; then

        echo "deploying asset-restapi-inbound !!" 

        kubectl apply -f $BASE_PATH/asset-restapi-inbound.yaml
        echo

        kubectl get all


elif [ "$1" = "dsb" ]; then

        echo "deploying data-server-backend !!"

        kubectl apply -f $BASE_PATH/data-server-backend.yaml
        echo

        kubectl get all


elif [ "$1" = "dsf" ]; then


        echo "deploying data-server-frontend !!"

        kubectl apply -f $BASE_PATH/data-server-frontend.yaml
        echo

        kubectl get all


elif [ "$1" = "ws" ]; then

        echo "deploying asset-websocket-inbound !!"

        kubectl apply -f $BASE_PATH/asset-websocket-inbound.yaml
        echo

        kubectl get all

elif [ "$1" = "db" ]; then

        echo "deploying asset-db-outbound !!"

        kubectl apply -f $BASE_PATH/asset-db-outbound.yaml
        echo

        kubectl get all

elif [ "$1" = "ai" ]; then

        echo "deploying asset-azure-info !!"
  
        kubectl apply -f $BASE_PATH/asset-azure-info.yaml
        echo

        kubectl get all


elif [ "$1" = "all" ]; then

        echo "deploying all !!"

        kubectl apply -f $BASE_PATH/asset-restapi-inbound.yaml
        kubectl apply -f $BASE_PATH/data-server-backend.yaml
        kubectl apply -f $BASE_PATH/asset-db-outbound.yaml
        kubectl apply -f $BASE_PATH/asset-websocket-inbound.yaml
        kubectl apply -f $BASE_PATH/data-server-frontend.yaml
        kubectl apply -f $BASE_PATH/asset-azure-info.yaml
        echo

        kubectl get all
else
        echo
        echo "====== Cmd line utility ======"
        echo " asset-restapi-inbound:       ./run.sh restapi "
        echo " data-server-backend:   ./run.sh dsb "
        echo " asset-db-outbound:            ./run.sh db "
        echo " asset-websocket-inbound:         ./run.sh ws "
        echo " data-server-frontend:                ./run.sh dsf "
        echo " asset-azure-info:                    ./run.sh ai "
        echo " all micro services:                ./run.sh all "
       
        echo

        exec "$@"
fi