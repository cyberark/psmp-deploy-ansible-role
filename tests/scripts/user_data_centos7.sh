#!/bin/bash -e

ANSIBLE_USER=user
ANSIBLE_USER_PASSWORD=nopass

# creating additional local user (ansible)
useradd ${ANSIBLE_USER} -p ${ANSIBLE_USER_PASSWORD}
echo ${ANSIBLE_USER}:${ANSIBLE_USER_PASSWORD} | chpasswd
gpasswd -a ${ANSIBLE_USER} wheel

echo -e " ${ANSIBLE_USER} ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

echo root:${ANSIBLE_USER_PASSWORD} | chpasswd

# sshd file changes
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin .*/PermitRootLogin yes/g' /etc/ssh/sshd_config
service sshd restart

# Install pre-reqs for the roles
yum install -y unzip