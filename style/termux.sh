pkg install git -y
pkg install wget -y
pkg install zsh -y
pkg install lsd -y
pkg install python 

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k


git clone https://github.com/adi1090x/termux-style

cd termux-style

./install

./tstyle

cd

wget https://raw.githubusercontent.com/gorontaloku/linux/refs/heads/main/tampilan.py
mv tampilan.py /data/data/com.termux/files/usr/etc/

echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> /data/data/com.termux/files/home/.zshrc
echo "
alias ls='lsd'" >> data/data/com.termux/files/home/.zshrc

echo "clear" >> $PREFIX/etc/zshrc
echo "cd ../usr/etc" >> $PREFIX/etc/zshrc
echo "python tampilan.py" >> $PREFIX/etc/zshrc
echo "cd" >> $PREFIX/etc/zshrc
