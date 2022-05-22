# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "las/bullseye64"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
    vb.linked_clone = true
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "playbook.yml"
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client"
    client.vm.network "private_network", virtualbox__intnet: "LAN1", auto_config: false
    client.vm.network "private_network", virtualbox__intnet: "LAN3", auto_config: false
  end

  config.vm.define "router" do |router|
    router.vm.hostname = "router"
    router.vm.network "private_network", virtualbox__intnet: "LAN1", auto_config: false
    router.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false
    router.vm.network "private_network", virtualbox__intnet: "LAN3", auto_config: false
  end

  config.vm.define "server" do |server|
    server.vm.hostname = "server"
    server.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false, mac: "0800270ca52a"
    server.vm.network "private_network", virtualbox__intnet: "LAN3", auto_config: false
  end

end
