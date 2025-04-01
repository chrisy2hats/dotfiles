flatpaks=(
  "com.discordapp.Discord"
  "com.github.paolostivanin.OTPClient"
  "com.github.tchx84.Flatseal"
  "com.google.Chrome"
  "com.heroicgameslauncher.hgl"
  "com.spotify.Client"
  "com.valvesoftware.Steam"
  "md.obsidian.Obsidian"
  "org.keepassxc.KeePassXC"
  "org.libreoffice.LibreOffice"
  "org.mozilla.firefox"
  "org.prismlauncher.PrismLauncher"
  "org.texstudio.TeXstudio"
  "org.videolan.VLC"
)

debug="$1"

function debug(){
	if [[ "$debug" == "-d" ]]
	then
		echo "$1"
	fi
}

function main(){
	for package in "${flatpaks[@]}"
	do
		echo "Install \"$package\"? [Y/n]"
		read resp
		if [[ "$resp" == "n" ]]
		then
			debug "Not installing $package"
			flatpaks=( ${flatpaks[@]/$package} )
		else
			debug "Will install $package"
		fi
	done

	if [[ -z ${flatpaks[@]} ]]
	then
		echo "No flatpaks to install"
		exit 1
	fi

	debug "Flatpaks to install \"${flatpaks[@]}\""

	for package in "${flatpaks[@]}"
	do
		debug "Installing $package"
		flatpak install flathub "$package" --assumeyes --user
	done
}

main
