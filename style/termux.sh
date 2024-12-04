pkg install update
pkg install upgrade -y
pkg install git
pkg install wget
pkg install zsh
pkg install lsd

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
termux-reloud-settings

exit

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

nano .zshrc


git clone https://github.com/adi1090x/termux-style

cd termux-style

./install

./tstyle


wget https://raw.githubusercontent.com/gorontaloku/linux/refs/heads/main/tampilan.py
mv /data/data/com.termux/files/usr/etc/
