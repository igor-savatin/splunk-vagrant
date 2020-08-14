# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_URL = "https://oracle.github.io/vagrant-projects/boxes"
BOX_NAME = "oraclelinux/7"

Vagrant.configure("2") do |config|
  config.vm.box = 'bento/oracle-7'
  config.vm.hostname = 'splunk-vagrant'
  config.vm.define 'splunk-vagrant'
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 8089, host: 8089
  config.vm.network "forwarded_port", guest: 8065, host: 8065
  config.vm.network "forwarded_port", guest: 8191, host: 8191
  config.vm.provider "virtualbox" do |vb|
   vb.memory = 2048
   vb.cpus   = 1
   vb.name   = 'splunk-vagrant'

   vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '0', '--nonrotational', 'on']
   
  end
  config.vm.provision "shell", inline: <<-SHELL
    sudo bash -c 'sh /vagrant/setup.sh'
  SHELL
end
