#!/bin/bash

BASE_PATH="/home/assettracker/cloud_assettracker"

if [ "$1" = "restapi" ]; then

        echo "deleting asset-restapi-inbound !!" 

        kubectl delete -f $BASE_PATH/asset-restapi-inbound.yaml
        echo

        kubectl get all


elif [ "$1" = "dsb" ]; then

        echo "deleting data-server-backend !!"

        kubectl delete -f $BASE_PATH/data-server-backend.yaml
        echo

        kubectl get all


elif [ "$1" = "dsf" ]; then


        echo "deleting data-server-frontend !!"

        kubectl delete -f $BASE_PATH/data-server-frontend.yaml
        echo

        kubectl get all


elif [ "$1" = "ws" ]; then

        echo "deleting asset-websocket-inbound !!"

        kubectl delete -f $BASE_PATH/asset-websocket-inbound.yaml
        echo

        kubectl get all

elif [ "$1" = "db" ]; then

        echo "deleting asset-db-outbound !!"

        kubectl delete -f $BASE_PATH/asset-db-outbound.yaml
        echo

        kubectl get all

elif [ "$1" = "ai" ]; then

        echo "deleting asset-azure-info !!"

        kubectl delete -f $BASE_PATH/asset-azure-info.yaml
        echo

        kubectl get all


elif [ "$1" = "all" ]; then

        echo "deleting all !!"

        kubectl delete -f $BASE_PATH/asset-restapi-inbound.yaml
        kubectl delete -f $BASE_PATH/data-server-backend.yaml
        kubectl delete -f $BASE_PATH/asset-db-outbound.yaml
        kubectl delete -f $BASE_PATH/asset-websocket-inbound.yaml
        kubectl delete -f $BASE_PATH/data-server-frontend.yaml
        kubectl delete -f $BASE_PATH/asset-azure-info.yaml

        echo

        kubectl get all
else
        echo
        echo "====== Cmd line utility ======"
        echo " asset-restapi-inbound:       ./ delete.sh restapi "
        echo " data-server-backend:   ./delete.sh dcb "
        echo " asset-db-outbound:            ./delete.sh db "
        echo " asset-websocket-inbound:         ./delete.sh ws "
        echo " data-server-frontend:                ./delete.sh dsf "
        echo " asset-azure-info:                ./delete.sh ai "
        echo " all micro services:                ./delete.sh all "
        
        echo

        exec "$@"
fi