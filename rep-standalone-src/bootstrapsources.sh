#!/usr/bin/env bash
#17/10/2016 tomas - bootstrapt by getting sources from github, cloud version

##################################################
# get a wp6 master (3.3 MB) or git clone (21 MB) #
##################################################
yum -y install git dos2unix wget

echo downloading wp6 repository
# or alternatively git clone, commented
cd /opt
git clone https://github.com/h2020-westlife-eu/wp6-repository.git
cd wp6-repository
###########################
# download secret keys    #
###########################

#wget -O secrets.zip https://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#unzip secrets.zip 

###########################
# launch bootstrap script #
###########################

export WP6REPSRC=`pwd`
chown -R vagrant:vagrant $WP6REPSRC
dos2unix $WP6REPSRC/*.sh
chmod ugo+x $WP6REPSRSC/*.sh
$WP6REPSRC/bootstrap.sh
