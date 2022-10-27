#!/bin/bash

#Rest-Inbound
kubectl create configmap rest-inbound-configmap --from-file=/home/assettracker/git_cloud_assettracker/slm-asset-config/ASIA/slm-asset-restapi-inbound/assetRestapiInbound.properties --from-file=/home/assettracker/git_cloud_assettracker/azure.properties

#Websocket-Inbound
kubectl create configmap ws-inbound-configmap --from-file=/home/assettracker/git_cloud_assettracker/slm-asset-config/ASIA/slm-asset-websocket-inbound/asset-websocket.properties --from-file=/home/assettracker/git_cloud_assettracker/azure.properties

#Frontend
kubectl create configmap data-server-frontend-configmap --from-file=/home/assettracker/git_cloud_assettracker/slm-asset-config/ASIA/slm-asset-data-server-frontend/properties_cloud.json --from-file=/home/assettracker/git_cloud_assettracker/azure.properties

#Backend
kubectl create configmap data-server-backend-configmap --from-file=/home/assettracker/git_cloud_assettracker/slm-asset-config/ASIA/slm-asset-data-server-backend/dataServer.properties --from-file=/home/assettracker/git_cloud_assettracker/slm-asset-config/ASIA/slm-asset-data-server-backend/monitor.properties --from-file=/home/assettracker/git_cloud_assettracker/azure.properties

#DB-Outbound

kubectl create configmap db-outbound-configmap --from-file=/home/assettracker/git_cloud_assettracker/slm-asset-config/ASIA/slm-asset-db-outbound/assetdboutbound.properties --from-file=/home/assettracker/git_cloud_assettracker/azure.properties

#Azure-Info 

kubectl create configmap azure-info-configmap --from-file=/home/assettracker/git_cloud_assettracker/slm-asset-config/ASIA/slm-asset-azure-info/assetazureinfo.properties --from-file=/home/assettracker/git_cloud_assettracker/azure.properties