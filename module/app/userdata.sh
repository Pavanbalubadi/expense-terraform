#!/bin/bash

yum install ansible  python3.11-pip.norch -y | tee -a /opt/userdata.logs
pip3.11 install botocore boto3 | tee -a /opt/userdata.logs
ansible-pull -i localhost, -U https://github.com/Pavanbalubadi/expense-ansible-1 expense.yml -e role_name=${role_name} -e env=${env}