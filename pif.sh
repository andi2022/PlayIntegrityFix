#!/bin/bash

# Read the local update.json file and extract values using jq
local_version=$(jq -r '.version' update.json)
local_versioncode=$(jq -r '.versionCode' update.json)
local_zip_url=$(jq -r '.zipUrl' update.json)


# Fetch the remote update.json file and extract values using jq
remote_json=$(curl -s https://raw.githubusercontent.com/chiteroman/PlayIntegrityFix/main/update.json)
remote_version=$(echo "$remote_json" | jq -r '.version')
remote_versioncode=$(echo "$remote_json" | jq -r '.versionCode')
remote_zip_url=$(echo "$remote_json" | jq -r '.zipUrl')

# Compare versions and assign to new variables if the remote version is newer
if [ "$remote_version" \> "$local_version" ]; then
    wget -O pif.zip "$remote_zip_url"
    unzip -d pif pif.zip
    sed -i 's/^resetprop_if_diff ro.adb.secure 1$/resetprop_if_diff ro.adb.secure 0/' pif/post-fs-data.sh
    sed -i "s|https://raw.githubusercontent.com/chiteroman/PlayIntegrityFix/main/update.json|https://raw.githubusercontent.com/andi2022/PlayIntegrityFix/main/update.json|g" "pif/module.prop"
    cd pif/
    zip -r ../PlayIntegrityFix_$remote_version.zip *
    cd ..
    rm -r pif/
    rm pif.zip
    jq '.version = "'$remote_version'"' update.json > tmp.$$.json && mv tmp.$$.json update.json
    jq '.versionCode = "'$remote_versioncode'"' update.json > tmp.$$.json && mv tmp.$$.json update.json
else
    exit 1
fi