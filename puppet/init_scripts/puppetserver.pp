
service { 'puppetserver':
    ensure => running,
    enabled => true,
}

firewall { '100 allow Puppet master access':
    port   => '8140',
    proto  => tcp,
    action => accept,
}

