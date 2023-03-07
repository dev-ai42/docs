#!/bin/bash

#set -e
#set -x

names=("arosalez" "eowusu" "jdoe" "ljuan" "mmajor" "mjackson" "nwolf" "psantos" "smartinez" "ssarkar")
roles=("Sales Manager" "Shipping" "Shipping" "HR Manager" "Finance Manager" "CEO" "Sales Representative" "Shipping" "HR Specialist" "Finance Specialist")

groups=("Sales" "HR" "Finance" "Personnel" "CEO" "Shipping" "Managers")

newpasswd=P@ssword1234!

#delete groups and users if already added
#for i in "${!groups[@]}"; do
#    sudo groupdel "${groups[i]}" 
#done

#for i in "${!names[@]}"; do
#    sudo userdel -r "${names[i]}"
#done

#create groups
for i in "${!groups[@]}"; do
    sudo groupadd "${groups[i]}"
done

#create user with password and add to right group(s)
for i in "${!names[@]}"; do
    sudo useradd "${names[i]}"
    echo "${names[i]}:$newpasswd" | sudo chpasswd
    sudo usermod -a -G Personnel "${names[i]}"
    if [[ "${roles[i]}" == *"Sales"* ]]; then
        sudo usermod -a -G Sales "${names[i]}"
    fi
    if [[ "${roles[i]}" == *"HR"* ]]; then
        sudo usermod -a -G HR "${names[i]}"
    fi
    if [[ "${roles[i]}" == *"Finance"* ]]; then
        sudo usermod -a -G Finance "${names[i]}"
    fi
    if [[ "${roles[i]}" == *"Shipping"* ]]; then
        sudo usermod -a -G Shipping "${names[i]}"
    fi
    if [[ "${roles[i]}" == *"Manager"* ]]; then
        sudo usermod -a -G Managers "${names[i]}"
    fi
    if [[ "${roles[i]}" == *"CEO"* ]]; then
        sudo usermod -a -G CEO "${names[i]}"
    fi
done

#add ec2-user to all groups
for i in "${!groups[@]}"; do
    sudo usermod -a -G "${groups[i]}" ec2-user
done


#cat /etc/passwd
#cat /etc/group
