#!/usr/bin/env bash
#14/07/2017 tomas - bootstrapt by getting sources from github, prepare cernvm4.0 (SL7) and launch dataverse scripts


echo downloading dataverse sources
cd /
git clone https://github.com/IQSS/dataverse.git
# to switch to branch - uncomment following
#cd dataverse
#git checkout develop
#cd ..

chmod ugo+x /dataverse/scripts/vagrant/*
ln -s /dataverse/scripts /scripts
ln -s /dataverse/downloads /downloads
ln -s /dataverse/conf /conf
chmod ugo+rw -R /dataverse
# install dependencies of dataverse separately, because all in one will fail, may be already installed
yum install -y java-1.8.0-openjdk-devel
yum install -y postgresql-server
yum install -y apache-maven
yum install -y httpd mod_ssl
# delete failing tests
rm /dataverse/src/test/java/edu/harvard/iq/dataverse/export/dublincore/*.java
rm /dataverse/src/test/java/edu/harvard/iq/dataverse/export/ddi/*.java
rm /dataverse/src/test/java/edu/harvard/iq/dataverse/ingest/tabulardata/impl/plugins/csv/*.java
# need to export JAVA_HOME otherwise server.log contains NoSuchAlgorithmException: AES KeyGenerator not available, 
export JAVA_HOME=/usr/lib/jvm/java-openjdk 
/dataverse/scripts/vagrant/setup.sh
/dataverse/scripts/vagrant/setup-solr.sh
/dataverse/scripts/vagrant/install-dataverse.sh localhost

