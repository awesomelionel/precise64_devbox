# -*- mode: ruby -*-
# vi: set ft=ruby :
#############################
# Vagrant LAMP Stack Config #
#############################
# OS          : Linux       #
# Database    : MySQL 5     #
# Web Server  : Apache 2    #
# PHP version : 5.3         #
#############################

# install apache, php and git
class{ 'apache': }
class{ 'php': }
class{ 'git': }
class{ 'vim': }
class{ 'redis': }

# create a virtual host using tha data provided in the vagrantfile
apache::vhost { $fqdn:
  docroot  => $docroot,
  port => '80',
  priority => '20',
}

# ensure mod_php and mod_rewrite are installed
apache::module { ['php5', 'rewrite']: }

# ensure other useful php modules are installed
php::module { ['xdebug', 'mysql', 'curl', 'gd', 'mcrypt']: }

# install mysql
class { 'mysql':
  root_password => 'root',
}

# create the database
mysql::grant { $db_name:
  mysql_privileges => 'ALL',
  mysql_password => $db_pass,
  mysql_db => $db_name,
  mysql_user => $db_user,
  mysql_host => $db_host,
  mysql_grant_filepath => '/root/mysql',
}

# rapid redirecting to project's root when logging in 
file { '/home/vagrant/.bashrc':
  ensure => 'present',
  content => 'cd /vagrant',
}

# ensure the docroot is a directory, that's it.
file { $docroot:
    ensure  => 'directory',
}

class { 'rbenv': }
rbenv::plugin { [ 'sstephenson/rbenv-vars', 'sstephenson/ruby-build' ]: }
rbenv::build { '2.0.0-p247': global => true }
rbenv::gem { 'thor': ruby_version   => '2.0.0-p247' }
rbenv::gem { 'middleman': ruby_version   => '2.0.0-p247' }

