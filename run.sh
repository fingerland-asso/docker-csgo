#!/usr/bin/env bash

function install-steamcmd {
    echo "steamcmd not found. Installing..."
    mkdir -p "${INSTALL_DIR}/steamcmd"
    cd "${INSTALL_DIR}/steamcmd"
    curl -Ss http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -xz
}

function install-csgo {
    echo "No game files found. Installing..."
    "${INSTALL_DIR}/steamcmd/steamcmd.sh" +login anonymous +force_install_dir "${INSTALL_DIR}/server" +app_update 740 +quit
}

function fix-volume {
    [ ! -d "${INSTALL_DIR}/config" ] && mkdir -p "${INSTALL_DIR}/config"
    [ ! -f "${INSTALL_DIR}/config/motd.txt" ] && cp "/home/steam/samples/motd.txt" "${INSTALL_DIR}/config/motd.txt"
    [ ! -f "${INSTALL_DIR}/config/autoexec.cfg" ] && cp "/home/steam/samples/autoexec.cfg" "${INSTALL_DIR}/config/autoexec.cfg"
}

##################################### Main #####################################
# we check if steamcmd is installed
[ ! -f "${INSTALL_DIR}/steamcmd" ] && install-steamcmd

# we check if csgo is installed or need an update
install-csgo

# we fix volume if needed
fix-volume

cd "${INSTALL_DIR}/server"
./srcds_run -game csgo -console -usercon +game_type $GAME_TYPE +game_mode $GAME_MODE +mapgroup $MAPGROUP +map $MAP $STARTUP_OPTIONS