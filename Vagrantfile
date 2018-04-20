# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  config.vm.define "kube-master" do |master|

    vm = master.vm

    # Network config
    vm.network "private_network", ip: "192.168.0.1", virtualbox__intnet: "intnet"
    vm.provision :hosts, sync_hosts: true

    # Setup tools
    vm.provision :shell, path: "scripts/common/setup.sh"
    vm.provision :shell, path: "scripts/master/setup.sh"
  end

  (1..1).each do |i|
    config.vm.define "kube-node-#{i}" do |node|

      vm = node.vm
    
      # Network config
      vm.network "private_network", ip: "192.168.1.#{i}", virtualbox__intnet: "intnet"
      vm.provision :hosts, sync_hosts: true

      # Setup tools
      vm.provision :shell, path: "scripts/common/setup.sh"
    end
  end
end
