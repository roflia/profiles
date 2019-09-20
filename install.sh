parentfolder="$(echo $0 | sed -e 's/install.sh//g')"
cp -f $parentfolder/bashrc ~/.bashrc 
cp -f $parentfolder/zshrc ~/.zshrc
cp -f $parentfolder/vimrc ~/.vimrc 
cp -f $parentfolder/agnosterof.zsh-theme ~/.oh-my-zsh/themes/agnosterof.zsh-theme
