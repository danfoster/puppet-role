# A Role for a samba server
class role::samba {
  class { '::samba::server':
    map_to_guest             => 'Bad User',
    preferred_master         => 'yes',
    shares                   => hiera_hash($samba_shares,{}),
    selinux_enable_home_dirs => true,
  }

  firewall { '050 accept smb':
    port   => [139, 445],
    proto  => tcp,
    action => accept,
  }


}
