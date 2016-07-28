class firwallcfg {

  Firewall {
    before  => Class['firwallcfg::post'],
    require => Class['firwallcfg::pre'],
  }

  class { ['firwallcfg::pre', 'firwallcfg::post']: }

  class { 'firewall': }

}
