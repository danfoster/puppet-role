# A Role for the puppetmaster
class role::puppetmaster {
  selinux::module { 'puppet':
    ensure => 'present',
    source => 'puppet:///modules/role/puppetmaster/puppet.te',
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

  firewall { '050 accept foreman-proxy':
    port   => 8443,
    proto  => tcp,
    action => accept,
  }

  file { '/etc/puppet/hiera.yaml':
    ensure => file,
    source => 'puppet:///modules/role/puppetmaster/hiera.yaml',
  }

  file { '/etc/r10k.yaml':
    ensure => file,
    source => 'puppet:///modules/role/puppetmaster/r10k.yaml',
  }

  include foreman
  include foreman_proxy

  if ! defined(Class['puppet']) {
    class { 'puppet' : 
      server => true
    }
  }

  class { 'puppetdb': }
  class { 'puppetdb::master::config':
    manage_storeconfigs => false,
    restart_puppet => false
  }
    
  postgresql::server::db { $foreman::db_database:
    user     => $foreman::db_username,
    password => $foreman::db_password,
    owner    => $foreman::db_username,
  }


}
