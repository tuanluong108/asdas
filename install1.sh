#!/bin/bash

main() {
    echo -e "Downloading Latest Roblox..."
    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    # https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer
    curl "http://setup.rbxcdn.com/mac/version-ecb0dc61c2ff4160-RobloxPlayer.zip" -o "./RobloxPlayer.zip"
    rm ./jq

    echo -n "Installing Latest Roblox... "
    [ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"
    unzip -o -q "./RobloxPlayer.zip"
    mv ./RobloxPlayer.app /Applications/Roblox.app
    rm ./RobloxPlayer.zip
    echo -e "Done."

    echo -e "Downloading MacSploit..."
    curl "https://download1979.mediafire.com/0tcaessofglg73TAfsDXZK16xE1CwrBKnFonedgRHJXxQbBWk2aEtpDQnkA1Eo4ok5qtzrE-6DXSgeDy1xE4c9hXWyaHMPI7XXmV-xkz4OamCHG7RA_u4LwkcSXJ9G5f294LyPUbKghn1qWORhc32rfM_kWdzHsxOTkjCJBvE_hf9Q/jp9mj3lgr5rl1pi/macsploit.zip" -o "./macsploit.zip"

    echo -n "Installing MacSploit... "
    unzip -o -q "./macsploit.zip"
    echo -e "Done."

    echo -n "Updating Dylib..."
    curl -Os "https://github.com/tuanluong108/asdas/raw/preview/macsploit.dylib"

    echo -e " Done."
    echo -e "Patching Roblox..."
    mv ./macsploit.dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib"
    # mv ./libNoUpdate.dylib "/Applications/Roblox.app/Contents/MacOS/libUpdateDisabler.dylib"
    mv ./libdiscord-rpc.dylib "/Applications/Roblox.app/Contents/MacOS/libdiscord-rpc.dylib"
    ./insert_dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes
    # echo -e " !!! PRESS n !!! "
    # ./insert_dylib "/Applications/Roblox.app/Contents/MacOS/libUpdateDisabler.dylib" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig 
    mv "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer"
    rm -r "/Applications/Roblox.app/Contents/MacOS/RobloxPlayerInstaller.app"
    rm ./insert_dylib

    echo -n "Installing MacSploit App... "
    [ -d "/Applications/MacSploit.app" ] && rm -rf "/Applications/MacSploit.app"
    mv ./MacSploit.app /Applications/MacSploit.app
    rm ./MacSploit.zip
    echo -e "Done."
    echo -e "Install Complete! Developed by Nexus42 (norb was here)!"
    exit
}

main
