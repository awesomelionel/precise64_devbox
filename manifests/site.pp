Exec { 	path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}
exec {"apt-update": command => "/usr/bin/apt-get update"}
Exec["apt-update"] -> Package <| |> 

include puppi
include apache2
include mysql
include vim
include php

class { 'rbenv': }
rbenv::plugin { [ 'sstephenson/rbenv-vars', 'sstephenson/ruby-build' ]: }
rbenv::build { '2.0.0-p247': global => true }
rbenv::gem { 'thor': ruby_version   => '2.0.0-p247' }

