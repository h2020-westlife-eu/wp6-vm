# WP6 - Virtual folder - test environment
A vagrant pool to configure VM environment with private West-life Virtual Research Environment. 
Use this for test/production environment, for development go https://github.com/h2020-westlife-eu/west-life-wp6

## Introduction
West-Life is a H2020 Virtual Research Environment project that will provide the application level services specific to uses cases in structural biology. 
Data management work package WP6 build on existing infrastructure for storing and accessing data. It provides application level service usable for structural biology use cases and follows structural biology data lifecycle (Report ...).
The WP6 is distributed as a vagrant package. Configuration files and scripts which initiates self deployment, installation and configuration of prototype virtual machine.
# Installation
Prerequisites:

 1. Vagrant - tool for automation of virtual machine deployment. Download and install vagrant from https://www.vagrantup.com/
 2. Virtualbox - VM stack. Download and install virtualbox https://www.virtualbox.org/wiki/Downloads

Download the VagrantFile from https://raw.githubusercontent.com/h2020-westlife-eu/wp6-vm/master/VagrantFile
or clone this repository into some [directory with VagrantFile]

(Optionally), if you are behind proxy, download and install proxyconf plugin and set environment variables

    export http_proxy=http://user:password@host:port
    export https_proxy=https://user:password@host:port
    export no_proxy=localhost
    vagrant plugin install vagrant-proxyconf

Open command-line (e.g. cmd, cygwin or terminal)
    
    cd [directory with VagrantFile]
    vagrant up

This will start CernVM customization and boots to Scientific Linux 7.2 and configures related WP. Depending on network speed it will take several to several tens of minutes - downloading 200 MB of data.

## Usage
The new virtual machine can be accessed by SSH (by default the 2222 port is forwarded to VM)

    vagrant ssh

or via GUI in virtualbox (username/password: vagrant/vagrant)

Or via web browser (port 8080 is by default forwarded to VM)

    http://localhost:8080/

##Current state of prototype implementation
After self deployment and installation the virtual machine provides 3 basic services:

 1. Web application at http://localhost:8080
	 - Optional connection to b2drop repository, directory browsing
 2. WebDAV protocol to the shared data at http://localhost:8080/webdav/

##Release Notes
- 26/10/2016 - tested on vagrant 1.8.6, compatible with VirtualBox 5.1, vagrant < 1.8.6 requires VirtualBox 5.0.x, doesn't require VirtualBox extension pack
- version 16.10 - tested on vagrant 1.8.1 and 1.8.4 and VirtualBox 5.0.26 (version 5.0.x compatible with vagrant, note version 5.1 not compatible with vagrant < 1.8.5), download from https://www.virtualbox.org/wiki/Download_Old_Builds_5_0 
and install VirtualBox Extension Pack 
