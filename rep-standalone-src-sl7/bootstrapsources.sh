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
