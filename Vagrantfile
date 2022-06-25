# To resolve Access denied in  VirtualBox 6.1.28:
#   https://stackoverflow.com/questions/70704093/the-ip-address-configured-for-the-host-only-network-is-not-within-the-allowed-ra
#   https://stackoverflow.com/questions/69722254/vagrant-up-failing-for-virtualbox-provider-with-e-accessdenied-on-host-only-netw

# Box / OS
VAGRANT_BOX = 'bento/ubuntu-20.04'
# VM User 'vagrant' by default
VM_USER = 'vagrant'
# Project name
PROJECT_NAME = '6over6'
# HOST User 
HOST_USER = 'maxibra'
# Host folder to sync
HOST_PATH = '/home/' + HOST_USER + '/' + PROJECT_NAME + '/'
# Where to sync to on Guest 'vagrant' is the default user name
GUEST_PATH = '/home/' + VM_USER + '/' + PROJECT_NAME + '/'
# Vagrant.configure(2) do |config|
#   # Vagrant box from Hashicorp
#   config.vm.box = VAGRANT_BOX
  
#   # Actual machine name
#   config.vm.hostname = VM_NAME
#   # Set VM name in Virtualbox
#   config.vm.provider "virtualbox" do |v|
#     v.name = VM_NAME
#     v.memory = 1024
#   end
#   #DHCP comment this out if planning on using NAT instead
#   config.vm.network "private_network", type: "dhcp"
#   # # Port forwarding uncomment this to use NAT instead of DHCP
#   # config.vm.network "forwarded_port", guest: 80, host: VM_PORT
#   # Sync folder
#   #config.vm.synced_folder HOST_PATH, GUEST_PATH
#   # Disable default Vagrant folder, use a unique path per project
#   #config.vm.synced_folder '.', '/home/'+VM_USER+'', disabled: true
#   # Install Git, Node.js 6.x.x, Latest npm
#   config.vm.provision "shell", inline: <<-SHELL
#     apt-get update
#   SHELL
# end



Vagrant.configure(2) do |config|
  config.vm.box = VAGRANT_BOX

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.network "private_network", ip: "192.168.56.10"
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.provider "jenkins" do |vb|
      vb.cpus = 1
      vb.memory = 1024
    end
    # Sync folder
    #config.vm.synced_folder HOST_PATH, GUEST_PATH
  end

  config.vm.define "app" do |app|
    app.vm.network "private_network", ip: "192.168.56.11"
    app.vm.hostname = "app"
    app.vm.provider "app" do |vb|
      vb.cpus = 1
      vb.memory = 1024
    end
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
  SHELL
end
