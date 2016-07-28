# /etc/puppetlabs/puppet/manifests/site.pp

resources { 'firewall':
  purge => true,
}

hiera_include('classes')

