
pkg install git
pkg install wget
pkg install zsh
pkg install lsd
pkg install python

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

nano .zshrc

git clone https://github.com/adi1090x/termux-style

cd termux-style

./install

./tstyle

cd

wget https://raw.githubusercontent.com/gorontaloku/linux/refs/heads/main/tampilan.py
mv tampilan.py /data/data/com.termux/files/usr/etc/

cd /.oh-my-zsh
nano zshrc
