#!/bin/sh

linksdir="$HOME/Documents/SteamLinks"

mkdir -p $linksdir

readarray -t steamdirs < <(cat ~/.steam/steam/steamapps/libraryfolders.vdf | grep "/" | awk '{ print $2  }' | sed s/\"//g)
steamdirs=("${steamdirs[@]}" "$HOME/.steam/steam")

for dir in "${steamdirs[@]}"
do
  readarray -t appmanifests < <(ls "${dir}/steamapps/appmanifest"*.acf)

    for appfile in "${appmanifests[@]}"
    do
        appid=$(cat ${appfile} | grep \"appid\" | awk '{ print $2 }' | sed s/\"//g)
        appname=$(cat ${appfile} | grep installdir | awk '{ print $2, $3, $4, $5, $6, $7, $8, $9, $10 }' | sed s/\"//g | sed 's/ *$//g')
        compatdir="${dir}/steamapps/compatdata/${appid}/pfx/drive_c/users/steamuser/"
        userid=$(ls -at $HOME/.steam/steam/userdata | tail -n +2 | head -n 1)
        screenshotdir="$HOME/.steam/steam/userdata/${userid}/760/remote/${appid}/screenshots"

        mkdir -p "${linksdir}/${appname}"

        if [ -d "${compatdir}" ] 
        then
            ln -sfn "${compatdir}" "${linksdir}/${appname}/UserFiles"
        fi

        if [ -d "${screenshotdir}" ] 
        then
            ln -sfn "${screenshotdir}" "${linksdir}/${appname}/Screenshots"
        fi

    done
done

