flatpaks=( "org.mozilla.firefox" "com.github.paolostivanin.OTPClient")

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
			debug "Not installed $package"
			flatpaks=( "${flatpaks[@]/$package}" )
		else
			debug "Will install $package"
		fi
	done

	if [[ -z ${flatpaks[@]} ]]
	then
		echo "No flatpaks to install"
		exit 1
	fi

	debug "Flatpaks to install ${flatpaks[@]}"

	for package in "${flatpaks[@]}"
	do
		debug "Installing $package"
		flatpak install flathub "$package" --assumeyes --user
	done
}

main
