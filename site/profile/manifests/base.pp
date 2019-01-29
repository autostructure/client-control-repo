class profile::base {

  #the base profile should include component modules that will be on all nodes

  notify {'Running puppet agent upgrade...':}

  class {'::puppet_agent':
    package_version => '6.0.4',
  }

}
