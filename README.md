# 6over6

## Install VirtualBox V6.1.26:

1. `curl -O https://download.virtualbox.org/virtualbox/6.1.26/VirtualBox-6.1.26-145957-Linux_amd64.run`
2. `./VirtualBox-6.1.26-145957-Linux_amd64.run`

## Creation 2 servers by Vagrant
### Run from the root project path (level of Vagrantfile)
Create VBox instance: `vagrant up`

Destroy VBox instances: `vagrant destroy`
### ssh (additional to `vagrant ssh <name>`):
    h="jenkins"
    v_ssh=$(vagrant ssh-config | grep -A9 "Host ${h}")
    i_file=$(echo $v_ssh | grep -w IdentityFile | awk '{print $2}')
    port=$(echo $v_ssh | grep -w Port | awk '{print $2}')
    user=$(echo $v_ssh | grep -w User | awk '{print $2}')
    host=$(echo $v_ssh | grep -w HostName | awk '{print $2}')
    ssh -i ${i_file} -l ${user} -p ${port} ${host}


## Deploy Docker and Jenkins by Ansible
### Run in ansible folder (`cd ansible`)

- Verify the virtual services are running: `vagrant status`
- Create a vagrant_hosts file: `./create_hosts.sh`
- Verify connection to servers: `ansible -i ./vagrant_hosts all -m ping`
- Verify the IPs of jenkins and app are identical in Vagrantfile and ansible/group_vars/all
- Install collections: `ansible-galaxy collection install -r requirements.yml` 
- Deploy: `ansible-playbook -v -i vagrant_hosts task.yml `
- Uncheck 'Enable script security for Job DSL scripts' in `http://192.168.56.10:8080/configureSecurity/`