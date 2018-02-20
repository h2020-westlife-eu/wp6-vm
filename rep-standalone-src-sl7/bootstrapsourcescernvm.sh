#!/bin/sh.after
. /etc/cernvm/site.conf
echo Provisioning CernVM...
usermod -G wheel,docker,users,vagrant vagrant
/etc/cernvm/config -x
date > /etc/vagrant_provisioned_at
echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "Defaults:vagrant !requiretty"   >> /etc/sudoers
if [ -s "/root/.ssh/authorized_keys" ]; then
  mkdir -p /home/vagrant/.ssh
  cp /root/.ssh/authorized_keys /home/vagrant/.ssh/authorized_keys
fi
cd /home/vagrant
if [ -f "/home/vagrant/.ssh/authorized_keys" ];then
  echo ssh public key exists, removing default pass
  passwd -d vagrant
else
  mkdir -p .ssh
  echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > .ssh/authorized_keys
  chmod 0600               .ssh/authorized_keys
  chmod 0700               .ssh
  chown -R vagrant:vagrant .ssh
  echo added non-secure public key
fi
# Do provisioning here
#!/usr/bin/env bash
#17/10/2016 tomas - bootstrapt by getting sources from github, cloud version

##################################################
# get a wp6 master (3.3 MB) or git clone (21 MB) #
##################################################
# git version 2.0 and git-secret
yum -y install http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm
yum -y install git dos2unix

# git-secret
wget https://bintray.com/sobolevn/rpm/rpm -O bintray-sobolevn-rpm.repo
mv bintray-sobolevn-rpm.repo /etc/yum.repos.d/
yum -y install git-secret

echo downloading wp6 repository
#wget --quiet https://github.com/h2020-westlife-eu/west-life-wp6/archive/master.zip
#unzip -q master.zip -d /home/vagrant
#rm master.zip

# or alternatively git clone, commented
cd
git clone https://github.com/h2020-westlife-eu/wp6-repository.git
# reveal git secrets - if public key is available
git reveal
cd wp6-repository
checkout dev-tomas

###########################
# launch bootstrap script #
###########################

export WP6REPSRC=`pwd`
chown -R vagrant:vagrant $WP6REPSRC
dos2unix $WP6REPSRC/*.sh
chmod ugo+x $WP6REPSRSC/*.sh
$WP6REPSRC/bootstrap.sh
exit

[amiconfig]
plugins=cernvm cernvm_appliance rapadminpassword

[rpath]
rap-password=

[cernvm_appliance]
password=

[cernvm]
organisations=None
shell=/bin/bash
config_url=http://cernvm.cern.ch/config
users=vagrant:vagrant:$6$UlU6Rl9a$TOSbHFSKhiqodkkate.nIb82dtTYOphWG4CePwrEp9IHCrFxeczRgoYn8mAf6IansKHjDCw6dr7kFaUrurg41/
edition=Desktop
keyboard=us-acentos
swap_size=2G
#start gui here

[ucernvm-begin]
cvmfs_branch=cernvm-sl7.cern.ch
cvmfs_server=hepvm.cern.ch
[ucernvm-end]
