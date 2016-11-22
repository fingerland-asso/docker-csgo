FROM ubuntu
MAINTAINER Caderrik <caderrik@gmail.com>

################################################################################
## app infos
ENV INSTALL_DIR=/cs-go GAME_TYPE= GAME_MODE= MAPGROUP= MAP= STARTUP_OPTIONS= PORT=27015

VOLUME "${INSTALL_DIR}"
EXPOSE ${PORT}

################################################################################
## app deps
RUN set -x && \
    apt-get update -qq && \
    apt-get install -qq curl lib32gcc1

################################################################################
## cleaning as root
RUN apt-get clean autoclean purge && \
    rm -fr /tmp/*

RUN useradd -r -m -u 1000 steam

################################################################################
## volume
RUN mkdir -p "${INSTALL_DIR}" && \
    chown steam -R "${INSTALL_DIR}" && \
    chmod 755 -R "${INSTALL_DIR}"

################################################################################
## app config
COPY motd.txt /home/steam/samples/motd.txt
COPY autoexec.cfg /home/steam/samples/autoexec.cfg
COPY run.sh /usr/local/bin/run-csgo

################################################################################
## app run
USER steam
CMD ["/usr/local/bin/run-csgo"]