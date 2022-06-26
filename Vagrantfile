# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "las/bullseye64"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
#    vb.memory = 512
#    vb.cpus = 2
    vb.linked_clone = true
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "playbook.yml"
  end

  config.vm.define "server" do |server|
    server.vm.hostname = "server"
    server.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false
#    server.vm.network "private_network",
#      virtualbox__intnet: "LAN2",
#      type: "dhcp"

  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client"
    client.vm.network "private_network", virtualbox__intnet: "LAN1", auto_config: false
   # client.vm.network "private_network",
   # virtualbox__intnet: "LAN1", type: "dhcp"
     #, mac: "0800270ca52a"
  end

  config.vm.define "router" do |router|
    router.vm.hostname = "router"
    router.vm.network "private_network", virtualbox__intnet: "LAN1", auto_config: false
    router.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false
    #, mac: "0800270ca52b"
  end
end
