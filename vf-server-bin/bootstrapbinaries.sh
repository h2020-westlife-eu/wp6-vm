#!/usr/bin/env bash
# configure cvmfs 
if [ ! -d "/cvmfs" ]; then
  yum install -y https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
  yum install -y cvmfs cvmfs-config-default
  cvmfs_config setup
  echo "CVMFS_REPOSITORIES=west-life.egi.eu,wenmr.egi.eu
  #change it to local http proxy instance - squid, or similar
  CVMFS_HTTP_PROXY=DIRECT
  " >/etc/cvmfs/default.local
  
  service autofs restart
  cvmfs_config probe
fi

export PORTAL_DEPLOYMENT=0  # enable VRE - multiuser environment - otherwise single user
export SSO_DEPLOYMENT=1 # enable SSO -multiuser environment
export WP6SRC=/opt/virtualfolder-src/wp6-virtualfolder
mkdir -p $WP6SRC
yum install -y mono-core
ln -s /cvmfs/west-life.egi.eu/software/virtualfolder/latest /opt/virtualfolder
/cvmfs/west-life.egi.eu/software/virtualfolder/latest/bootstrap/bootstrapcloud.sh
/cvmfs/west-life.egi.eu/software/virtualfolder/latest/bootstrap/bootstrapsso.sh