
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
correct_password="05"
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
pkg update && pkg upgrade
pkg install android-tools -y
pkg install x11-repo -y
pkg install termux-x11-nightly -y
pkg install file -y
pkg install pulseaudio -y
pkg install virglrenderer-android -y
pkg install proot-distro -y
pkg install wget -y


#install debian
mkdir -p /data/data/com.termux/files/usr/var/lib/proot-distro
mkdir -p /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs
clear -x
echo ""
echo "Hampir selesai, tunggulah beberapa saat!"
echo "Proses extract sedang berlangsung"
echo "jangan di close"
echo ""

#pindah File
cp storage/downloads/debian.tar.gz /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/
cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/
tar -xf debian.tar.gz
rm debian.tar.gz
cd

cd $PREFIX/var/lib/proot-distro/installed-rootfs/debian/
chmod +x Notify.sh

#copy widget
wget https://raw.githubusercontent.com/gorontaloku/linux/refs/heads/main/ubuntu/utils.sh
chmod +x utils.sh
./utils.sh

clear -x
echo ""
echo "Instalasi Telah Selesai!"
echo "Jangan Pernah Mencoba Untuk Instalasi Mandiri Tanpa Pengawasan Saya"
echo "BESTMOMEN"
echo ""