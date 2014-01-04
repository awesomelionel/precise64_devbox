# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

box      = 'precise64'
url      = 'http://files.vagrantup.com/precise64.box'
hostname = 'precise64devbox'
ip       = '192.168.56.111'
ram      = '256'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = box
  config.vm.box_url = url
  config.vm.host_name = hostname
	config.vm.network :private_network, ip: ip
	config.vm.network "forwarded_port", guest: 80, host: 4567
	config.ssh.forward_agent = true

	config.vm.provider :virtualbox do |v|
		v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", ram]
    v.customize ["modifyvm", :id, "--name", "precise64_devbox"]
	end

	config.vm.synced_folder "./", "/vagrant"
	config.vm.synced_folder "./www", "/var/www/", :owner => "www-data", :group => "www-data", :mount_options => ['dmode=775', 'fmode=644']
	# Update the server
	config.vm.provision :shell, :inline => "apt-get update --fix-missing"

  # provision the stack
  config.vm.provision :puppet do |puppet|
  
    # change fqdn to give to change the vm virtual host
    puppet.facter = { 
      "fqdn" => "vagrant-lamp-stack", 
      "hostname" => "www", 
      "docroot" => "/vagrant/public",
      "db_name" => "lamp",
      "db_user" => "lamp",
      "db_pass" => "lamp",
      "db_host" => "localhost",
    }
    
    # set the puppet manifests directory (relative to the project's root)
    puppet.manifests_path = "manifests"
    
    # choose the manifest
    puppet.manifest_file  = "site.pp"
    
    # instruct puppet where the modules are
    puppet.module_path = "modules"
    
		#puppet.options ="--verbose --debug"
  end
  
  # ready to go!
end
