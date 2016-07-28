class jenkins::install inherits jenkins {

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  file { "/tmp":
    ensure => "present",
    mode   => "777",
    owner  => "root",
    group  => "root",
  }

  case $operatingsystem {
    "RedHat", "CentOS": { include jenkins::install_redhat  }
    /^(Debian|Ubuntu)$/:{ include jenkins::install_debian  }
    default:            { include jenkins::install_redhat  }
  }

  package { $java_package_name:
    ensure  => present,
  }

  package { "jenkins":
    ensure  => $package_ensure,
    require => [ Exec["install_key"],
                 File["file_repo"], 
                 Package["java-1.8.0-openjdk"], ],
  }

  if $service_manage == true {
    service { 'jenkins':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
