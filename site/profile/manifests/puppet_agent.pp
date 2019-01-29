class profile::puppet_agent {

  notify {'Running puppet agent upgrade...':}

  class {'::puppet_agent':
    package_version => '6.0.4',
  }

}
