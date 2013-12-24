class mysql {
	package {
		"mysql-server":
			ensure => installed,
						 before => File["/etc/mysql/my.cnf"]
	}
	file {
		"/etc/mysql/my.cnf":
			owner  => root,
						 group  => root,
						 mode   => 644,
						 source => "puppet:///modules/mysql/my.cnf"
	}
	service {
		"mysql":
			ensure    => running,
								subscribe => File["/etc/mysql/my.cnf"]
	}
	exec {
		"mysql_password":
			unless  => "mysqladmin -uroot -proot status",
							command => "mysqladmin -uroot password root",
							require => Service[mysql];
		"test_vm_db":
			unless  => "mysql -uroot -proot test_vm_db",
							command => "mysql -uroot -proot -e 'create database test_vm_db'",
							require => Exec["mysql_password"]
	}
}
