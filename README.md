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


## Build Jenkins Docker JCasc (`cd jenkins-jcasc`)
- define docker image repo name (**Default** maxib/jenkins-jasc): 
    - `export JENKINS_DOCKER_REPO=...`
- `./build.sh`
- `./push.sh`

## Deploy Docker and Jenkins by Ansible
### Run in ansible folder (`cd ansible`)

- Verify the virtual services are running: `vagrant status`
- Create a vagrant_hosts file: `./create_hosts.sh`
- Verify connection to servers: `ansible -i ./vagrant_hosts all -m ping`
- Verify the IPs of jenkins and app are identical in Vagrantfile and ansible/group_vars/all
- Install collections: `ansible-galaxy collection install -r requirements.yml` 
- Define environment variables:
    - `export JENKINS_ADMIN_ID=...`
    - `export JENKINS_ADMIN_PASSWORD=...`
- Deploy: `ansible-playbook -i vagrant_hosts task.yml --extra-vars "jenkins_admin_password=${JENKINS_ADMIN_PASSWORD} jenkins_admin_name=${JENKINS_ADMIN_ID}"`
- Log in to [Jenkins](http://192.168.56.10:8080)
- Go to [Configure Global Security](http://192.168.56.10:8080/configureSecurity/)
- Uncheck 'Enable script security for Job DSL scripts'
- Run [Job_DSL_Seed](http://192.168.56.10:8080/job/Job_DSL_Seed/build?delay=0sec) - **!! Warning !!** the link starts the Job :)
- Run [Fibonacii Test and deploy] (http://192.168.56.10:8080/job/example/build?delay=0sec)