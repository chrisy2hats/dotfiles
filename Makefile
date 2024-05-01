.PHONY : all
all: install-bash install-terminator install-vim install-xmonad 
.DEFAULT_GOAL := all

install-bash:
	cp -f bash/bash_aliases ~/.bash_aliases

install-terminator:
	mkdir -p ~/.config/terminator/
	cp -f terminator/config ~/.config/terminator/

install-vim:
	cp -f vim/vimrc ~/.vimrc

install-xmonad:
	mkdir -p ~/.xmonad
	cp -f xmonad/xmonad.hs ~/.xmonad/xmonad.hs

install-xmonad-steam:
	mkdir -p ~/.xmonad
	cp -f xmonad/steamCompatibleXmonad.hs ~/.xmonad/xmonad.hs
