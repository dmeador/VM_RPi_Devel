# -*- mode: ruby -*-
# vi: set ft=ruby :

# ***IMPORTANT *** SETUP an VAGRANT_DEVEL ENVIRONMENT VARIABLE on the HOST machine
#on Windows, open a admin CMD terminal
#setx VAGRANT_DEVEL "c:/path/to/devel" /m
#setx VAGRANT_PATH "c:/path/to/vagrant" /m
#on Linux, open a terminal, add to user profile
#export VAGRANT_DEVEL "/path/to/devel"
#export VAGRANT_BUILD "/path/to/build/" 

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

	config.vm.box="ubuntu/xenial64"
	config.vm.network "private_network", type: "dhcp"

	# DO NOT modify or use VAGRANT_BUILD_* variables, these are for the FCU automated build system
	if ENV['VAGRANT_DEVEL'] != nil
		config.vm.synced_folder  "#{ENV.fetch('VAGRANT_DEVEL', 'default')}", "/devel"#, type: "nfs"
	end
	if ENV['VAGRANT_BUILD'] != nil 
		config.vm.synced_folder  "#{ENV.fetch('VAGRANT_BUILD', 'default')}", "/build"#, type: "nfs"
	end


	# The most common configuration options are documented and commented below.
	# For a complete reference, please see the online documentation at
	# https://docs.vagrantup.com.

	# Every Vagrant development environment requires a box. You can search for
	# boxes at https://vagrantcloud.com/search.
	config.vm.box = "ubuntu/xenial64"

	# Disable automatic box update checking. If you disable this, then
	# boxes will only be checked for updates when the user runs
	# `vagrant box outdated`. This is not recommended.
	config.vm.box_check_update = false

	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine. In the example below,
	# accessing "localhost:8080" will access port 80 on the guest machine.
	# NOTE: This will enable public access to the opened port
	# config.vm.network "forwarded_port", guest: 80, host: 8080

	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine and only allow access
	# via 127.0.0.1 to disable public access
	# config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

	# Create a private network, which allows host-only access to the machine
	# using a specific IP.
	# config.vm.network "private_network", ip: "192.168.33.10"

	# Create a public network, which generally matched to bridged network.
	# Bridged networks make the machine appear as another physical device on
	# your network.
	# config.vm.network "public_network"

	# Share an additional folder to the guest VM. The first argument is
	# the path on the host to the actual folder. The second argument is
	# the path on the guest to mount the folder. And the optional third
	# argument is a set of non-required options.
	# config.vm.synced_folder "../data", "/vagrant_data"

	# Provider-specific configuration so you can fine-tune various
	# backing providers for Vagrant. These expose provider-specific options.
	# Example for VirtualBox:
	#
	 config.vm.provider "virtualbox" do |vb|
		vb.name = "ubuntu64_devel"
		# Display the VirtualBox GUI when booting the machine
		#vb.gui = true

		# Customize the amount of memory on the VM:
		#vb.memory = "1024"
		vb.memory = "4096"
		config.disksize.size = '50GB'
	 end
	#
	# View the documentation for the provider you are using for more
	# information on available options.

	# Enable provisioning with a shell script. Additional provisioners such as
	# Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
	# documentation for more information about their specific syntax and use.
	# config.vm.provision "shell", inline: <<-SHELL
	#   apt-get update
	#   apt-get install -y apache2
	# SHELL
	
	# call from a external script
	#config.vm.provision "shell", path: "Vagrant.bootstrap.sh"

	config.vm.provision "shell", inline: <<-SHELL
		# allow packages for i386 arch
		sudo dpkg --add-architecture i386
		# update package database 
		sudo apt-get update
		echo "===================================="
		echo "==== Installing Ubuntu Packages ===="
		sudo apt-get install -y build-essential
		sudo apt-get install -y git
		sudo apt-get install -y chrpath
		sudo apt-get install -y diffstat
		sudo apt-get install -y gawk
		sudo apt-get install -y libncurses5-dev
		sudo apt-get install -y texinfo
		sudo apt-get install -y python
		sudo apt-get install -y python2.7
		sudo apt-get install -y python3
		sudo apt-get install -y gcc-multilib g++-multilib
		sudo apt-get install -y uuid-dev
		sudo apt-get install -y uuid-dev:i386
		sudo apt-get install -y perl-bignum
		sudo apt-get install -y perl-Thread-Queue
		# add compiler for ARM (RPi)
		sudo apt-get install -y g++-arm-linux-gnueabihf
		# add debugger for multiarch (ARM RPi)
		sudo apt-get install -y gdb-multiarch
		# add remote debugger for multiarch (ARM RPi)
		sudo apt-get install gdbserver

		sudo apt-get install -y cmake
		sudo apt-get install -y automake
		sudo apt-get install -y lynx
		sudo apt-get install -y ruby
		sudo apt-get install -y autogen
		sudo apt-get install -y texinfo
		sudo apt-get install -y libtool m4
		sudo apt-get install -y libcap-dev   
		sudo apt-get install git-core
		[[ ! -d /opt/pitools ]]	&& (cd /opt ; sudo git clone https://github.com/raspberrypi/tools.git --depth=1 pitools)

		echo "==== Done: Installing Ubuntu Packages ===="
		echo "=========================================="
		echo "todo: automate the following"
		echo "IF 32-bit: export PATH=$PATH:$HOME/rpi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin"
		echo "IF 64-bit: export PATH=$PATH:$HOME/rpi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin"
		echo "source .bashrc"
		echo " test gcc 'arm-linux-gnueabihf-gcc -v'"

	SHELL

end
