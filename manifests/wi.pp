node wi1 {
     class {'kvm':
		address 	=> '192.168.20.80',
		netmask 	=> '255.255.255.0',
		network 	=> '192.168.20.0',
		broadcast 	=> '192.168.20.255',
		gateway 	=> '192.168.20.1',
		interface 	=> 'eth0',
		dns 		=> '8.8.8.8',
		kvm_user	=> 'test',
		}
}










#/^wi[0-9]/ with regex node