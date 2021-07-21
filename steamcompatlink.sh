#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo "usage: ./steamcompatlink.sh [destination]"
    echo "example: ./steamcompatlink.sh ~/MySteamLinks"
    echo "The destination folder will be filled with symlinks to your compatdata folders"
    exit 1
fi

if [ -f "$1" ]; then 
    echo "Provided argument is not a directory"
    exit 1
fi

readarray -t steamdirs < <(cat ~/.steam/steam/steamapps/libraryfolders.vdf | grep "/" | awk '{ print $2  }' | sed s/\"//g)


#these two are exactly the same for most, but eh, can't hurt to check both

if [ -d "$HOME/.steam/steam" ]; then 
    steamdirs+=("$HOME/.steam/steam")
fi

if [ -d "$HOME/.local/share/Steam/" ]; then 
    steamdirs+=("$HOME/.local/share/Steam")
fi

for dir in "${steamdirs[@]}"
do
  readarray -t appmanifests < <(ls "${dir}/steamapps/appmanifest"*.acf)

    for appfile in "${appmanifests[@]}"
    do
        appid=$(cat ${appfile} | grep \"appid\" | awk '{ print $2 }' | sed s/\"//g)
        appname=$(cat ${appfile} | grep installdir | awk '{ print $2, $3, $4, $5, $6, $7, $8, $9, $10 }' | sed s/\"//g | sed 's/ *$//g')
        #echo "${appid} :: ${appname}"
        compatdir="${dir}/steamapps/compatdata/${appid}/pfx/drive_c/users/steamuser/"

        if [ -d "${compatdir}" ] 
        then
            echo "${compatdir}"
            ln -sfn "${compatdir}" "$1/${appname}"
        fi
    done
done


