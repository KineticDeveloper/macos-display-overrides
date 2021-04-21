#!/bin/bash
#
# Install overrides for displays
# run script using 'sudo'

set -euo pipefail

override_dir="/Library/Displays/Contents/Resources/Overrides"
mkdir -p "$override_dir"

for id in DisplayVendorID-*; do
	mkdir -p "$override_dir/$id"

	for pl in "$id"/*.plist; do
		echo "${pl%.plist}"
		target="$override_dir/${pl%.plist}"
		cp "$pl" "$target"
		chown root:wheel "$target"
		chmod 0664 "$target"
	done
done

print "Enabling DisplayResolution in /Library/Preferences/com.apple.windowserver..."
defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool YES
defaults delete /Library/Preferences/com.apple.windowserver DisplayResolutionDisabled >/dev/null 2>&1
