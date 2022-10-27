#!/bin/bash

BASE_PATH="/home/common00/cloud_common00"

############################ PRE-REQUISITES #############################

# 1. Update versionupdate.sh with latest tags and versioning (API Service with Replica 1)
# 2. Clone Configmap files form GitHub
# 3. Create apiservicedbyes.properties file (DB_Generete=YES)
# 4. Create make_configmap1.sh (with apiservicedbyes.properties )
# 5. Create run1.sh file by (Inbound, Squarepos, Onlinesw are commented)

# I. Update of YAML Files
./acrimage.pl
./versionupdate.sh 

# II. Stop Ingress

echo "Stop Ingress in process ....................."

/usr/local/bin/kubectl delete -f $BASE_PATH/solum-ingress.yaml

echo "Ingress stopped"

# III. Delete all Micro Services

echo "Deleting all Micro Services .................."

./delete.sh all

echo " Deleting all Micro Services ................."

echo "Enter N to check pod deletion status or press Enter to continue deployement process"
read d

while [ $d = "n" ];
do
    /usr/local/bin/kubectl get pods
echo "Enter "N" to check pod deletion status or Enter "Y" to continue deployement process"
read d
done  

echo "All Micro services deleted"


# IV. Creating configmap with API Service properties: Generete_DB_Script = YES 

echo "Making configmap with API Service properties: Generete_DB_Script = YES"
./remove_configmap.sh
./make_configmap1.sh

# V. Runing API service with one replica 

echo " Running API Service"

/usr/local/bin/kubectl apply -f $BASE_PATH/apiservice.yaml

sleep 600


# VI. Recreating configmap with API Service properties: Generete_DB_Script = NO

echo "Making configmap with API Service properties: Generete_DB_Script = NO"
./remove_configmap.sh
./make_configmap.sh

# VII. Run all Micro Services (except Inbound, Squre POS and Onlinesw)

echo "Runing all Micro Services (except Inbound, Squre POS and Onlinesw)"

./run1.sh all

sleep 120

# VIII. Start Ingress

echo "Starting Ingress service ..................."

/usr/local/bin/kubectl apply -f $BASE_PATH/solum-ingress.yaml

echo "Ingress is Running ........................."

# IX. Run all Micro Services 

echo "Runing all Micro Services ....................."

./run.sh all

echo "All Micro Services Started"

# Update apiservice.yaml file with required number of repicas and run again
# Check for 10 mins until all MS are deployed successfully and up & running
# Check All MS versions in Dashboard UI and compare if it is same as stage00