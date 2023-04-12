# TODO:
# Make Desktop Shortcuts -> https://www.linuxfordevices.com/tutorials/ubuntu/create-desktop-shortcuts-using-terminal & https://askubuntu.com/questions/1218954/desktop-files-allow-launching-set-this-via-cli
# Automatically add VM's to Virtualbox
# Fix givng robo acc perms for USB/TTY (usergroup dialout does not exist)
# All apps need to avaliable on application menu
# Get PC number Via host name or user input, name logfile after pc nummber

# NOTES:
# Godot has updated 4.0 (We prob need to stay on 3.5.1 due to the fact that the scirpting language is not backwards compatable and Ryan has not updated tutorials yet)
# Snaps are stored in /var/lib/snapd/desktop/applications
# To list all users - awk -F: '{ print $1 }' /etc/passwd
# Cannot create 'admin' user in Ubuntu because it is already used, so offical user is now administrator
# Before starting script, log into each user to create their home directory
# PC name should be "6118-PCNUMBER"


#! /bin/sh

#Initialize logging terminal output and commands used
script screen.log
sudo apt update && sudo apt upgrade
sudo apt autoremove
sudo snap refresh
sudo apt --fix-missing -y update

#Add Users
sudo useradd -p $(openssl passwd -1 student) gamedev
sudo useradd -p $(openssl passwd -1 student) robotics
sudo useradd -p $(openssl passwd -1 student) cisco

#Put all users into sudo group
usermod -aG sudo gamedev
usermod -aG sudo robotics
usermod -aG sudo cisco

	#Grant Robo account perms to USB/TTY ports
	sudo usermod -a -G dialout robotics

#Install Apps
sudo add-apt-repository -y ppa:gns3/ppa
sudo apt install -y git
sudo apt install -y putty
sudo apt install -y putty-tools
sudo apt install -y blender
sudo apt install -y gimp
sudo apt install -y wireshark
sudo apt install -y ostinato
sudo apt install -y virtualbox
sudo apt install -y nmap
sudo apt install -y gns3-gui gns3-server
#Get and install VMware VIX (Needed to use GNS3)
wget https://download3.vmware.com/software/player/file/VMware-VIX-1.17.0-6661328.x86_64.bundle
sudo chmod a+x VMware-VIX-1.17.0-6661328.x86_64.bundle
sudo ./VMware-VIX-1.17.0-6661328.x86_64.bundle
sudo snap install cirkit-designer
sudo snap install gd-godot-engine-snapcraft
sudo snap install code --classic
sudo snap install vlc
sudo snap install arduino
sudo snap install krita
#Download Chrome from the internet
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
# Install Chrome
sudo dpkg -i google-chrome-stable_current_amd64.deb 
#Download Github Desktop from the internet
wget https://github.com/shiftkey/desktop/releases/download/release-3.2.0-linux1/GitHubDesktop-linux-3.2.0-linux1.deb 
#Install Github Desktop
sudo apt install ./GitHubDesktop-linux-3.2.0-linux1.deb 
#Download Packet Tracer
wget https://bit.ly/3zNcdQ5
#Add .deb to the end of install file
mv ./3zNcdQ5 ./3zNcdQ5.deb
#Install Packet Tracer
sudo apt install -y ./3zNcdQ5.deb

#Create Desktop shortcuts 
	#GameDev
		#Github
		cp /usr/share/applications/github-desktop.desktop /home/gamedev/Desktop
		gio set /home/gamedev/Desktop/github-desktop.desktop metadata::trusted true
		chmod a+x /home/gamedev/Desktop/github-desktop.desktop
		#Chrome
		cp /usr/share/applications/google-chrome.desktop /home/gamedev/Desktop
		gio set /home/gamedev/Desktop/google-chrome.desktop metadata::trusted true
		chmod a+x /home/gamedev/Desktop/google-chrome.desktop
		#Blender (May not need since Y11 never do 3D, may change for a paint program)
		cp /usr/share/applications/blender.deskop /home/gamedev/Desktop
		gio set /home/gamedev/Desktop/blender.desktop metadata::trusted true
		chmod a+x /home/gamedev/Desktop/blender.desktop
		#Godot
		cp /var/lib/snapd/desktop/applications/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop /home/gamedev/Desktop
		gio set /home/gamedev/Desktop/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop metadata::trusted true
		chmod a+x /home/gamedev/Desktop/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop
		#VS Code
		cp /var/lib/snapd/desktop/applications/code_code.desktop /home/gamedev/Desktop
		gio set /home/gamedev/Desktop/code_code.desktop metadata::trusted true
		chmod a+x /home/gamedev/Desktop/code_code.desktop

	#Robo
		#Github
		cp /usr/share/applications/github-desktop.desktop /home/robotics/Desktop
		gio set /home/robotics/Desktop/github-desktop.desktop metadata::trusted true
		chmod a+x /home/robotics/Desktop/github-desktop.desktop
		#Chrome
		cp /usr/share/applications/google-chrome.deskop /home/robotics/Desktop
		gio set /home/robotics/Desktop/google-chrome.desktop metadata::trusted true
		chmod a+x /home/robotics/Desktop/google-chrome.desktop
		#VS Code
		cp /var/lib/snapd/desktop/applications/code_code.desktop /home/robotics/Desktop
		gio set /home/robotics/Desktop/code_code.desktop metadata::trusted true
		chmod a+x /home/robotics/Desktop/code_code.desktop
		#Arduino
		cp /var/lib/snapd/desktop/applications/arduino_arduino.desktop /home/robotics/Desktop
		gio set /home/robotics/Desktop/arduino_arduino.desktop metadata::trusted true
		chmod a+x /home/robotics/Desktop/arduino_arduino.desktop
		#Cirkit Designer
		cp /var/lib/snapd/desktop/applications/cirkit-designer_cirkit-designer.desktop /home/robotics/Desktop
		gio set /home/robotics/Desktop/cirkit-designer_cirkit-designer.desktop metadata::trusted true
		chmod a+x /home/robotics/Desktop/cirkit-designer_cirkit-designer.desktop

	#CISCO
		#Virtual Box
		cp /usr/share/applications/virtualbox.desktop /home/cisco/Desktop
		gio set /home/cisco/Desktop/virtualbox.desktop metadata::trusted true
		chmod a+x /home/cisco/Desktop/virtualbox.desktop
		#GNS3
		cp /usr/share/applications/gns3.desktop /home/cisco/Desktop
		gio set /home/cisco/Desktop/gns3.desktop metadata::trusted true
		chmod a+x /home/cisco/Desktop/gns3.desktop
		#Wireshark
		cp /usr/share/applications/org.wireshark.Wireshark.desktop /home/cisco/Desktop
		gio set /home/cisco/Desktop/org.wireshark.Wireshark.desktop metadata::trusted true
		chmod a+x /home/cisco/Desktop/org.wireshark.Wireshark.desktop
		#Google Chrome
		cp /usr/share/applications/google-chrome.desktop /home/cisco/Desktop
		gio set /home/cisco/Desktop/google-chrome.desktop metadata::trusted true
		chmod a+x /home/cisco/Desktop/google-chrome.desktop
		#PuttY
		cp /usr/share/applications/putty.desktop /home/cisco/Desktop
		gio set /home/cisco/Desktop/putty.desktop metadata::trusted true
		chmod a+x /home/cisco/Desktop/putty.desktop

#Import VM images using VboxManage on 'cisco' user
su -l cisco
cd Downloads
vboxmanage import Raspberry_Pi_OS.ova
vboxmanage import Take-Home_CSC_Challenges.ova
vboxmanage import Take-Home_CSC_Kali.ova
su -l administrator

#Cleanup downloads from internet

#Check all packages again
sudo apt update && sudo apt upgrade
sudo apt autoremove
sudo snap refresh
sudo apt --fix-missing -y update
sudo apt upgrade

#Exit logging terminal state
exit

#Exit terminal after script is finished
exit

