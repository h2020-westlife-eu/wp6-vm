#!/usr/bin/env bash
##################################################
# get a wp6 master (3.3 MB) or git clone (21 MB) #
##################################################
echo downloading west-life-wp6
#wget --quiet https://github.com/h2020-westlife-eu/west-life-wp6/archive/master.zip
#unzip -q master.zip -d /opt/virtualfolder-src
#rm master.zip
# or alternatively git clone, commented
mkdir -p /opt/virtualfolder-src
cd /opt/virtualfolder-src
git clone https://github.com/h2020-westlife-eu/west-life-wp6.git

###########################
# launch bootstrap script #
###########################

export WP6SRC=/opt/virtualfolder-src/west-life-wp6/wp6-virtualfolder
export PORTAL_DEPLOYMENT=0  # enable VRE - multiuser environment - otherwise single user
export SSO_DEPLOYMENT=1 # enable SSO -multiuser environment
chown -R vagrant:vagrant $WP6SRC
$WP6SRC/bootstrap/bootstrap.sh
