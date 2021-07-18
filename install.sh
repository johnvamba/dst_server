#!/bin/bash

steamcmd_dir="$HOME/steamcmd"
install_dir="$HOME/dstds"
cluster_name="ClusterServer"
dontstarve_dir="$HOME/.klei/DoNotStarveTogether"

# Check for game updates before each start. If the game client updates and your server is out of date, you won't be
# able to see it on the server list. If that happens just restart the containers and you should get the latest version
/home/steam/steamcmd.sh +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +force_install_dir "$install_dir" +app_update 343050 validate +quit

# Copy dedicated_server_mods_setup.lua
ds_mods_setup="$dontstarve_dir/scripts/dedicated_server_mods_setup.lua"
if [ -f "$ds_mods_setup" ]
then
  cp $ds_mods_setup "$install_dir/mods/"
fi

# Copy modoverrides.lua
modoverrides="$dontstarve_dir/$cluster_name/scripts/modoverrides.lua"
if [ -f "$modoverrides" ]
then
  cp $modoverrides "$dontstarve_dir/$cluster_name/Master/"
  cp $modoverrides "$dontstarve_dir/$cluster_name/Caves/"
fi
