#!/usr/bin/env bash
# This bootstraps Puppet Master on CentOS 7.x

REPO_URL="https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm"
PUPPET_HOME=/etc/puppetlabs/code
DOMAIN=mydomain.com
HOSTNAME=puppet.$DOMAIN
ENVIRONMENT=production

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Install wget
if which wget > /dev/null 2>&1; then
  echo "wget already installed, moving on..."
else
  echo "Installing wget..."
  yum install -y wget > /dev/null
fi

if which puppet > /dev/null 2>&1; then
  echo "Puppet is already installed."
else
  # Install puppet labs repo
  echo "Configuring PuppetLabs repo..."
  repo_path=$(mktemp)
  wget --output-document="${repo_path}" "${REPO_URL}" 2>/dev/null
  rpm -i "${repo_path}" >/dev/null

  # Install Puppet...
  echo "Installing puppetserver"
  yum install -y puppetserver > /dev/null
  echo "puppetserver installed!"
fi

if which git > /dev/null 2>&1; then
  echo "git is already installed."
else
  # Install git...
  echo "Installing git"
  yum install -y git > /dev/null
fi

echo "Cloning git repository..."
git clone https://github.com/LBanzato/soa_cloud.git
mv ./soa_cloud/puppet/hieradata/puppet_master ./soa_cloud/puppet/hieradata/$HOSTNAME
cp ./soa_cloud/puppet/hiera.yaml $PUPPET_HOME
cp -R ./soa_cloud/puppet/hieradata $PUPPET_HOME/environments/$ENVIRONMENT/hieradata
echo "HOSTNAME=$HOSTNAME" >> /etc/sysconfig/network
systemctl restart network
echo "Done!"

#systemctl start puppetserver
