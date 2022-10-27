#!/bin/bash
  
BASE_PATH="//home/common00/cloud_common00"


################################### Update Base Version String Value #################################

sed -i '/- name: base_version_string/{n;s/.*/          value: "1.1.5"/}' apiservice.yaml  # apiservice_base_version_string
sed -i '/- name: ld_base_version_string/{n;s/.*/          value: "1.1.2"/}' apiservice.yaml  # ld_base_version_string
sed -i '/- name: dashboard_base_version_string/{n;s/.*/          value: "1.1.5"/}' apiservice.yaml  # dashboard_base_version_string
sed -i '/- name: pickcel_base_version_string/{n;s/.*/          value: "1.1.5"/}' apiservice.yaml  # pickcel_base_version_string
sed -i '/- name: base_version_string/{n;s/.*/          value: "1.1.5"/}' imggenerator.yaml   # imggenerator_base_version_string
sed -i '/- name: base_version_string/{n;s/.*/          value: "1.1.5"/}' inbound.yaml   # inbound_base_version_string
sed -i '/- name: base_version_string/{n;s/.*/              value: "1.1.5"/}' lbs.yaml   # lbs_base_version_string
sed -i '/- name: base_version_string/{n;s/.*/          value: "1.1.0"/}' onlineswinterface.yaml # onlinesw_base_version_string
sed -i '/- name: base_version_string/{n;s/.*/          value: "1.0.6"/}' outbound.yaml  # outbound_base_version_string
sed -i '/- name: base_version_string/{n;s/.*/          value: "1.1.5"/}' realtime_nike.yaml  # realtime_nike_base_version_string
sed -i '/- name: base_version_string/{n;s/.*/          value: "1.1.5"/}' scheduler.yaml   # scheduler_base_version_string
sed -i '/- name: base_version_string/{n;s/.*/          value: "1.1.1"/}' square_pos.yaml  # square_pos_base_version_string

