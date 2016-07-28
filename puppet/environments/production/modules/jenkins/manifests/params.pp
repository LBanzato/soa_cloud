# PRIVATE CLASS - do not use directly
#
# The jenkinsb default configuration settings.
class jenkins::params {

  $package_ensure      = "present"
  $service_enable      = true
  $service_ensure      = "running"
  $service_manage      = true
  $service_name        = "jenkins"
  $java_package_name   = "java-1.8.0-openjdk"
  $java_package_ensure = "present"

  $pubkey_id      = "d50582e6"
  $rh_key         = "jenkins_rh.key"
  $deb_key        = "jenkins_deb.key"
}
