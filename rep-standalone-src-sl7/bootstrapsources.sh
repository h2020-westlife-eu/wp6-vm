#!/usr/bin/env bash
#17/10/2016 tomas - bootstrapt by getting sources from github, cloud version

##################################################
# get a wp6 master (3.3 MB) or git clone (21 MB) #
##################################################
yum -y install git dos2unix
echo downloading wp6 repository
#wget --quiet https://github.com/h2020-westlife-eu/west-life-wp6/archive/master.zip
#unzip -q master.zip -d /home/vagrant
#rm master.zip

# or alternatively git clone, commented
cd /home/vagrant
git clone https://github.com/h2020-westlife-eu/wp6-repository.git

###########################
# launch bootstrap script #
###########################

export WP6REPSRC=/home/vagrant/wp6-repository
chown -R vagrant:vagrant $WP6REPSRC
dos2unix $WP6REPSRC/*.sh
chmod ugo+x $WP6REPSRSC/*.sh
$WP6REPSRC/bootstrap.sh
# $WP6REPSRC/bootstrapaai.sh

