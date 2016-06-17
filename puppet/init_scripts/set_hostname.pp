file { '/etc/hostname':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0644',
  content => "$::new_hostname\n",
  notify  => Exec['set-hostname'],
}

augeas { '/etc/sysconfig/network':
  context => '/files/etc/sysconfig/network',
  changes => [
    "set HOSTNAME $::new_hostname",
  ],
}

augeas { '/etc/hosts':
  context => '/files/etc/hosts',
  changes => [
    "set *[ipaddr = '127.0.0.1']/alias[last()+1] $::new_hostname"
  ],
  onlyif => "get *[ipaddr = '127.0.0.1']/alias[last()] != $::new_hostname",
}

exec { 'set-hostname':
  command => '/bin/hostnamectl $::new_hostname',
  unless  => '/usr/bin/test `hostname` = `/bin/cat /etc/hostname`',
}

