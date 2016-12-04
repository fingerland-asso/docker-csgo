FROM fingerland/lgsm
MAINTAINER Caderrik <caderrik@gmail.com>

ENV GAMETYPE=0 GAMEMODE=0 DEFAULTMAP=de_dust2 MAPGROUP=random_classic MAXPLAYERS=16 TICKRATE=128 PORT=27016 SOURCETVPORT=27005 SERVER=csgoserver
EXPOSE "${PORT}" "${PORT}/udp" "${SOURCETVPORT}"

COPY prerun.sh /usr/local/bin/prerun-server
