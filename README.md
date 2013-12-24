#Vagrant DEV BOX
This Vagrant Box contains:

1.  Vim
2.  PHP v5.3.5
3.  RBENV  
4.  Ruby 2.0.0p247
5.  MySQL
6.  Apache2
7.  Puppi -> Contains dependencies like curl, wget, rsync, unzip

###REQUIREMENTS:
VirtualBox: [https://www.virtualbox.org/](https://www.virtualbox.org/)

Vagrant: [Vagrantup.com](http://www.vagrantup.com)

###To Use:

1.  Clone the repo and `cd` into the directory.
2.  Modify `config.vm.network :private_network, ip: "192.168.56.101"`. Set the ip to what you want the Virtual Machine to be on the local network.
3.  Modify `config.vm.network "forwarded_port", guest: 80, host: 4567`. Set the port that the Virtual Machine will forward port 80 to your own localhost.
4.  Run `vagrant up` to boot up the Dev Box.
5.  Run `vagrant ssh` to ssh into the Dev Box. The box does not have a `sudo` password. 
6.  Any file you create in the directory will automatically be symlinked into the `/vagrant` folder
