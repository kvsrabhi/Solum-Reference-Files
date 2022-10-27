shell script to read acr tag and update yaml file

#!/bin/bash

#set -x

#Usage function

function usage()

{

echo "Update the given YAML file with the given ACR Tag"

}

#Check for the number of arguments

if [[ $# -lt 2 ]]

then

usage

exit 1

fi

#Update the YAML file

sed -i "s@image: .*@image: $1@g" $2




















script check pod deletion status and automates next step
    import json
    import time
    import os
    import sys

    kube_cfg = sys.argv[1]
    with open(kube_cfg) as f:
        kube_cfg = json.load(f)

    # define pod deletion check function
    def pod_delete_check(pod_name):
        pod_delete_status = kube_cfg['api'].read_namespaced_pod(name=pod_name, namespace=kube_cfg['ns']).metadata.deletion_timestamp
        return pod_delete_status

    # define automating next step function
    def delete_next_step(step_name):
        os.remove(step_name)
        print('removed', step_name)

    # define duration to wait for pod deletion
    pod_delete_wait_time = 30
    for i in range(pod_delete_wait_time):
        if pod_delete_check(kube_cfg['pod_name']) == None:
            delete_next_step('kube_deploy_2.py')
            print(k









script to exit from while loop when no pod is in terminating state

while :
do
  PODS=$(kubectl get pods --namespace=mynamespace --selector=status=Terminating | wc -l)
  if [[ $PODS -eq 0 ]]; then
    break
  fi
  sleep 10
done

echo "All pods are now running"
















script that checks the pod deletion status and moves to next step
if [[ -z "$(kubectl get pods --selector=app=${APP_NAME} -o name)" ]]
then
  echo "Application pod deleted successfully"
else
  echo "Application pod not deleted"
  exit 1
fi

#deletion of application PV and PVC
kubectl delete pv $PV_NAME
kubectl delete pvc $PVC_NAME

#waiting for PV deletion to be completed
kubectl wait --for=delete pv/$PV_NAME

#waiting for PVC deletion to be completed
kubectl wait --for=delete pvc/$PVC_NAME

#script that checks the PV and PVC deletion status and moves to next step
if [[ -z "$(kubectl get pv/$PV_NAME)" ]]
then
  echo "Application PV deleted successfully"
else
  echo "Application PV not deleted"
  exit 1
fi

if [[ -z "$(kubectl get pvc/$PVC_NAME)" ]]
then
  echo "Application PVC deleted successfully"
else
  echo "Application PVC not deleted"
  exit 1
fi

#deletion of application service
kubectl delete service $SVC_NAME

#waiting for service deletion to be completed
kubectl wait --for=delete service/$SVC_NAME

#script that checks the service deletion status and moves to next step
if [[ -z "$(kubectl get service/$SVC_NAME)" ]]
then
  echo "Application service deleted successfully"
else
  echo "Application service not deleted"
  exit 1
fi

#deletion of application deployment
kubectl delete deployment $DEPLOY_NAME

#waiting for deployment deletion to be completed
kubectl wait --for=delete deployment/$DEPLOY_NAME

#script that checks the deployment deletion status and moves to next step
if [[ -z "$(kubectl get deployment/$DEPLOY_NAME)" ]]
then
  echo "Application deployment deleted successfully"
else
  echo "Application deployment not deleted"
  exit 1
fi

#deletion of application namespace
kubectl delete namespace $APP_NS

#waiting for namespace deletion to be completed
kubectl wait --for=delete namespace/$APP_NS

#script that checks the namespace deletion status and moves to next step
if [[ -z "$(kubectl get namespace/$APP_NS)" ]]
then
  echo "Application namespace deleted successfully"
else
  echo "Application namespace not deleted"
  exit 1
fi










:return: True
	"""
	if not k8s_pods_terminating():
		return True
	else:
		sleep(5)
		return check_pods_terminating()


def check_pods_ready():
	"""
	Function that checks all pods status and moves to next step
	:return: True
	"""
	if k8s_pods_ready():
		return True
	else:
		sleep(5)
		return check_pods_ready()


def check_deployment_ready():
	"""
	Function that checks deployment status and moves to next step
	:return: True
	"""
	if k8s_deployment_ready():
		return True
	else:
		sleep(5)
		return check_deployment_ready()


def k8s_pods_terminating():
	"""
	Function that fetches all pods and checks if they're terminating
	:return: False if there are no terminating pods, True if there are
	"""
	pods = k8s_get_resource('pod')
	for pod in pods:
		if pod.status.phase == 'Terminating':
			return True
	return False


def k8s_pods_running():
	"""
	Function that fetches all pods and checks if they're running
	:return: True if there are running pods, False if there are no
	"""
	pods = k8s_get_resource('pod')
	if len(pods) > 0:
		return True
	else:
		return False


def k8s_pods_ready():
	"""
	Function that fetches all pods and checks if they're ready
	:return: True if all pods are ready, False if there are no
	"""
	pods = k8s_get_resource('pod')
	if len(pods) > 0:
		for pod in pods:
			if pod.status.phase != 'Running' or pod.status.ready != True:
				return False
		return True
	else:
		return False


def k8s_deployment_ready():
	"""
	Function that fetches all deployments and checks if all of them are ready
	:return: True if all deployments are ready, False if there are no
	"""
	deployments = k8s_get_resource('deployment')
	if len(deployments) > 0:
		for deployment in deployments:
			if deployment.status.available_replicas != deployment.status.updated_replicas:
				return False
		return True
	else:
		return False


def print_k8s_resource(resource):
	"""
	Function that prints given resource
	:param resource: k8s resource
	:return: None
	"""
	print(json.dumps(json.loads(json.dumps(resource)), indent=2, separators=(',', ': ')))


def k8s_get_resource(resource):
	"""
	Function that fetches given resource
	:param resource: resource name
	:return: list of k8s resources
	"""
	if resource == 'pod':
		return api.list_namespaced_pod(namespace="default").items
	elif resource == 'deployment':
		return api.list_namespaced_deployment(namespace="default").items
	elif resource == 'service':
		return api.list_namespaced_service(namespace="default").items


def k8s_create_resource(resource_name, resource_file_name):
	"""
	Function that creates k8s resource from file
	:param resource_name: resource name
	:param resource_file_name: resource yaml file name
	:return: None
	"""
	with open(resource_file_name) as resource_file:
		resource_data = yaml.load(resource_file)
		if resource_name == 'pod':
			api.create_namespaced_pod(namespace="default", body=resource_data)
		elif resource_name == 'deployment':
			api.create_namespaced











            shell script that checks no terminating pods status and moves to next step

#!/bin/bash

# Check the status of all pods and make sure they are not in a terminating state

kubectl get pods --all-namespaces

while [ "$?" -eq "0" ]; do

# Get the status of all pods

STATUS=$(kubectl get pods --all-namespaces | grep -v STATUS | awk '{print $3}')

# If any pods are in a terminating state, wait for them to finish terminating

if [ "$STATUS" == "Terminating" ]; then

echo "Waiting for pods to finish terminating..."

sleep 10

else

# If all pods are running, move on to the next step

echo "All pods are running."

break

fi

done



shell script to check pods in terminating state and move to next step

kubectl get pods --watch

while true; do
  sleep 2
  kubectl get pods
  if [ "$(kubectl get pods | grep Terminating | wc -l)" -eq 0 ]; then
    break
  fi
done



shell script to move to next step after checking pod deletion status

kubectl get pods --watch

while [[ "$(kubectl get pods -l app=myapp -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}')" != "True" ]]; do sleep 1; done 

# To check if the pod is deleted

kubectl get pods -l app=myapp

if [[ "$(kubectl get pods -l app=myapp)" == "No resources found." ]]

then

#Do something

fi









shell script to check pod termination state, if no pod is in terminating state move to next step
if ! kubectl get pod --selector=app=php-apache | grep Terminating; then
    echo "no pod is in terminating state"
else
    exit 1
fi

#script to check pod creation state, if all pods are in running state move to next step
if kubectl get pod --selector=app=php-apache | grep Running; then
    echo "all pods are in running state"
else
    exit 1
fi

#script to check service creation state, if service is created move to next step
if kubectl get service php-apache | grep php-apache; then
    echo "all services are in running state"
else
    exit 1
fi

#script to check ingress creation state, if ingress is created move to next step
if kubectl get ingress | grep php-apache; then
    echo "all ingress are in running state"
else
    exit 1
fi

exit 0



shell script check pod termination state, if no pod is in terminating state move to next step, if any pod is in terminating state wait for it to get deleted

kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{.metadata.namespace}:{.status.phase}:{.metadata.name}{"\n"}{end}'|grep Terminating && sleep 10 || echo done







#!/bin/bash

# Wait for all pods to be deleted

while [ "$(kubectl get pods | grep Terminating | wc -l)" -gt 0 ]; do
  sleep 5
  kubectl get pods
  echo "Pod Termination is in process"
done

echo "All pods deleted"
# Perform next step


shell script to update yaml file

#!/bin/sh

# Check if yaml file exists
if [ ! -f "/path/to/file.yaml" ]; then
    echo "Error: yaml file does not exist." >&2
    exit 1
fi

# Set the new value for the key
sed -i "s/^\(key: \).*$/\1new_value/" /path/to/file.yaml



shell script to update yaml file based on parameter

#!/bin/bash

file="test.yaml"

if [ $# -ne 2 ]; then
  echo "Usage: ./update_yaml.sh <parameter> <value>"
  exit 1
fi

param=$1
value=$2

# escape "/" in value
escaped_value=$(echo $value | sed 's/\//\\\//g')

# update parameter
sed -i "s/^\($param:\).*/\1 $escaped_value/" $file



