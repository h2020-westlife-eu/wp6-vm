# Virtual folder installation configuration

This repository contains various configuration for deployment of the Virtual Folder - part of West-life project. For the default VM deployment from source codes use rather https://github.com/h2020-westlife-eu/west-life-wp6

## Installation options:
Prerequisites:

 1. Vagrant (1.9.x supported, 1.9.5 recommended) - tool for automation of virtual machine deployment. Download and install vagrant from https://www.vagrantup.com/
 2. Virtualbox (5.0.x, 5.1.x supported, 5.1.22 recommended) - VM stack. Download and install virtualbox https://www.virtualbox.org/wiki/Downloads

Brief instructions:
```bash
git clone https://github.com/h2020-westlife-eu/wp6-vm
cd wp6-vm
cd [selected-vf-deployment] (optional) 
vagrant up
```
The `vagrant` tool will prepare Virtual Folder (VF) with this configuration
 1. vf-standalone-src - standalone VF from sources
 2. vf-standalone-bin - standalone VF from binaries
 3. vf-openstack-bin - cloud deployment VF into openstack from binaries
 4. vf-dataverse - VF with Dataverse software
  
## Comprehensive 

Download this metarepository [ZIP (4kB)](https://github.com/h2020-westlife-eu/wp6-vm/archive/master.zip) and unzip it into some [wp6-vm directory] or clone this repository https://github.com/h2020-westlife-eu/wp6-vm.git.

*1.* Open command-line (e.g. cmd, cygwin or terminal) and cd to directory where wp6-vm is unzipped/cloned
     
    cd [wp6-vm directory]

    
*2.* (Optionally), if you have used west-life VM before, update the vagrant box cache

    vagrant box update    

*3.* (Optionally), if you want install WP6 from source codes, cd to vf-local-from-sources

    cd vf-local-from-sources
    
*4.* (Optionally), based on step 3. the (master) branch from sources are cloned, to change it, edit the bootstrap*.sh file and uncomment/edit the following three lines (change 'dev' with a desired git branch):

    # optional switch to branch
    cd west-life-wp6
    git checkout dev
    cd ..

*5.* Start the vagrant box:

    vagrant up    

This will start VM template CernVM, boots to Scientific Linux 7.2 and performs some bootstrap scripts. Depending on network speed it will take several to several tens of minutes - downloading about 200 MB of data. Wait until "BOOTSTRAP FINISHED", otherwise the process failed, investigate the log and repeat the step 5.

## Usage

After 'vagrant up' finished, the new virtual machine can be accessed via web browser (port 8080 is by default forwarded to VM, check VagrantFile or vagrant log for exact port number)

    http://localhost:8080/

Default login name to VRE is vagrant/vagrant.
    
Files of the current working directory of host are mounted into the guest <code>/vagrant</code>.

You can access the guest by SSH (default port 2222 is forwarded to VM)

    vagrant ssh

or access GUI in virtualbox (username/password: vagrant/vagrant).

## Uninstallation - Cleaning

*6.* After testing you may, stop (halt) the VM:
   
    vagrant halt
    
*7.* If you'll not use the VM anymore, you can delete (destroy) the VM:
    
    vagrant destroy
    
## Release Notes

  * 27/06/2017 - added variation of Vagrant scripts for different deployment type
  * 03/05/2017 - works with Vagrant version 1.9.3 and bellow or 1.9.5 and above. Vagrant version 1.9.3 needs to use different Vagrantfile, Vagrant version 1.9.4 has bug preventing to bootstrap the VM.
  * 25/11/2016 - Updated vagrant boxes to use uCernVM 2.7.7 bootloader, updated OVA images in https://appdb.egi.eu/store/vappliance/d6.1.virtualfoldervm/vaversion/latest and vagrant boxes, do "vagrant box update", bug fixes, consolidated initial web page and design, fixed/added background services
  * 26/10/2016 - moved VagrantFile to new repository https://github.com/h2020-westlife-eu/wp6-vm, updated base box with uCernVM2.7.4 bootloader for CernVM 4 fixes security bug 'dirty COW' and aufs bug in kernel, https://atlas.hashicorp.com/westlife-eu, 
   * tested on Windows 7 64 bit, vagrant 1.8.6 + VirtualBox 5.1.6, vagrant 1.8.1, 1.8.4, VirtualBox 5.0.26, note vagrant < 1.8.6 requires VirtualBox 5.0.x, doesn't require VirtualBox extension pack, download from https://www.virtualbox.org/wiki/Download_Old_Builds_5_0 
   * tested on Ubuntu 14.04 LTS, (default vagrant 1.4.3 needs to be updated to 1.8.6), default VirtualBox 4.3.36 works
