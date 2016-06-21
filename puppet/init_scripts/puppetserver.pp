
service { 'firewalld':
    ensure => stopped,
    enable => false
}

package { 'iptables-services':
    ensure  => present,
    require => Service['firewalld']
}

service { 'iptables':
    ensure  => running,
    enable  => true,
    require => Package['iptables-services'],
}

firewall { '100 puppet master port access':
    dport  => 8140,
    proto  => tcp,
    action => accept,
    require => Service['iptables'],
}

augeas { '/etc/sysconfig/puppetserver':
    context => '/files/etc/sysconfig/puppetserver',
    changes => [
        'set JAVA_ARGS \'"-Xms512m -Xmx512m"\'',
    ]
}

service { 'puppetserver':
    ensure  => running,
    enable  => true,
    require => Augeas['/etc/sysconfig/puppetserver'],
}

file { "$::confdir/autosign.conf":
    ensure  => present,
    content => "jenkins.soacloud.com\n",  
}

