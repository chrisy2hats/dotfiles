.PHONY : all
all: install-bash install-terminator install-vim install-xmonad install-git
.DEFAULT_GOAL := all

install-bash:
	cp -f bash/bash_aliases ~/.bash_aliases

install-terminator:
	mkdir -p ~/.config/terminator/
	cp -f terminator/config ~/.config/terminator/

install-vim:
	cp -f vim/vimrc ~/.vimrc

install-vim-theme:
	mkdir -p ~/.vim/colors
	git clone https://github.com/sjl/badwolf.git /tmp/badwolf
	mv /tmp/badwolf/colors/* ~/.vim/colors
	rm -rf /tmp/badwolf

install-xmonad:
	mkdir -p ~/.xmonad
	cp -f xmonad/xmonad.hs ~/.xmonad/xmonad.hs

install-xmonad-steam:
	mkdir -p ~/.xmonad
	cp -f xmonad/steamCompatibleXmonad.hs ~/.xmonad/xmonad.hs

install-git:
	cp -f git/gitconfig ~/.gitconfig

install-flatpak-overrides:
	mkdir -p ~/.local/share/flatpak/overrides
	cp -f flatpak/overrides/* ~/.local/share/flatpak/overrides/

configure-environment:
	sudo bash -c "cat etc/environment >> /etc/environment"

configure-dnf:
	sudo bash -c "cat dnf/dnf.conf >> /etc/dnf/dnf.conf"

install-firefox-flatpak-stub:
	cp firefox/flatpak-stub /tmp
	vim /tmp/flatpak-stub
	mv /tmp/flatpak-stub /usr/bin/firefox
