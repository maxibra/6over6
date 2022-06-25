# 6over6

## Install VirtualBox V6.1.26:

1. `curl -O https://download.virtualbox.org/virtualbox/6.1.26/VirtualBox-6.1.26-145957-Linux_amd64.run`
2. `./VirtualBox-6.1.26-145957-Linux_amd64.run`

## Vagrant 
### ssh (additional to `vagrant ssh <name>`):
    h="jenkins"
    v_ssh=$(vagrant ssh-config | grep -A9 "Host ${h}")
    i_file=$(echo $v_ssh | grep -w IdentityFile | awk '{print $2}')
    port=$(echo $v_ssh | grep -w Port | awk '{print $2}')
    user=$(echo $v_ssh | grep -w User | awk '{print $2}')
    host=$(echo $v_ssh | grep -w HostName | awk '{print $2}')
    ssh -i ${i_file} -l ${user} -p ${port} ${host}


## Ansible
### Verify ssh connection
    ansible -i ansible/vagrant_hosts --private-key ~/.ssh/vagrant_key all -m ping%                         