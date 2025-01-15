rm -rf ~/.alias
rm -rf ~/.bashrc
rm -rf ~/.functions
rm -rf ~/.gitconfig
rm -rf ~/.inputrc
rm -rf ~/.profile
rm -rf ~/.local/share/gnome-shell/extensions
rm -rf ~/.local/share/fonts/other
rm -rf /usr/share/fonts/other

ln -s ~/.dotfiles/.alias ~/.alias
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.functions ~/.functions
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.inputrc ~/.inputrc
ln -s ~/.dotfiles/.profile ~/.profile
ln -s ~/.dotfiles/gnome-extensions ~/.local/share/gnome-shell/extensions
ln -s ~/.dotfiles/fonts ~/.local/share/fonts
ln -s ~/.dotfiles/fonts /usr/share/fonts/other
