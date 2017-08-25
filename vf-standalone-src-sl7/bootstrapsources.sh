#!/usr/bin/env bash
#17/10/2016 tomas - bootstrapt by getting sources from github, cloud version

##################################################
# get a wp6 master (3.3 MB) or git clone (21 MB) #
##################################################
yum -y install git dos2unix
echo downloading west-life-wp6
#wget --quiet https://github.com/h2020-westlife-eu/west-life-wp6/archive/master.zip
#unzip -q master.zip -d /home/vagrant
#rm master.zip

# or alternatively git clone, commented
cd /home/vagrant
git clone https://github.com/h2020-westlife-eu/west-life-wp6.git

# optional switch to branch
cd west-life-wp6
git checkout dev
cd ..

# rename folder to master - comment if getting zip
rm -rf west-life-wp6-master
mv west-life-wp6 west-life-wp6-master

###########################
# launch bootstrap script #
###########################

export WP6SRC=/home/vagrant/west-life-wp6-master/wp6-virtualfolder
mkdir -p /home/vagrant/bootstrap
cp -R $WP6SRC/bootstrap/* /home/vagrant/bootstrap
dos2unix /home/vagrant/bootstrap/*
chmod ugo+x /home/vagrant/bootstrap/*.sh
chown -R vagrant:vagrant /home/vagrant/bootstrap
/home/vagrant/bootstrap/bootstrap.sh
# workaround, bug when http restart - Syntax error on line 1 of /etc/httpd/conf.modules.d/00-lua.conf: Cannot load modules/mod_lua.so
rm -rf /etc/httpd/conf.modules.d/00-lua.conf

