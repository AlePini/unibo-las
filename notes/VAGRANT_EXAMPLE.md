### File vagrant per configurazione di client-router1-router2-server

Con questo file tutti possono pingare tutti e amen

Per fare ssh sul primo router vagrant ssh router, sul  secondo vagrant ssh router2

```bash
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "las/bullseye64"
  config.vm.define :client do |client|
    client.vm.hostname = "client"
    client.vm.network "private_network",
      ip: "10.1.1.1",
      netmask: "255.255.255.0",
      gateway: "10.1.1.254",
      virtualbox__intnet: true
    client.vm.provision "shell", inline:<<-_END_
      ip r add 10.2.2.0/24 via 10.1.1.254
			ip r add 10.9.9.0/24 via 10.1.1.254
    _END_
    
  end
  config.vm.define :server do |server|
    server.vm.hostname = "server"
    server.vm.network "private_network",
      ip: "10.2.2.1",
      netmask: "255.255.255.0",
      gateway: "10.2.2.254",
      virtualbox__intnet: true
    server.vm.provision "shell", inline: <<-_END_
      ip r add 10.1.1.0/24 via 10.2.2.254
			ip r add 10.9.9.0/24 via 10.2.2.254
    _END_
  end
  config.vm.define :router do |router|
    router.vm.hostname = "router1"
    router.vm.network "private_network",
      ip: "10.1.1.254",
      netmask: "255.255.255.0",
      virtualbox__intnet: true
    router.vm.network "private_network",
      ip: "10.9.9.1",
      netmask: "255.255.255.0",
      virtualbox__intnet: true
    router.vm.provision "shell", inline: <<-_END_
      # instrada dal client al router 2
     ip r add  10.2.2.0/24 via 10.9.9.2
      # enable forwarding
      echo 1 > /proc/sys/net/ipv4/ip_forward
    _END_
  end 
  config.vm.define :router2 do |router2|
    router2.vm.hostname = "router2"
    router2.vm.network "private_network",
      ip: "10.9.9.2",
      netmask: "255.255.255.0",
      virtualbox__intnet: true
    router2.vm.network "private_network",
      ip: "10.2.2.254",
      netmask: "255.255.255.0",
      virtualbox__intnet: true
    router2.vm.provision "shell", inline: <<-_END_
      # instrada dal server al router 1
     ip r add 10.1.1.0/24 via 10.9.9.1
      # enable forwarding
      echo 1 > /proc/sys/net/ipv4/ip_forward
    _END_
  end 
  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook.yml"
   end
end
```