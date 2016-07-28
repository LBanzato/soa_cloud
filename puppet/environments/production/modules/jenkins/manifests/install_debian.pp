class jenkins::install_debian {

  file { "file_repo":
    path   => "/etc/apt/sources.list.d/jenkins.list",
    mode   => 644,
    owner  => root,
    group  => root,
    source => "puppet:///modules/jenkins/jenkins.list",
  }

  file { "file_key":
    path   => "/tmp/${deb_key}",
    mode   => 644,
    owner  => root,
    group  => root,
    source => "puppet:///modules/jenkins/${deb_key}",
    unless => "test `apt-key list 2>&1 | grep ${pubkey_id} | wc -l` -gt 0"
  }

  exec { "install_key":
    command => "sudo apt-key add /tmp/${deb_key}",
    path    => ['/usr/bin', '/usr/sbin',],
    unless  => "test `apt-key list 2>&1 | grep ${pubkey_id} | wc -l` -gt 0",
    require => File["file_key"]
  }

}
