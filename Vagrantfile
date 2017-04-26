# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.require_version ">= 1.9.2" # host_ip below needed for 1.9.3

Vagrant.configure(2) do |config|
  if ENV["http_proxy"]
    config.vm.box = "westlife-eu/wp6-cernvm-dlproxy"
  else
    config.vm.box = "westlife-eu/wp6-cernvm"
  end
  # forward standard web
  config.vm.network "forwarded_port", host_ip: "127.0.0.1", guest: 80, host: 8081
  # forward depended tool (SCIPION)
  config.vm.network "forwarded_port",host_ip: "127.0.0.1", guest: 8000, host: 8001
  if Vagrant.has_plugin?("vagrant-proxyconf")
    if ENV["http_proxy"]
      config.proxy.http     =  ENV["http_proxy"] #"http://wwwcache.dl.ac.uk:8080"
    end
    if ENV["https_proxy"]
      config.proxy.https    = ENV["https_proxy"] #"http://wwwcache.dl.ac.uk:8080"
    end
    if ENV["no_proxy"]
      config.proxy.no_proxy = ENV["no_proxy"] #"localhost,127.0.0.1"
    end
  end
  config.vm.provider "virtualbox" do |vb|
  # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "2048"
    vb.cpus = "2"
    vb.customize ["modifyvm", :id, "--vram", "16"]
  end
  config.vm.synced_folder ".", "/vagrant"

  # uncomment/comment desired bootstrap type, if VM should be build from sources use bootstrapsources.sh
  # otherwise(default) use bootstrapcvmfs.sh  

  # config.vm.provision "shell",  path: "bootstrapsources.sh"
  config.vm.provision "shell",  path: "bootstrapcvmfs.sh"
end
