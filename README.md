# Virtual folder
## Introduction
West-Life is a H2020 Virtual Research Environment project that will provide the application level services specific to uses cases in structural biology. 
Data management work package WP6 build on existing infrastructure for storing and accessing data. It provides application level service usable for structural biology use cases and follows structural biology data lifecycle (Report ...).
The WP6 is distributed as a vagrant package. Configuration files and scripts which initiates self deployment, installation and configuration of prototype virtual machine.

## Installation
Prerequisites:

 1. Vagrant - tool for automation of virtual machine deployment. Download and install vagrant from https://www.vagrantup.com/
 2. Virtualbox - VM stack. Download and install virtualbox https://www.virtualbox.org/wiki/Downloads

Choose one of the following
 - (prefered) download this metarepository [ZIP (4kB)](https://github.com/h2020-westlife-eu/wp6-vm/archive/master.zip) and unzip it into some [wp6-vm directory] or clone the meta repository from https://github.com/h2020-westlife-eu/wp6-vm.git.

*1.* Open command-line (e.g. cmd, cygwin or terminal) and cd to directory where wp6-vm is unzipped/cloned
     
    cd [wp6-vm directory]

    
*2.* (Optionally), if you have used west-life VM before, update the vagrant box cache

    vagrant box update    

*3.* (Optionally), if you want install WP6 from source codes,
   edit Vagrantfile and uncomment bootstrapsources.sh and comment bootstrapcvmfs.sh lines:

   
   config.vm.provision "shell",  path: "bootstrapsources.sh"
   # config.vm.provision "shell",  path: "bootstrapcvmfs.sh"

*4.* (Optionally), based on step 3. the (master) branch from sources are cloned, to change it, edit the bootstrapcloud.sh file and uncomment/edit the following three lines (change 'dev' with a desired git branch):

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
    
##Release Notes

  * 25/11/2016 - Updated vagrant boxes to use uCernVM 2.7.7 bootloader, updated OVA images in https://appdb.egi.eu/store/vappliance/d6.1.virtualfoldervm/vaversion/latest and vagrant boxes, do "vagrant box update", bug fixes, consolidated initial web page and design, fixed/added background services
  * 26/10/2016 - moved VagrantFile to new repository https://github.com/h2020-westlife-eu/wp6-vm, updated base box with uCernVM2.7.4 bootloader for CernVM 4 fixes security bug 'dirty COW' and aufs bug in kernel, https://atlas.hashicorp.com/westlife-eu, 
   * tested on Windows 7 64 bit, vagrant 1.8.6 + VirtualBox 5.1.6, vagrant 1.8.1, 1.8.4, VirtualBox 5.0.26, note vagrant < 1.8.6 requires VirtualBox 5.0.x, doesn't require VirtualBox extension pack, download from https://www.virtualbox.org/wiki/Download_Old_Builds_5_0 
   * tested on Ubuntu 14.04 LTS, (default vagrant 1.4.3 needs to be updated to 1.8.6), default VirtualBox 4.3.36 works

##Further doc
http://internal-wiki.west-life.eu/w/index.php?title=D6.1
