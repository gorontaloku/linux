#!/bin/bash

# Unofficial Bash Strict Mode
set -euo pipefail
IFS=$'\n\t'

finish() {
  local ret=$?
  if [ ${ret} -ne 0 ] && [ ${ret} -ne 130 ]; then
    echo
    echo "ERROR: Failed to setup LINUX on Termux."
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

pkg update && yes | pkg upgrade
pkg install android-tools -y
pkg install x11-repo -y
pkg install termux-x11-nightly -y
pkg install file -y
pkg install pulseaudio -y
pkg install virglrenderer-android -y
pkg install proot-distro -y

#membuat folder shortcut widget
mkdir -p /data/data/com.termux/files/home/.shortcuts
chmod 700 -R /data/data/com.termux/files/home/.shortcuts

#install ubuntu
pd install ubuntu

#pindah File
mv storage/downloads/File2.tar /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/
cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/
tar -xf File2.tar
rm /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/File2.tar
cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/user2/Desktop/
rm /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/home/user2/Desktop/'Cek Update.desktop'

cd

#copy bacground keren
cp storage/downloads/xfce-leaves.svg /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/usr/share/backgrounds/xfce/

#copy notif desktop
cp storage/downloads/Notify.sh /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/

#copy widget
cp storage/downloads/Mulai.sh /data/data/com.termux/files/home/.shortcuts
cp storage/downloads/Matikan.sh /data/data/com.termux/files/home/.shortcuts

# Unduh termux x11
wget https://github.com/termux/termux-x11/releases/download/nightly/app-arm64-v8a-debug.apk
mv app-arm64-v8a-debug.apk $HOME/storage/downloads/


clear -x
echo ""
echo "Instalasi Telah Selesai!"
echo "Jangan Pernah Mencoba Untuk Instalasi Mandiri Tanpa Pengawasan Saya"
echo "BESTMOMEN"
echo ""
