# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"

    # config.vm.network "private_network", ip: "192.168.1.10"

    config.vm.provider "virtualbox" do |vb|
      vb.name = "Ubuntu 14.04 Desktop"
      vb.gui  = true

      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end

    config.vm.provision "shell", path: "scripts/provision/ubuntu-14.04-gdm.sh"
end
