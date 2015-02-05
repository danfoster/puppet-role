# A Role for the puppetmaster
class roles::puppetmaster {
  selinux::module { 'puppet':
    ensure => 'present',
    source => 'puppet:///modules/roles/puppetmaster/puppet.te',
  }

  firewall { '050 accept Puppet':
    port   => 8140,
    proto  => tcp,
    action => accept,
  }

  firewall { '050 accept web':
    port   => [80, 443],
    proto  => tcp,
    action => accept,
  }

  firewall { '050 accept tftp':
    port   => 69,
    proto  => udp,
    action => accept,
  }

  file { '/etc/puppet/hiera.yaml':
    ensure => file,
    source => 'puppet:///modules/roles/puppetmaster/hiera.yaml',
  }

}
