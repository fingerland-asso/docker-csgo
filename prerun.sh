#!/usr/bin/env bash

echo "Updating config"
sed -i  -e "s;gametype=.*$;gametype=\"${GAMETYPE}\";" \
        -e "s;gamemode=.*$;gamemode=\"${GAMEMODE}\";" \
        -e "s;defaultmap=.*$;defaultmap=\"${DEFAULTMAP}\";" \
        -e "s;mapgroup=.*$;mapgroup=\"${MAPGROUP}\";" \
        -e "s;maxplayers=.*$;maxplayers=\"${MAXPLAYERS}\";" \
        -e "s;tickrate=.*$;tickrate=\"${TICKRATE}\";" \
        -e "s;port=.*$;port=\"${PORT}\";" \
        -e "s;sourcetvport=.*$;sourcetvport=\"${SOURCETVPORT}\";" "${INSTALL_DIR}/${SERVER}"
