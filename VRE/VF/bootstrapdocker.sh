#!/usr/bin/env bash
#EXTRA COMMAND
useradd vagrant
echo "vagrant:vagrant"|chpasswd
#transcript from bootstrap scripts in order to prepare environment in clean VM
echo Provisioning West-Life Virtual Folder
cp -R /cvmfs/west-life.egi.eu/software/virtualfolder/latest/conf/* /
#make link to VF and VRE
ln -s /cvmfs/west-life.egi.eu/software/virtualfolder/latest /opt/virtualfolder
ln -s /cvmfs/west-life.egi.eu/software/jupyter/latest /opt/jupyter
ln -s /cvmfs/west-life.egi.eu/software/vre/latest /opt/vre
if [[ -n ${PORTAL_DEPLOYMENT} && ${PORTAL_DEPLOYMENT} -eq "1" ]]; then echo "portal deployment"; else mv /etc/httpd/conf.d/vre.inc.single /etc/httpd/conf.d/vre.inc; fi
service rsyslog restart
yum -y install epel-release
yum repolist
yum -y install davfs2
yum -y install httpd
systemctl start httpd
systemctl enable httpd
mkdir -p /srv/virtualfolder /etc/westlife /var/log/westlife /var/lib/westlife
chmod go+wx /var/log/westlife
usermod -a -G davfs2 vagrant
usermod -a -G davfs2 apache
usermod -g davfs2 vagrant
yum -y install sudo
if  grep -q MOUNTB2 /etc/sudoers; then
  echo sudoers already provisioned
else
  cat /opt/virtualfolder/scripts/sudoers >>/etc/sudoers
  echo "vagrant ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
fi
# transcript of bootstrapservice.sh
cert-sync /etc/pki/tls/certs/ca-bundle.crt
if [ -f /vagrant/metadata.key ]; then
  cp /vagrant/metadata.key /etc/westlife/metadata.key
  cp /vagrant/metadata.sqlite /var/lib/westlife/metadata.sqlite
fi
if [ -f /vagrant/westlife-metadata.service ]; then
  cp /vagrant/westlife-metadata.service /etc/conf/systemd/system/westlife-metadata.service
fi
if [ -f /etc/westlife/metadata.key ]
then
   source /etc/westlife/metadata.key
   export VF_STORAGE_PKEY
else
   yum -y install openssl
   export VF_STORAGE_PKEY=`openssl rand -base64 32`
   echo VF_STORAGE_PKEY=$VF_STORAGE_PKEY > /etc/westlife/metadata.key
   chmod 700 /etc/westlife
   chmod 600 /etc/westlife/metadata.key
fi
# transcript of bootstrapvre.sh, single deployment comment # transcript of bootstrapscipion.sh
if [[ -n ${PORTAL_DEPLOYMENT} && ${PORTAL_DEPLOYMENT} -eq "1" ]]; then yum -y install python-virtualenv; fi
#yum -y install openmpi openmpi-devel
#export PATH=$PATH:/cvmfs/west-life.egi.eu/tools/openmpi/1.6.5/bin
#mkdir -p /home/vagrant/.config/scipion/myfirstmap /home/vagrant/.config/scipion/mymovies /home/vagrant/.config/scipion/myresmap /home/vagrant/.config/scipion/firstmap /home/vagrant/.config/scipion/movies /home/vagrant/.config/scipion/resmap
#mkdir -p /home/vagrant/ScipionUserData/data/tests
#cp /cvmfs/west-life.egi.eu/software/scipion/latest/config/hosts.conf /home/vagrant/.config/scipion/myfirstmap
#cp /cvmfs/west-life.egi.eu/software/scipion/latest/config/hosts.conf /home/vagrant/.config/scipion/mymovies
#cp /cvmfs/west-life.egi.eu/software/scipion/latest/config/hosts.conf /home/vagrant/.config/scipion/myresmap
#cp /cvmfs/west-life.egi.eu/software/virtualfolder/latest/conf/Desktop/scipion* /home/vagrant/Desktop
#sudo -E -i -u vagrant /cvmfs/west-life.egi.eu/software/scipion/latest/scipion config
#chmod ugo+x /home/vagrant/Desktop/*
#add permission to allow browse webdav content in /home/vagrant/work
chmod ug+rwx /srv/virtualfolder
chown vagrant:apache /srv/virtualfolder
chmod 700 /var/lib/westlife
chown vagrant:vagrant /var/lib/westlife
touch /etc/westlife/vresqlite.db
chown -R vagrant:vagrant /home/vagrant
systemctl daemon-reload
systemctl enable westlife-metadata
systemctl start westlife-metadata
#single deployment comment, VRE deployment, uncomment
if [[ -n ${PORTAL_DEPLOYMENT} && ${PORTAL_DEPLOYMENT} -eq "1" ]]; then
  systemctl enable westlife-vre
  systemctl start westlife-vre
fi
# if vagrant dir is present, register it as default filesystem provider for vagrant/default user
if [ -d /vagrant ]; then /opt/virtualfolder/scripts/addfilesystemprovider.sh; fi
echo -e "BOOTSTRAP FINISHED, Virtual Folder provisioned.\nTo access VF services launch browser at http://localhost/"
