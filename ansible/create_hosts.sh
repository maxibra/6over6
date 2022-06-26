#!/bin/bash

vagrant_hosts_file="./vagrant_hosts"
rm ${vagrant_hosts_file}
full_v_ssh=$(vagrant ssh-config)
for h in $(echo "${full_v_ssh}" | grep -w Host | awk '{print $2}'); do
    echo "${h}"
    h_v_ssh=$(echo "$full_v_ssh" | grep -A9 -w "Host ${h}")
    port=$(echo "${h_v_ssh}" | grep -w Port | awk '{print $2}')
    user=$(echo "${h_v_ssh}" | grep -w User | awk '{print $2}')
    host=$(echo "${h_v_ssh}" | grep -w HostName | awk '{print $2}')
    i_f=$(echo "${h_v_ssh}" | grep -w IdentityFile | awk '{print $2}')

    cat << EOF >> ${vagrant_hosts_file}
[${h}]
${host} ansible_port=${port} ansible_user=${user} ansible_ssh_private_key_file=${i_f}
EOF
done


