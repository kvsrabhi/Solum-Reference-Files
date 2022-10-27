#!/bin/bash

BASE_PATH="//home/common00/vidyasagar/cloud_common00"

echo "Updating YAML files with new version string"

################################### Edit apiservice.yaml #################################

sed -i '24s%.*%      - image: solumacrms.azurecr.io/template_mgmt_api_img:4001   # The path of container%' apiservice.yaml      # apiservice ACR Image 
sed -i '54s%.*%          value: "1.1.6"%' apiservice.yaml            # apiservice_base_version_string
sed -i '56s%.*%          value: "1.1.6"%' apiservice.yaml            # ld_base_version_string
sed -i '58s%.*%          value: "1.1.6"%' apiservice.yaml            # dashboard_base_version_string
sed -i '43s%.*%          value: "1.1.8"%' imggenerator.yaml          # imggenerator_base_version_string
sed -i '41s%.*%          value: "1.1.6"%' inbound.yaml               # inboun_base_version_string
sed -i '42s%.*%              value: "1.1.6"%' lbs.yaml               # lbs_base_version_string
sed -i '42s%.*%          value: "1.1.6"%' onlineswinterface.yaml     # onlineswinterface_base_version_string
sed -i '41s%.*%          value: "1.1.6"%' outbound.yaml              # outbound_base_version_string
sed -i '41s%.*%          value: "1.1.6"%' realtime_nike.yaml         # realtime_nike_base_version_string
sed -i '42s%.*%          value: "1.1.6"%' scheduler.yaml             # scheduler_base_version_string
sed -i '39s%.*%          value: "1.1.6"%' square_pos.yaml            # square_pos_base_version_string

echo "All YAML files updated with new Version string"