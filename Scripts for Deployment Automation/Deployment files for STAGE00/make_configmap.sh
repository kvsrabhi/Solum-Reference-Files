#!/bin/bash

#Inbound
kubectl create configmap inbound-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/inbound/inbound.properties --from-file=/home/common00/git_cloud_common00/azure.properties

#Outbound
kubectl create configmap outbound-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/outbound/outbound.properties --from-file=/home/common00/git_cloud_common00/azure.properties

#Img Generator
kubectl create configmap imagegenerator-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/image-generator/imagegenerator.properties --from-file=/home/common00/git_cloud_common00/azure.properties

#Api Service Common
kubectl create configmap api-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-apiservice-common/apiservice.properties --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-apiservice-common/azureADB2C.properties --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-apiservice-common/monitor.properties --from-file=/home/common00/git_cloud_common00/azure.properties

#Scheduler Common
kubectl create configmap scheduler-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-scheduler-common/scheduler.properties --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-scheduler-common/scheduler.json --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-scheduler-common/schedulerADB2C.properties

#Db operator
kubectl create configmap dboperator-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/db-data-operator/dbdataoperator.properties --from-file=/home/common00/git_cloud_common00/azure.properties

#LD
kubectl create configmap ld-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-ld/app-config.json --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-ld/properties.json --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-ld/azure-config.json --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-ld/font-family.json --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-ld/font-family-added.json --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-ld/fonts.css

#LBS Common
kubectl create configmap lbs-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-lbs-common/lbs.properties --from-file=/home/common00/git_cloud_common00/azure.properties

#Online SW
kubectl create configmap onlinesw-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-online-sw-interface/aims.portal.onlinesw.properties --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-online-sw-interface/application.properties

#Dashboard
kubectl create configmap dashboard-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/dashboard/azureConfig.js --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/dashboard/properties_cloud.json

#IKEA Converter Service
kubectl create configmap ikea-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-IKEA-converter/ikea_converter_service.properties --from-file=/home/common00/git_cloud_common00/azure.properties

#Realtime Service for Nike
kubectl create configmap realtime-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-realtime-service/realtime_inbound.properties --from-file=/home/common00/git_cloud_common00/azure.properties

#Sqaure Pos Service
kubectl create configmap squarepos-configmap --from-file=/home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-square-pos-service/squarePosService.properties