/bootstrapcvmfswestlife.sh

source /cvmfs/west-life.egi.eu/tools/mono/mono-dev-env
cert-sync /etc/pki/tls/certs/ca-bundle.crt
yum install openssl
yum install httpd
yum install mod_ssl openssh

/bootstrapdocker.sh

/bootstrapsso.sh

#We deactivate the Virtual Folder option that enables filesystem browsing, for security reasons, since we're in a shared environment

sed -i 's/Environment=VF_ALLOW_FILESYSTEM=true/Environment=VF_ALLOW_FILESYSTEM=false/g' /etc/systemd/system/westlife-metadata.service

sed -i 's/ExecStart=\/bin\/mono \/opt\/virtualfolder\/MetadataService\/MetadataService.exe/ExecStart=\/cvmfs\/west-life.egi.eu\/tools\/mono\/latest\/bin\/mono \/opt\/virtualfolder\/MetadataService\/MetadataService.exe/g' /etc/systemd/system/westlife-metadata.service

systemctl stop westlife-metadata
systemctl daemon-reload
systemctl start westlife-metadata
service httpd restart
