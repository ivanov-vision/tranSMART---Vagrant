# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    # configure VM
    config.vm.box = "ubuntu/trusty64"
    config.vm.box_version = "20180308.0.0"
    config.ssh.insert_key = false
    
    # configure provisioning
    config.vm.provision "shell", path: "bootstrap.sh", privileged: true
  
    # configure network ports
    config.vm.network "forwarded_port", host: 8080, guest: 8080 # tomcat7
   
  
    config.vm.provider "virtualbox" do |vb, override|
        vb.cpus = 1
        vb.memory = 4096
        vb.gui = false
        vb.name = "tranSMART"
        override.vm.synced_folder "./provision", "/vagrant"

        # disable the vbguest update plugin
        if Vagrant.has_plugin?("vagrant-vbguest")
            override.vbguest.auto_update = false
        end
    end
end
