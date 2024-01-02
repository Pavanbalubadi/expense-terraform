#!/bin/bash

yum install ansible -y | tee -a /opt/userdata.logs
ansible-pull -i localhost, -U https://github.com/Pavanbalubadi/expense-ansible-1 expense.yml -e role_name=${role_name} -e env=${env}