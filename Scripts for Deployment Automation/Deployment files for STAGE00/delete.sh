#!/bin/bash

BASE_PATH="/home/common00/cloud_common00"

if [ "$1" = "api" ]; then

        echo "deleting apiService for Common !!"

        kubectl delete -f $BASE_PATH/apiservice.yaml

        echo

elif [ "$1" = "img" ]; then

        echo "deleting Img Generator !!"

        kubectl delete -f $BASE_PATH/imggenerator.yaml

        echo

elif [ "$1" = "in" ]; then

        echo "deleting Inbound !!"

        kubectl delete -f $BASE_PATH/inbound.yaml

        echo

elif [ "$1" = "out" ]; then

        echo "deleting outbound !!"

        kubectl delete -f $BASE_PATH/outbound.yaml

        echo

elif [ "$1" = "sc" ]; then

        echo "deleting Scheduler for Common !!"

        kubectl delete -f $BASE_PATH/scheduler.yaml

        echo

elif [ "$1" = "do" ]; then

        echo "deleting DB Operator !!"

        kubectl delete -f $BASE_PATH/dboperator.yaml

        echo

elif [ "$1" = "lbs" ]; then

        echo "deleting LBS !!"

        kubectl delete -f $BASE_PATH/lbs.yaml

        echo

elif [ "$1" = "dash" ]; then

        echo "deleting Dashboard !!"

        kubectl delete -f $BASE_PATH/dashboard.yaml

        echo

elif [ "$1" = "ld" ]; then

        echo "deleting LD !!"

        kubectl delete -f $BASE_PATH/ld.yaml

        echo

elif [ "$1" = "ikea" ]; then

        echo "deleting IKEA Converter !!"

        kubectl delete -f $BASE_PATH/ikea_converter.yaml

        echo

elif [ "$1" = "rt" ]; then

        echo "deleting Realtime for Nike !!"

        kubectl delete -f $BASE_PATH/realtime_nike.yaml

        echo

elif [ "$1" = "os" ]; then

        echo "deleting Online SW !!"

        kubectl delete -f $BASE_PATH/onlineswinterface.yaml

        echo

elif [ "$1" = "square" ]; then

        echo "deleting Square Pos MS !!"

        kubectl delete -f $BASE_PATH/square_pos.yaml

        echo

elif [ "$1" = "pick" ]; then

        echo "deleteing Pickcel !!"

        kubectl delete -f $BASE_PATH/pickcel.yaml

        echo

elif [ "$1" = "aqp" ]; then

        echo "deleting Apiservice Queue Processor MS !!"

        kubectl delete -f $BASE_PATH/apiserviceaqp.yaml

        echo

elif [ "$1" = "all" ]; then

        echo "deleting all !!"

        kubectl delete -f $BASE_PATH/apiservice.yaml
        kubectl delete -f $BASE_PATH/imggenerator.yaml
        kubectl delete -f $BASE_PATH/inbound.yaml
        kubectl delete -f $BASE_PATH/outbound.yaml
        kubectl delete -f $BASE_PATH/scheduler.yaml
#       kubectl delete -f $BASE_PATH/dboperator.yaml
        kubectl delete -f $BASE_PATH/lbs.yaml
        kubectl delete -f $BASE_PATH/dashboard.yaml
        kubectl delete -f $BASE_PATH/ld.yaml
#       kubectl delete -f $BASE_PATH/ikea_converter.yaml
        kubectl delete -f $BASE_PATH/realtime_nike.yaml
        kubectl delete -f $BASE_PATH/onlineswinterface.yaml
        kubectl delete -f $BASE_PATH/square_pos.yaml
#       kubectl delete -f $BASE_PATH/apiserviceaqp.yaml
        kubectl delete -f $BASE_PATH/pickcel.yaml
        echo

else

        echo
        echo "====== Cmd line utility ======"
        echo " ApiService Common:       ./delete.sh api "
        echo " Api Queue Processor:   ./delete.sh aqp "
        echo " ImgGenerator:            ./delete.sh img " 
        echo " Inbound:         ./delete.sh in " 
        echo " Outbound:                ./delete.sh out " 
        echo " Scheduler Common:        ./delete.sh sc"
        echo " DB Operator:             ./delete.sh do "
        echo " LBS:                     ./delete.sh lbs "
        echo " Dashboard:               ./delete.sh dash "
        echo " LD:                      ./delete.sh ld "
        echo " IKEA Converter:  ./delete.sh ikea "
        echo " Realtime Nike:           ./delete.sh rt "
        echo " Online SW:               ./delete.sh os "
        echo " Square Pos:            ./delete.sh square "
        echo " Pickcel:            ./delete.sh pick "
        echo " All:                     ./delete.sh all "
        echo

        exec "$@"
fi