#!/bin/bash
# Unofficial Bash Strict Mode
set -euo pipefail
IFS=$'\n\t'
finish() {
  local ret=$?
  if [ ${ret} -ne 0 ] && [ ${ret} -ne 130 ]; then
    echo
    echo "ERROR: Failed to setup Linux on Termux."
    echo "Please refer to the error message(s) above"
  fi
}
trap finish EXIT
  clear 
echo ""
echo "Ini Adalah Script Install Linux Di Termux"
echo "Hati-Hati Dalam Penggunaan Script Ini"
echo " Developer  : Bestmomen "
echo " My Number  : 082311123196 "
echo ""

termux-change-repo
# Display a message 
clear -x
echo ""
echo "Setting up Termux Storage Access." 
# Wait for a single character input 
echo ""
read -n 1 -s -r -p "Press any key to continue..."
termux-setup-storage
# Set the correct password here
correct_password="as"
# Function to prompt for password
prompt_for_password() {
    echo "Enter the username:"
    read -s entered_password  # Read password input silently
}
# Main logic
while true; do
    prompt_for_password
    if [[ "$entered_password" == "$correct_password" ]]; then
        echo "Correct password entered. Access granted!"
        break  # Exit the loop if correct password is entered
    else
        echo "Incorrect password. Please try again."
    fi
done
clear
pkg update && pkg upgrade -y
pkg install x11-repo -y
pkg install termux-x11-nightly -y
pkg install pulseaudio -y
pkg install proot-distro -y
pkg install wget -y
apt install tsu -y

#install ubuntu
pd install ubuntu
pd login ubuntu

clear -x

#update repositori
apt update -y
apt upgrade -y
apt install gdebi
apt install sudo nano adduser
adduser
adduser droidmaster
nano /etc/sudoers

su - droidmaster
whoami
sudo whoami
exit
exit

pd login ubuntu --user droidmaster
sudo apt install dbus-x11 ubuntu-desktop -y
for file in $(find /usr -type f -iname "*login1*"); do rm -rf $file
done

cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
# To prevent repository packages from triggering the installation of Snap,
# this file forbids snapd from being installed by APT.
# For more information: https://linuxmint-user-guide.readthedocs.io/en/latest/snap.html
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

sudo add-apt-repository ppa:mozillateam/ppa
sudo apt-get update
sudo apt-get install firefox-esr

sudo apt install xfce4 -y
wget https://wpsoffice.wahyupratama-purba2004.workers.dev/0:/wpsoffice.deb
sudo gdebi wpsoffice.deb
exit

wget https://raw.githubusercontent.com/gorontaloku/linux/refs/heads/main/startxfce4_ubuntu.sh
chmod +x startxfce4_ubuntu.sh

wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_ubuntu/startgnome_ubuntu.sh
chmod +x startgnome_ubuntu.sh



clear -x
echo ""
echo "Instalasi Telah Selesai!"
echo "Jangan Pernah Mencoba Untuk Instalasi Mandiri Tanpa Pengawasan Saya"
echo "BESTMOMEN"
echo ""
