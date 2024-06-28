Bash script to allow Firefox in a flatpak to be set as default browser

## Usage
Edit the flatpak-stub to have the correct profile path

Move stub to /usr/bin/firefox

``update-alternatives --config x-www-browser`` to point use Firefox by default

