# SteamCompatLink

A simple script for Steam on Linux that will create symlinks to all your compatdata/<appid>/pfx/drivec/users/steamuser folders to a central folder with the names of the apps instead of IDs.

## Usage:

./steamcompatlink.sh /home/user/outputDir/etc

Be careful with where you output to, since it may potentially create a lot of symlinks.

## To do / issues:
  - The script does not do any housekeeping. If you uninstall a game, the symlink will remain until you delete it.
  - I have not done much work to ensure it works well with directory names that have spaces in them
  - My bash skills are not great, so I defs need to clean up some of the more goofy parts of the code
  
