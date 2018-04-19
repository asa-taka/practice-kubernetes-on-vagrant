# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  config.vm.define "kube-master" do |master|

    vm = master.vm

    # Network config
    vm.network "private_network", ip: "192.168.0.1"
    vm.provision :hosts, sync_hosts: true

    # Insatall packages
    vm.provision :file, source: "config", destination: "/tmp/"
    vm.provision :shell, inline: "
      cd /tmp/config &&
      cp common/etc/yum.repos.d/* /etc/yum.repos.d &&
      yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd &&
      cp master/etc/etcd/* /etc/etcd &&
      cp master/etc/kubernetes/* /etc/kubernetes &&
      sudo sh master/scripts/restart-ps
    "
  end

  (1..3).each do |i|
    config.vm.define "kube-node-#{i}" do |node|

      vm = node.vm
    
      # Network config
      vm.network "private_network", ip: "192.168.1.#{i}"
      vm.provision :hosts, sync_hosts: true

      # Insatall packages
      vm.provision :file, source: "config", destination: "/tmp/"
      vm.provision :shell, inline: "
        cd /tmp/config &&
        cp common/etc/yum.repos.d/* /etc/yum.repos.d &&
        yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd &&
        cp node/etc/kubernetes/* /etc/kubernetes &&
        sudo sh node/scripts/restart-ps
      "
    end
  end
end
