# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
	config.vm.box_url ="http://files.vagrantup.com/precise64.box"

	#set hostname
  config.vm.host_name = "devbox.example.com"
	config.vm.network :private_network, ip: "192.168.56.101"
	config.vm.network "forwarded_port", guest: 80, host: 4567

	config.ssh.forward_agent = true
	config.vm.provider :virtualbox do |v|
		v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 512]
    v.customize ["modifyvm", :id, "--name", "precise64-devbox"]
	end

	#Sync folders. Don't ever do sync to /home/vagrant/. You'll override the ssh files
	config.vm.synced_folder "./", "/vagrant", :nfs => true
	config.vm.synced_folder "./www", "/var/www/" , :owner => 'www-data', :group => 'www-data'

	config.vm.provision "puppet" do |puppet|
		# change fqdn to give to change the vm virtual host
    puppet.facter = { 
      "fqdn" => "vagrant-lamp-stack", 
      "hostname" => "www", 
      "docroot" => "/vagrant/public",
      "db_name" => "precise64",
      "db_user" => "root",
      "db_pass" => "root",
      "db_host" => "localhost",
    }

		puppet.manifests_path = "manifests"
		puppet.manifest_file = "site.pp"
		puppet.module_path ="modules"
	end

end
