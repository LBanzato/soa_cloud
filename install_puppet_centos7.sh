#!/usr/bin/env bash
# This bootstraps Puppet on CentOS 7.x

set -e

REPO_URL="http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm"
PUPPET_HOME=/etc/puppet

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
  echo "Installing puppet"
  yum install -y puppet > /dev/null
  echo "Puppet installed!"
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
cp -R ./soa_cloud/puppet/* $PUPPET_HOME
echo "Done!"
