class jenkins::install_redhat inherits jenkins::install {

  file { "file_repo": 
    path   => "/etc/yum.repos.d/jenkins.repo",
    mode   => "644",
    owner  => "root",
    group  => "root",
    source => "puppet:///modules/jenkins/jenkins.repo",
  }

  file { "file_key":
    path   => "/tmp/${rh_key}",
    mode   => "644",
    owner  => "root",
    group  => "root",
    source => "puppet:///modules/jenkins/${rh_key}",
  }

  exec { "install_key":
    command => "rpm --import /tmp/${rh_key}",
    path    => ['/usr/bin', '/usr/sbin',],
    unless  => "rpm -qi gpg-pubkey-${pubkey_id} > /dev/null 2>&1",
    require => File["file_key"]
  }
}
