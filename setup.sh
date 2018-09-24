# Ubuntu dependencies
# reconfigure dash to bash / choose 'NO'
sudo dpkg-reconfigure dash
###################################
# Clone the dependency repositories
########
# get poky layer
git clone -b rocko git://git.yoctoproject.org/poky.git poky-rocko
# get additional dependencies
cd  poky-rocko
git clone -b rocko git://git.openembedded.org/meta-openembedded
git clone -b rocko https://github.com/meta-qt5/meta-qt5
git clone -b rocko git://git.yoctoproject.org/meta-security
git clone -b rocko git://git.yoctoproject.org/meta-raspberrypi
# 
mkdir ~/rpi
cd ~/rpi
git clone -b rocko git://github.com/jumpnow/meta-rpi

# create a directory structure for RPi builds... example below
mkdir -p ~/rpi/build/conf
# or alternatively, use the Yocto environment script oe-init-build-env
# source poky-rocko/oe-init-build-env ~/rpi/build


# Customize the configuration files
cp meta-rpi/conf/local.conf.sample build/conf/local.conf
cp meta-rpi/conf/bblayers.conf.sample build/conf/bblayers.conf

#Edit bblayers.conf

#  In bblayers.conf file replace ${HOME} with the appropriate 
#  path to the meta-layer repositories on your system if you 
#  modified any of the paths in the previous instructions.

# WARNING: Do not include meta-yocto-bsp in your bblayers.conf. 
# The Yocto BSP requirements for the Raspberry Pi are in meta-raspberrypi.
# For example, if your directory structure does not look exactly like this, 
# you will need to modify bblayers.conf

# ~/poky-rocko/
#      meta-openembedded/
#      meta-qt5/
#      meta-raspberrypi
#      meta-security
#      ...
# 
# ~/rpi/
#     meta-rpi/
#     build/
#         conf/

# Edit local.conf
# 
# The variables you may want to customize are the following:
# 
#     MACHINE
#     TMPDIR
#     DL_DIR
#     SSTATE_DIR
# 		defaults are: 
# 		TMPDIR=~/rpi/build/tmp
# 		DL_DIR=~/rpi/build/sources
# 		SSTATE_DIR=~/rpi/build/sstate-cache
# 
# The defaults for all of these work fine with the exception of MACHINE.

# MACHINE
# 
# The MACHINE variable is used to determine the target architecture and various compiler tuning flags.
# 
# See the conf files under meta-raspberrypi/conf/machine for details.
# 
# The choices for MACHINE are
# 
#     raspberrypi (BCM2835)
#     raspberrypi0 (BCM2835)
#     raspberrypi0-wifi (BCM2835)
#     raspberrypi2 (BCM2836 or BCM2837 v1.2+)
#     raspberrypi3 (BCM2837)
#     raspberrypi-cm (BCM2835)
#     raspberrypi-cm3 (BCM2837)
# 
# You can only build for one type of MACHINE at a time.

###################
# RUN THE BUILD
###################

# You need to source the Yocto environment into your shell before you can use bitbake. 
# The oe-init-build-env will not overwrite your customized conf files.

source poky-rocko/oe-init-build-env ~/rpi/build

# I don’t use any of those Common targets, but instead always write my own custom image recipes.
# 
# The meta-rpi layer has some examples under meta-rpi/images/.
########
# Build
########

# ~/rpi/build$ 


# You may occasionally run into build errors related to packages that 
# either failed to download or sometimes out of order builds. The easy 
# solution is to clean the failed package and rerun the build again.
