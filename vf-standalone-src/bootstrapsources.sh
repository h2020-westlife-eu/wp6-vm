#!/usr/bin/env bash
#17/10/2016 tomas - bootstrapt by getting sources from github, cloud version

##################################################
# get a wp6 master (3.3 MB) or git clone (21 MB) #
##################################################

echo downloading west-life-wp6
#wget --quiet https://github.com/h2020-westlife-eu/west-life-wp6/archive/master.zip
#unzip -q master.zip -d /home/vagrant
#rm master.zip

# or alternatively git clone, commented
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
dos2unix $WP6SRC/bootstrap/*
chmod ugo+x $WP6SRC/bootstrap/*.sh
$WP6SRC/bootstrap/bootstrap.sh
