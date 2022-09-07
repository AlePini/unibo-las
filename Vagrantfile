# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "las/bullseye64"
  config.vm.synced_folder ".", "/vagrant", disabled: true

#  config.vm.provider "virtualbox" do |vb|
#    vb.memory = 512
#    vb.cpus = 2
#    vb.linked_clone = true
#  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "playbook.yml"
  end

  config.vm.define "SER" do |ser|
    ser.vm.hostname = "SER"
    # ser.vm.network "private_network", virtualbox__intnet: "NET2", auto_config: false
    ser.vm.network "private_network", virtualbox__intnet: "NET2", type: "dhcp"

  end

  config.vm.define "CL1" do |cl1|
    cl1.vm.hostname = "CL1"
  # cl1.vm.network "private_network", virtualbox__intnet: "NET1", auto_config: false
    cl1.vm.network "private_network", virtualbox__intnet: "NET1", type: "dhcp"
     #, mac: "0800270ca52a"
  end

  config.vm.define "ROU" do |rou|
    rou.vm.hostname = "ROU"
    rou.vm.network "private_network", virtualbox__intnet: "NET1", auto_config: false
    rou.vm.network "private_network", virtualbox__intnet: "NET2", auto_config: false
    #, mac: "0800270ca52b"
  end
end
