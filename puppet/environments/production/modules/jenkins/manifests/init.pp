# Class: jenkins
# ===========================
#
# Full description of class jenkins here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream jenkins servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_jenkins_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { "jenkins':
#      servers => [ "pool.jenkins.org', 'jenkins.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class jenkins (
  $package_ensure      = $jenkins::params::package_ensure,
  $service_enable      = $jenkins::params::service_enable,
  $service_name        = $jenkins::params::service_name,
  $service_ensure      = $jenkins::params::service_ensure,
  $service_manage      = $jenkins::params::service_manage,
  $java_package_name   = $jenkins::params::java_package_name,
  $java_package_ensure = $jenkins::params::java_package_ensure,

) inherits jenkins::params {

  validate_string($package_ensure)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_string($java_package_name)
  validate_string($java_package_ensure)

  contain jenkins::install
 
}
