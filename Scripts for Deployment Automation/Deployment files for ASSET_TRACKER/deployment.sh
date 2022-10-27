#!/bin/bash

BASE_PATH="/home/assettracker/cloud_assettracker"

############################ PRE-REQUISITES #############################

####### Update version_update.sh file with latest version details #######

#########################################################################

# I. Update of YAML Files

echo -e "\033[31m

Step1: Update of YAML Files
--------------------------------------------------------------

YAML file updation is in progress.............................


\033[0m"

./release_tag_reader.pl
./version_update.sh 

echo -e "\033[35m

 
**             Success: All YAML Files Updated              **
--------------------------------------------------------------
\033[0m"

sleep 2

# II. Stop Ingress

echo -e "\033[31m

Step2: Stop Ingress
--------------------------------------------------------------

Stopping Ingress service......................................


\033[0m"



/usr/local/bin/kubectl delete -f $BASE_PATH/solum-ingress.yaml


echo -e "\033[35m

 
**                Success: Ingress stopped                 **
--------------------------------------------------------------
\033[0m"


echo "

************** please wait ***************"

sleep 60

# III. Delete all Micro Services

echo -e "\033[31m

Step3: Delete all Micro Services
--------------------------------------------------------------

Deleting all Micro Services...................................


\033[0m"


./delete.sh all

sleep 10

while [ "$(kubectl get pods | grep Terminating | wc -l)" -gt 0 ]; do
  sleep 5
  kubectl get pods

  echo -e "\033[36m

  Pod Termination is in process................................


  \033[0m"
done 

echo -e "\033[35m

 
**          Success: All Micro services deleted             **
--------------------------------------------------------------
\033[0m"

sleep 2


# IV. Pulling Configmap files from Github


echo -e "\033[31m

Step4: Pulling configmap files from GitHub
--------------------------------------------------------------

Pulling configmap files from GitHub...........................


\033[0m"

cd /home/assettracker/git_cloud_assettracker/slm-asset-config
git pull


echo -e "\033[35m

 
**       Success: pulled configmap files from GitHub        **
--------------------------------------------------------------
\033[0m"


cd /home/assettracker/cloud_assettracker
sleep 2

# V. Recreating configmap  


echo -e "\033[31m

Step5: Recreating configmap
--------------------------------------------------------------

Recreating configmap..........................................


\033[0m"

./remove_configmap.sh

  echo -e "\033[36m

  Configmap deleted...........................................


  \033[0m"
./make_configmap.sh

echo -e "\033[36m

  Configmap Created...........................................


  \033[0m"


echo -e "\033[35m

 
**              Success: Configmap Recreated                **
--------------------------------------------------------------
\033[0m"

sleep 2

# VI. Runing Data_Server_Backend  

echo -e "\033[31m

Step6: Runing Data_Server_Backend
--------------------------------------------------------------

Runing Data_Server_Backend....................................


\033[0m"

/usr/local/bin/kubectl apply -f $BASE_PATH/data-server-backend.yaml
echo "

************** please wait *************"
sleep 60

echo -e "\033[35m

 
**     Success: Data-Server-Backend Runnung Successfully    **
--------------------------------------------------------------
\033[0m"

sleep 2

# VII. Run all Micro Services 

echo -e "\033[31m

Step7: Run all Micro Services
--------------------------------------------------------------

Starting all Micro Services...................................


\033[0m"


./run.sh all

while [ "$(kubectl get pods | grep ContainerCreating | wc -l)" -gt 0 ]; do
  sleep 5
  kubectl get pods
  echo -e "\033[36m

  Pod Creation is in process..................................


  \033[0m"
done

while [ "$(kubectl get pods | grep Pending | wc -l)" -gt 0 ]; do
  sleep 5
  kubectl get pods
  echo -e "\033[36m

  Pod Creation is in process..................................


  \033[0m"
done

while [ "$(kubectl get pods | grep CrashLoopBackOff | wc -l)" -gt 0 ]; do
  sleep 5
  kubectl get pods
  echo -e "\033[36m

  Pod Creation is in process..................................


  \033[0m"
done

echo -e "\033[35m

 
**   Success: All Mirco Services are Running Successfully   **
--------------------------------------------------------------
\033[0m"

sleep 2

# VIII. Start Ingress

echo -e "\033[31m

Step8: Start Ingress
--------------------------------------------------------------

Starting Ingress service......................................


\033[0m"


/usr/local/bin/kubectl apply -f $BASE_PATH/solum-ingress.yaml

echo -e "\033[35m

 
**              Success: Ingress is Running                 **
--------------------------------------------------------------
\033[0m"

sleep 10

echo -e "\033[31m
###########################################
**    Deployment process is complete     **
###########################################\033[0m"

# Check for 10 mins until all MS are deployed successfully and up & running
