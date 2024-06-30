#!/bin/bash

main() {
    echo -e "Downloading Latest Roblox"
    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    curl "https://setup.rbxcdn.com/mac/version-ecb0dc61c2ff4160-RobloxPlayer.zip" -o "./RobloxPlayer.zip"

    echo -e "Installing Latest Roblox"
    [ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"
    unzip -o -q "./RobloxPlayer.zip"
    mv ./RobloxPlayer.app /Applications/Roblox.app
    rm ./RobloxPlayer.zip

    echo -e "Downloading macsploit"
    rm ./macsploit.dylib
    curl -LJO "https://github.com/tuanluong108/asdas/raw/preview/macsploit.dylib"

    rm ./insert_dylib
    echo -e "Downloading insert_dylib"
    curl -LJO "https://github.com/tuanluong108/asdas/raw/preview/insert_dylib"

    chmod +x "./insert_dylib"

    echo -e "Patching Roblox"
    mv ./macsploit.dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib"
    ./insert_dylib "/Applications/Roblox.app/Contents/MacOS/libHydrogen.dylib" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes
    mv "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer"

    chmod +x "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib"

    rm -rf /Applications/Roblox.app/Contents/MacOS/RobloxPlayerInstaller.app

    echo -e "Install Complete!"
}

main
