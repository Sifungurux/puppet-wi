node 'wihost' {

        class { 'wi':
          ipv6                  => 'off',
          server_name           => 'Wibintergrators',
          jail                  => true,
          proftp_admin          => 'pb',
          proftp_adm_password   => '$6$saltsalt$/alWecYH7Ry7BmdtYwV3ObFkYwJ96i4$
          proftp_group          => 'wi',
        }
}

