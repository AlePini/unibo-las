# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "debian/bullseye64"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 256
    vb.cpus = 2
    vb.linked_clone = true
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "playbook.yml"
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client"
    client.vm.network "private_network", virtualbox__intnet: "LAN1", auto_config: false
  end

  config.vm.define "router" do |router|
    router.vm.hostname = "router"
    router.vm.network "private_network", virtualbox__intnet: "LAN1", auto_config: false
    router.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false
  end

  config.vm.define "server1" do |server1|
    server1.vm.hostname = "server1"
    server1.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false, mac: "0800270ca52a"
  end

  config.vm.define "server2" do |server2|
    server2.vm.hostname = "server2"
    server2.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false, mac: "0800270ca52b"
  end
end
