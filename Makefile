.PHONY : all
all: install-bash install-terminator install-vim install-xmonad install-git
.DEFAULT_GOAL := all

install-bash:
	cp -f bash/bash_aliases ~/.bash_aliases

install-terminator:
	mkdir -p ~/.config/terminator/
	cp -f terminator/config ~/.config/terminator/

install-terminator-plugin:
	git clone https://github.com/chrisy2hats/TerminatorFileManager /tmp/TerminatorFileManager
	mkdir -p ~/.config/terminator/plugins/
	mv /tmp/TerminatorFileManager/plugin.py ~/.config/terminator/plugins/


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

configure-make-autocomplete:
	echo "complete -W \"\\\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$$//'\\\`\" make" >> ~/.bashrc


configure-ps1:
	echo 'export PS1="$$(,ps1_prompt)"' >> ~/.bashrc

configure-go:
	go env -w GOPATH=$$HOME/.go

add-flathub-remote:
	flatpak remote-add --if-not-exists flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"

install-firefox-flatpak-stub:
	cp firefox/flatpak-stub /tmp
	vim /tmp/flatpak-stub
	mv /tmp/flatpak-stub /usr/bin/firefox

# Flatpak firefox prefers wacky old fonts installed on Debian by default for some reason
uninstall-bad-x11-fonts:
	apt-get purge xfonts-75dpi xfonts-100dpi
