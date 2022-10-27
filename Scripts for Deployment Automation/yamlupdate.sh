#!/bin/bash

BASE_PATH="//home/common00/vidyasagar/cloud_common00"

echo "Edit of YAML files in Progress"

################################### Edit apiservice.yaml #################################

sed -i '24s%.*%      - image: solumacrms.azurecr.io/template_mgmt_api_img:4001   # The path of container%' apiservice.yaml      # apiservice ACR Image 
sed -i '42s%.*%          value: "2022-10-26 01:10:21"%' apiservice.yaml     # apiservice_release_date
sed -i '44s%.*%          value: "4000"%' apiservice.yaml                    # apiservice_version_info
sed -i '46s%.*%          value: "2022-10-26 01:10:21"%' apiservice.yaml     # dashboard_release_date
sed -i '48s%.*%          value: "4000"%' apiservice.yaml                    # dashboard_version_info
sed -i '50s%.*%          value: "2022-10-26 01:10:21"%' apiservice.yaml     # ld_release_date
sed -i '52s%.*%          value: "4000"%' apiservice.yaml                    # ld_version_info
sed -i '54s%.*%          value: "1.1.6"%' apiservice.yaml                   # apiservice_base_version_string
sed -i '56s%.*%          value: "1.1.6"%' apiservice.yaml                   # ld_base_version_string
sed -i '58s%.*%          value: "1.1.6"%' apiservice.yaml                   # dashboard_base_version_string

################################## Edit dashboard.yaml #####################################

sed -i '23s%.*%      - image: solumacrms.azurecr.io/template_levels_dashboard_img:4000 #The path of container%' dashboard.yaml      # dashboard ACR Image

################################## Edit ld.yaml ############################################

sed -i '22s%.*%      - image: solumacrms.azurecr.io/common_ld_img:4000   # The path of container%' ld.yaml      # ld ACR Image 

################################### Edit imggenerator.yaml ##################################

sed -i '22s%.*%      - image: solumacrms.azurecr.io/common_ig_jdk16_img:4002  # The path of container%' imggenerator.yaml       # image Generator ACR Image 
sed -i '37s%.*%          value: "2022-10-26 01:10:21"%' imggenerator.yaml   # imggenerator_release_date
sed -i '43s%.*%          value: "1.1.8"%' imggenerator.yaml                 # imggenerator_base_version_string
sed -i '45s%.*%          value: "4000"%' imggenerator.yaml                  # imggenerator_version_info

################################### Edit inbound.yaml #######################################

sed -i '22s%.*%      - image: solumacrms.azurecr.io/multitenant_inbound_img:4000 # The path of container%' inbound.yaml     # inbound ACR Image 
sed -i '37s%.*%          value: "2022-10-26 01:10:21"%' inbound.yaml    # inbound_release_date
sed -i '41s%.*%          value: "1.1.6"%' inbound.yaml                  # inboun_base_version_string
sed -i '43s%.*%          value: "4000"%' inbound.yaml                   # inbound_version_info

################################### Edit lbs.yaml ###########################################

sed -i '23s%.*%        - image: solumacrms.azurecr.io/multitenant_lbs_img:4000  # The path of container%' lbs.yaml      # lbs ACR Image 
sed -i '38s%.*%              value: "2022-10-26 01:10:21"%' lbs.yaml    # lbs_release_date
sed -i '42s%.*%              value: "1.1.6"%' lbs.yaml                  # lbs_base_version_string
sed -i '44s%.*%              value: "4000"%' lbs.yaml                   # lbs_version_info

################################### Edit onlineswinterface.yaml #############################

sed -i '23s%.*%      - image: solumacrms.azurecr.io/common_online_sw_interface_img:4000 # The path of container%' onlineswinterface.yaml    # onlineswinterface ACR Image
sed -i '38s%.*%          value: "2022-10-26 01:10:21"%' onlineswinterface.yaml  # onlineswinterface_release_date
sed -i '42s%.*%          value: "1.1.6"%' onlineswinterface.yaml                # onlineswinterface_base_version_string
sed -i '44s%.*%          value: "4000"%' onlineswinterface.yaml                 # onlineswinterface_version_info

################################## Edit outbound.yaml ########################################

sed -i '22s%.*%      - image: solumacrms.azurecr.io/multitenant_outbound_img:4000  # The path of container%' outbound.yaml  # outbound ACR Image
sed -i '37s%.*%          value: "2022-10-26 01:10:21"%' outbound.yaml   # outbound_release_date
sed -i '41s%.*%          value: "1.1.6"%' outbound.yaml                 # outbound_base_version_string
sed -i '43s%.*%          value: "4000"%' outbound.yaml                  # outbound_version_info

################################## Edit pickcel.yaml ##########################################

sed -i '21s%.*%      - image:  solumacrms.azurecr.io/slm_lcd_pickcel_frontend_img:4000  # The path of container%' pickcel.yaml  # pickcel ACR Image

################################## Edit realtime_nike.yaml ####################################

sed -i '22s%.*%      - image: solumacrms.azurecr.io/common_realtime_nike_img:4000 # The path of container%' realtime_nike.yaml  # realtime_nike ACR Image
sed -i '37s%.*%          value: "2022-10-26 01:10:21"%' realtime_nike.yaml  # realtime_nike_release_date
sed -i '41s%.*%          value: "1.1.6"%' realtime_nike.yaml                # realtime_nike_base_version_string
sed -i '43s%.*%          value: "4000"%' realtime_nike.yaml                 # realtime_nike_version_info

################################### Edit scheduler.yaml #######################################

sed -i '22s%.*%      - image: solumacrms.azurecr.io/common_scheduler_img:4000   # The path of container%' scheduler.yaml    # scheduler.yaml_nike ACR Image
sed -i '40s%.*%          value: "2022-10-26 01:10:21"%' scheduler.yaml  # scheduler_release_date
sed -i '42s%.*%          value: "1.1.6"%' scheduler.yaml                # scheduler_base_version_string
sed -i '44s%.*%          value: "4000"%' scheduler.yaml                 # scheduler_version_info

################################## Edit square_pos.yaml ########################################

sed -i '22s%.*%      - image: solumacrms.azurecr.io/common_square_pos_img:4000 # The path of container%' square_pos.yaml # square_pos ACR Image
sed -i '37s%.*%          value: "2022-10-26 01:10:21"%' square_pos.yaml     # square_pos_release_date
sed -i '39s%.*%          value: "1.1.6"%' square_pos.yaml                   # square_pos_base_version_string
sed -i '41s%.*%          value: "4000"%' square_pos.yaml                    # square_pos_version_info

echo "All YAML files updated with new ACR Image ID, Version ID and Release Dates"