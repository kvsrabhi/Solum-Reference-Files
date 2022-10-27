#!/bin/bash

BASE_PATH="/home/common00/cloud_common00"

if [ "$1" = "api" ]; then

        echo "deploying apiService for Common !!" 

        kubectl apply -f $BASE_PATH/apiservice.yaml
        echo

        kubectl get all


elif [ "$1" = "img" ]; then

        echo "deploying Img Generator !!"

        kubectl apply -f $BASE_PATH/imggenerator.yaml
        echo

        kubectl get all


elif [ "$1" = "in" ]; then


        echo "deploying Inbound !!"

        kubectl apply -f $BASE_PATH/inbound.yaml
        echo

        kubectl get all


elif [ "$1" = "out" ]; then

        echo "deploying outbound !!"

        kubectl apply -f $BASE_PATH/outbound.yaml
        echo

        kubectl get all

elif [ "$1" = "sc" ]; then

        echo "deploying Scheduler for Common !!"

        kubectl apply -f $BASE_PATH/scheduler.yaml
        echo

        kubectl get all

elif [ "$1" = "do" ]; then

        echo "deploying DB Operator !!"

        kubectl apply -f $BASE_PATH/dboperator.yaml
        echo

        kubectl get all

elif [ "$1" = "lbs" ]; then

        echo "deploying LBS !!"

        kubectl apply -f $BASE_PATH/lbs.yaml
        echo

        kubectl get all

elif [ "$1" = "dash" ]; then

        echo "deploying Dashboard !!"

        kubectl apply -f $BASE_PATH/dashboard.yaml
        echo

        kubectl get all

elif [ "$1" = "ld" ]; then

        echo "deploying LD !!"

        kubectl apply -f $BASE_PATH/ld.yaml
        echo

        kubectl get all

elif [ "$1" = "ikea" ]; then

        echo "deploying IKEA Converter !!"

        kubectl apply -f $BASE_PATH/ikea_converter.yaml
        echo

        kubectl get all

elif [ "$1" = "rt" ]; then

        echo "deploying Realtime for Nike !!"

        kubectl apply -f $BASE_PATH/realtime_nike.yaml
        echo

        kubectl get all

elif [ "$1" = "os" ]; then

        echo "deploying Online SW  !!"

        kubectl apply -f $BASE_PATH/onlineswinterface.yaml
        echo

        kubectl get all

elif [ "$1" = "square" ]; then

        echo "deploying Sqaure Pos MS !!"

        kubectl apply -f $BASE_PATH/square_pos.yaml
        echo

        kubectl get all

elif [ "$1" = "pick" ]; then

        echo "deploying Pickcel !!"

        kubectl apply -f $BASE_PATH/pickcel.yaml
        echo

        kubectl get all

elif [ "$1" = "aqp" ]; then

        echo "deploying Apiservice Queue Processor MS !!"

        kubectl apply -f $BASE_PATH/apiserviceaqp.yaml
        echo

        kubectl get all

elif [ "$1" = "all" ]; then

        echo "deploying all !!"

        kubectl apply -f $BASE_PATH/apiservice.yaml
        kubectl apply -f $BASE_PATH/imggenerator.yaml
#       kubectl apply -f $BASE_PATH/inbound.yaml
        kubectl apply -f $BASE_PATH/outbound.yaml
        kubectl apply -f $BASE_PATH/scheduler.yaml
#       kubectl apply -f $BASE_PATH/dboperator.yaml
        kubectl apply -f $BASE_PATH/lbs.yaml
        kubectl apply -f $BASE_PATH/dashboard.yaml
        kubectl apply -f $BASE_PATH/ld.yaml
#       kubectl apply -f $BASE_PATH/ikea_converter.yaml
        kubectl apply -f $BASE_PATH/realtime_nike.yaml
#       kubectl apply -f $BASE_PATH/onlineswinterface.yaml
#       kubectl apply -f $BASE_PATH/square_pos.yaml
        kubectl apply -f $BASE_PATH/pickcel.yaml
#       kubectl apply -f $BASE_PATH/apiserviceaqp.yaml
        echo

        kubectl get all
else
        echo
        echo "====== Cmd line utility ======"
        echo " ApiService Common:       ./run.sh api "
        echo " Api Queue Processor:   ./run.sh aqp "
        echo " ImgGenerator:            ./run.sh img "
        echo " Inbound:         ./run.sh in "
        echo " Outbound:                ./run.sh out "
        echo " Scheduler Common:        ./run.sh sc "
        echo " DB Operator:             ./run.sh do "
        echo " LBS:                     ./run.sh lbs "
        echo " Dashboard:               ./run.sh dash "
        echo " LD:                      ./run.sh ld "
        echo " IKEA Converter:  ./run.sh ikea "
        echo " Realtime Nike:           ./run.sh rt "
        echo " Onine SW:                ./run.sh os "
        echo " Sqaure Pos:            ./run.sh square"
        echo " Pickcel:               ./run.sh pick"
        echo " All:                     ./run.sh all "
        echo

        exec "$@"
fi
