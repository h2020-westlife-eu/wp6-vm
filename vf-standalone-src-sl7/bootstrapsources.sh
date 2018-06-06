#!/usr/bin/env bash
#17/10/2016 tomas - bootstrapt by getting sources from github, cloud version

##################################################
# get a wp6 master (3.3 MB) or git clone (21 MB) #
##################################################
yum -y install git dos2unix
echo downloading west-life-wp6
# download zip
#wget --quiet https://github.com/h2020-westlife-eu/west-life-wp6/archive/master.zip
#unzip -q master.zip -d /home/vagrant
#rm master.zip

# or git clone
cd /home/vagrant
git clone https://github.com/h2020-westlife-eu/west-life-wp6.git

# optional switch to branch
#cd west-life-wp6
#git checkout dev
#cd ..

# rename folder to master - comment if getting zip
rm -rf west-life-wp6-master
mv west-life-wp6 west-life-wp6-master

###########################
# launch bootstrap script #
###########################

export WP6SRC=/home/vagrant/west-life-wp6-master/wp6-virtualfolder
#export PORTAL_DEPLOYMENT=1  # enable VRE - multiuser environment - otherwise single user
export PORTAL_DEPLOYMENT=0
export ALLOW_JUPYTER=0 # 0=no jupyter 1=jupyter enabled - takes 30 minutes to install
chown -R vagrant:vagrant $WP6SRC
ln -s $WP6SRC/bootstrap /home/vagrant/bootstrap
dos2unix /home/vagrant/bootstrap/*
chmod ugo+x /home/vagrant/bootstrap/*.sh
/home/vagrant/bootstrap/bootstrap.sh
