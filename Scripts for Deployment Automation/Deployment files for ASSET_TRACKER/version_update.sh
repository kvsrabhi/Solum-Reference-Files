#!/bin/bash

BASE_PATH="/home/assettracker/cloud_assettracker"

echo "
########################################################
    Updating YAML files with new version string
########################################################"

################################### Edit apiservice.yaml #################################

sed -i '/        - name: base_version_string/{n;s/.*/          value: "1.0.0"/}' asset-azure-info.yaml         # asset-azure-info_base_version_string
sed -i '/        - name: base_version_string/{n;s/.*/          value: "1.0.0"/}' asset-db-outbound.yaml        # asset-db-outbound_base_version_string
sed -i '/        - name: base_version_string/{n;s/.*/          value: "1.0.0"/}' asset-restapi-inbound.yaml    # asset-restapi-inbound_base_version_string
sed -i '/        - name: base_version_string/{n;s/.*/          value: "1.0.0"/}' asset-websocket-inbound.yaml  # asset-websocket-inbound_base_version_string
sed -i '/        - name: data-server-backend-base-version/{n;s/.*/          value: "1.0.0"/}' data-server-backend.yaml      # data-server-backend_base_version_string
sed -i '/        - name: data-server-frontend-base-version/{n;s/.*/          value: "1.0.0"/}' data-server-backend.yaml      # data-server-frontend_base_version_string

echo "
########################################################
    All YAML files updated with new Version string
########################################################"