#!/bin/bash

main() {
    echo -e "Downloading Latest Roblox..."
    local version=$(curl -s "https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer" | jq -r ".clientVersionUpload")

    if [ "$version" == "version-dd12d773fa2a4864" ]; then
        [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
        curl "http://setup.rbxcdn.com/mac/$version-RobloxPlayer.zip" -o "./RobloxPlayer.zip"

        if [ ! -f "./RobloxPlayer.zip" ]; then
            echo -e "Failed to download RobloxPlayer.zip."
            exit 1
        fi

        echo -n "Installing Latest Roblox... "
        [ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"
        unzip -o -q "./RobloxPlayer.zip"
        if [ ! -d "./RobloxPlayer.app" ]; then
            echo -e "Unzip failed or RobloxPlayer.app not found."
            exit 1
        fi
        mv ./RobloxPlayer.app /Applications/Roblox.app
        rm ./RobloxPlayer.zip
        echo -e "Done."

        echo -e "Downloading MacSploit"
        curl -O "https://raw.githubusercontent.com/Nexus42Dev/MacSploit/main/MacSploit.zip"

        if [ ! -f "./MacSploit.zip" ]; then
            echo -e "Failed to download MacSploit.zip."
            exit 1
        fi

        echo -e "Installing MacSploit"
        unzip -o -q "./MacSploit.zip"
        if [ ! -f "./macsploit.dylib" ] || [ ! -d "./MacSploit.app" ]; then
            echo -e "Unzip failed or required files not found."
            exit 1
        fi
        echo -e "Done."

        echo -e "Patching Roblox"
        mv ./macsploit.dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib"

        if [ ! -f "./insert_dylib" ]; then
            echo -e "insert_dylib not found."
            exit 1
        fi

        ./insert_dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes
        if [ ! -f "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" ]; then
            echo -e "Patching Roblox failed."
            exit 1
        fi
        mv "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer"
        rm ./insert_dylib

        echo -e "Installing MacSploit App"
        [ -d "/Applications/MacSploit.app" ] && rm -rf "/Applications/MacSploit.app"
        mv ./MacSploit.app /Applications/MacSploit.app
        rm ./MacSploit.zip
        echo -e "Done."

        echo -e "Install Complete! Developed by mlo!"
        exit
    else
        echo -e "The version does not match."
        exit 1
    fi
}

main
