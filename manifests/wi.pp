node wi1 {
     # class {'kvm':
		# address 	=> '192.168.20.80',
		# netmask 	=> '255.255.255.0',
		# network 	=> '192.168.20.0',
		# broadcast 	=> '192.168.20.255',
		# gateway 	=> '192.168.20.1',
		# interface 	=> 'eth0',
		# dns 		=> '8.8.8.8',
		# kvm_user	=> 'test',
		# }
		Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
		}

	include lamp::apache
	include lamp::php
# default root password is 'password'
	include lamp::mysql
	include lamp::phpmyadmin

	exec {"apt-get update":
	command => "apt-get update"
	}
}










#/^wi[0-9]/ with regex node