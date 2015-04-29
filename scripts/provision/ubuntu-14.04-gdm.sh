#!/bin/bash

#
# PACKAGES' REPOSITORY SETUP
#

# repo: sublime-text-3
add-apt-repository -y ppa:webupd8team/sublime-text-3

# repo: ubuntu-mozilla-security
add-apt-repository -y ppa:ubuntu-mozilla-security/ppa

# repo: google-chrome

SOURCE_LIST='/etc/apt/sources.list.d/google-chrome.list'

if [ ! -f $SOURCE_LIST ]; then
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
	echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > $SOURCE_LIST
fi

#
# PACKAGES' REPOSITORY UPDATE
#

apt-get update 

#
# SAFE-UPGRADE INSTALLED PACKAGES
#
aptitude -y safe-upgrade

#
# PACKAGES' INSTALLATION
#

# install desktop manager
apt-get install -y gdm && dpkg-reconfigure gdm

# install desktop file manager and graphical shell
apt-get install -y nautilus

# install desktop terminal
apt-get install -y gnome-terminal

# install text editor
apt-get install -y sublime-text-installer

# install text google-chrome
apt-get install -y firefox

# install text google-chrome
# apt-get install -y google-chrome-stable


#
# VM ENVIRONMENT SETUP
#

USER_NAME='vagrant'

USER_HOME_DIR="/home/$USER_NAME"
ROOT_HOME_DIR='/root'

# bash environment

VM_ENV_FILE='/vagrant/scripts/vm-env.sh'

function update_bashrc()
{
	COMMENT=$1
	   TEXT=$2
	   FILE=$3

	# add given text in file _only if_ it's not there already.
	if [ "$( grep "$TEXT" $FILE )" = '' ]; then
		echo ""       >> $FILE
		echo $COMMENT >> $FILE
		echo $TEXT    >> $FILE
	fi
}

if [ -f $VM_ENV_FILE ]; then
	update_bashrc '# Vagrant VM environment variables' "source $VM_ENV_FILE" "$USER_HOME_DIR/.bashrc"
	update_bashrc '# Vagrant VM environment variables' "source $VM_ENV_FILE" "$ROOT_HOME_DIR/.bashrc"
else
	echo 'Notice: no VM environment variable found.'
fi

# Cleanup
apt-get autoremove