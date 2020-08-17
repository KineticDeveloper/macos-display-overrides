#!/bin/bash
set -euo pipefail

# Install overrides for displays (from recovery due to SIP).
#
# Installation steps:
#   1. Boot into recovery (Cmd+R)
#   2. Mount drive (Macintosh HD)
#   3. Run this script

override_dir="/Volumes/Macintosh HD/System/Library/Displays/Contents/Resources/Overrides"

for id in DisplayVendorID-*; do
	mkdir -p "$override_dir/$id"
	for pl in $id/*.plist; do
		echo "${pl%.plist}"
		target="$override_dir/${pl%.plist}"
		cat "$pl" > "$target"
		chown root:wheel "$target"
		chmod 0664 "$target"
	done
done
