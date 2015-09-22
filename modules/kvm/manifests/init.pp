class kvm(
		$address = '192.168.20.80',
		$netmask = '255.255.255.0',
		$network = '192.168.20.0',
		$broadcast = '192.168.20.255',
		$gateway = '192.168.20.1',
		$interface = 'eth0',
		$dns = '8.8.8.8',
		){
		
	exec { "apt-get update":
        command => "/usr/bin/apt-get update -qq",
        }
	$kvm_packages = ["qemu-kvm","libvirt-bin","bridge-utils"]
	$kvm_user = 'kvmadmin'
	$kvm_user_pass = "$6$Ze/Np16u$VpKLYqxIKfB0MVjJ5X3mPV5sZR6ZXrH2SsqXJSXtVyKfgzNv/bBb2lv71I.mD6k7Es8YXM9QpHbQ4lxYWR/9Q1"
	
	package { $kvm_packages:
	ensure => installed,
	}
	user { $kvm_user :
		ensure        	=> present,
        managehome    	=> true,
        groups        	=> [ 'kvm', 'libvirt' ],
        shell         	=> "/bin/bash",
        password      	=> $kvm_user_pass,
		require			=> Package["qemu-kvm","libvirt-bin","bridge-utils"],
        }

	#setting up brigde interface
	exec { "addbr":
		command 		=> "brctl addbr br0",
		path    		=> "/sbin/",
		require			=> Package["bridge-utils"],
	}

	exec { "addif":
		command 		=> 'brctl addif br0 eth0',
		path    		=> '/sbin/',
		require 		=> Exec['addbr'],
	}

	file { '/etc/network/interfaces':
		content       	=> template('kvm/kvm-networking.erb'),
        owner         	=> root,
        group         	=> root,
        mode          	=> 644,
		require			=> Exec['addif'],
        }
	
		exec { "ifdown/ifup":
		command 		=> '/etc/init.d/networking restart',
		require 		=> File['/etc/network/interfaces'],
	}
}