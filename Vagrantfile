# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "debian/bullseye64"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 512
    vb.cpus = 2
    vb.linked_clone = true
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "playbook.yml"
  end

  config.vm.define "controller" do |controller|
    controller.vm.hostname = "controller"
    controller.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false
  end

  config.vm.define "agent1" do |agent1|
    agent1.vm.hostname = "agent1"
    agent1.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false, mac: "0800270ca52a"
  end

  config.vm.define "agent2" do |agent2|
    agent2.vm.hostname = "agent2"
    agent2.vm.network "private_network", virtualbox__intnet: "LAN2", auto_config: false, mac: "0800270ca52b"
  end
end
