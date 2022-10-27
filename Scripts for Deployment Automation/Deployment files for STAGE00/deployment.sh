#!/bin/bash

BASE_PATH="/home/common00/cloud_common00"

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

cd /home/common00/git_cloud_common00/slm-configmap/

git pull https://github.com/solumesl/slm-config.git master

echo -e "\033[35m

 
**       Success: pulled configmap files from GitHub        **
--------------------------------------------------------------
\033[0m"

# V. Recreate Configmap with GENERATE_DB_SCRIPT = YES

echo -e "\033[31m

Step5: Recreate Configmap with GENERATE_DB_SCRIPT = YES
--------------------------------------------------------------

Recreating Configmap with GENERATE_DB_SCRIPT = YES............


\033[0m"


cd /home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-apiservice-common/

sed -i '/# Database Script Cofig/{n;s/.*/GENERATE_DB_SCRIPT = YES/}' apiservice.properties

cd /home/common00/cloud_common00/

./remove_configmap1.sh

echo -e "\033[36m

  Configmap deleted...........................................


  \033[0m"

./make_configmap1.sh

echo -e "\033[36m

  Configmap Created...........................................


  \033[0m"

echo -e "\033[35m

 
**              Success: Configmap Recreated                **
--------------------------------------------------------------
\033[0m"

sleep 2

# VI. Runing API service  

echo -e "\033[31m

Step6: Running API service
--------------------------------------------------------------

Running API service...........................................


\033[0m"

sed -i 's/  replicas: 5   # The number of replicas/  replicas: 1   # The number of replicas/' apiservice.yaml
/usr/local/bin/kubectl apply -f $BASE_PATH/apiservice.yaml
echo "

************** please wait *************"
sleep 300

echo -e "\033[35m

 
**        Success: API service Runnung Successfully         **
--------------------------------------------------------------
\033[0m"


sleep 2

# VII. Recreate Configmap with GENERATE_DB_SCRIPT = NO

echo -e "\033[31m

Step7: Recreate Configmap with GENERATE_DB_SCRIPT = NO
--------------------------------------------------------------

Recreating Configmap with GENERATE_DB_SCRIPT = NO.............


\033[0m"

cd /home/common00/git_cloud_common00/slm-configmap/STAGE00/slm-apiservice-common/

sed -i '/# Database Script Cofig/{n;s/.*/GENERATE_DB_SCRIPT = NO/}' apiservice.properties

cd /home/common00/cloud_common00/

./remove_configmap1.sh
echo -e "\033[36m

  Configmap deleted...........................................


  \033[0m"

./make_configmap1.sh

echo -e "\033[36m

  Configmap Created...........................................


  \033[0m"

echo -e "\033[35m

 
**              Success: Configmap Recreated                **
--------------------------------------------------------------
\033[0m"

sleep 2


# VIII. Run all Micro Services Except (inbound, squarepos, onlinesw) 

echo -e "\033[31m

Step8: Run all Micro Services Except (inbound, squarepos, onlinesw)
-------------------------------------------------------------------

Starting all Micro Services Except (inbound, squarepos, onlinesw)..


\033[0m"


sed -i 's/  replicas: 1   # The number of replicas/  replicas: 5   # The number of replicas/' apiservice.yaml
./run1.sh all

sleep 10

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

 
**   All Mirco Services Except (inbound, squarepos, onlinesw) are Running Successfully   **
-------------------------------------------------------------------------------------------
\033[0m"


echo "

************** please wait *************"

sleep 120

# IX. Start Ingress

echo -e "\033[31m

Step9: Start Ingress
--------------------------------------------------------------

Starting Ingress service......................................


\033[0m"

/usr/local/bin/kubectl apply -f $BASE_PATH/solum-ingress.yaml

echo -e "\033[35m

 
**              Success: Ingress is Running                 **
--------------------------------------------------------------
\033[0m"
sleep 30

# X. Run all Micro Services  

echo -e "\033[31m

Step10: Run all Micro Services
--------------------------------------------------------------

Starting all Micro Services...................................


\033[0m"

./run.sh all

sleep 10

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

echo "

************** please wait *************"

sleep 120

echo -e "\033[31m
###########################################
**    Deployment process is complete     **
###########################################\033[0m"

# Check for 10 mins until all MS are deployed successfully and up & running
# Check All MS versions in Dashboard UI and compare if it is same as stage00 