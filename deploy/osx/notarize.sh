#!/bin/bash

## The following assumes we have generated an app password at
## appleid.apple.com and then stored it to keychain id "altool" using
## e.g.
## security add-generic-password -a "cannam+apple@all-day-breakfast.com" \
##   -w "generated-app-password" -s "altool"

## NB to verify:
# spctl -a -v "/Applications/Application.app"

user="appstore@particularprograms.co.uk"
bundleid="org.sonicvisualiser.VampPluginPackInstaller"

set -e

target="$1"

if [ ! -f "$target" ] || [ -n "$2" ]; then
    echo "Usage: $0 <target>"
    echo "  e.g. $0 MyApplication-1.0.target"
    exit 2
fi

set -u

echo
echo "Uploading for notarization..."

uuidfile=.notarization-uuid
statfile=.notarization-status
rm -f "$uuidfile" "$statfile"

xcrun altool --notarize-app \
    -f "$target" \
    --primary-bundle-id "$bundleid" \
    -u "$user" \
    -p @keychain:altool 2>&1 | tee "$uuidfile"

uuid=$(cat "$uuidfile" | grep RequestUUID | awk '{ print $3; }')

if [ -z "$uuid" ]; then
    echo
    echo "Failed (no UUID returned, check output)"
    exit 1
fi

echo "Done, UUID is $uuid"

echo
echo "Waiting and checking for completion..."

while true ; do
    sleep 30

    xcrun altool --notarization-info \
	"$uuid" \
	-u "$user" \
	-p @keychain:altool 2>&1 | tee "$statfile"

    if grep -q 'Package Approved' "$statfile"; then
	echo
	echo "Approved! Status output is:"
	cat "$statfile"
	break
    elif grep -q 'in progress' "$statfile" ; then
	echo
	echo "Still in progress... Status output is:"
	cat "$statfile"
	echo "Waiting..."
    else 
	echo
	echo "Failure or unknown status in output:"
	cat "$statfile"
	exit 2
    fi
done

echo
echo "Done, don't forget to staple the target or its contents"
echo "(e.g. xcrun stapler staple '$target')"
exit 0

