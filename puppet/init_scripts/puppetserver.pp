
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

service { 'puppetserver':
    ensure => running,
    enable => true,
}

