yum -y install gsi-openssh-clients
export X509_USER_CERT=/home/vagrant/.ssh/tk.crt
export X509_USER_KEY=/home/vagrant/.ssh/tk.key
gsissh -p 1975 cvmfs-upload01.gridpp.rl.ac.uk
gsiscp -v -P 1975 patch.tar.gz cvmfs-upload01.gridpp.rl.ac.uk:patch.tar.gz
