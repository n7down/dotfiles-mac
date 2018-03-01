#!/bin/bash

# symbolic links to home folder
link_file() {
	source="${PWD}/$1"
	target="${HOME}/${1/_/.}"

	if [ -e $target ] ; then
		if [ ! -d $target ] ; then
			echo "Update $target"
			mv $target $target.bak
			ln -sf ${source} ${target}
		fi
	else
		echo "Install $target"
		ln -sf ${source} ${target}
	fi
}

# change default shell to zsh
if [ $SHELL != "/bin/zsh" ]
then
	echo "setting shell to zsh"
	chsh -s /bin/zsh
fi

# install vundle
if [ ! -d $HOME/.vim/bundle/Vundle.vim ]
then
	echo "installing vundle"
	sh -c "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
fi

# install oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]
then
	echo "installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# install fzf
if [ ! -d $HOME/.fzf ]
then
	echo "installing fzf"
	sh -c "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install"
fi

echo "creating/updating symlinks"
for i in _*
do
	link_file $i
done

# install oh-my-zsh themes
echo "installing oh-my-zsh themes"
cp oh-my-zsh/themes/gitster.zsh-theme $HOME/.oh-my-zsh/themes/

# run fc-cache
echo "executing fc-cache"
fc-cache

echo "completed - please logout and log back in for setup to take full effect"
