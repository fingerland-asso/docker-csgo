############################### change if needed ###############################
CONTAINER=csgoserver
VOLUME=/data/dockers/${CONTAINER}
IMAGE=fingerland/${CONTAINER}
PORT=27016
TVPORT=27005
OPTIONS=-e TICKRATE=128 -e PORT=${PORT} -e SOURCETVPORT=${TVPORT}  -v ${VOLUME}:/server -p ${PORT}:${PORT} -p ${PORT}:${PORT}/udp -p ${TVPORT}:${TVPORT}
################################ computed data #################################
SERVICE_ENV_FILE=${PWD}/${CONTAINER}.env
SERVICE_FILE=${PWD}/${CONTAINER}.service
################################################################################

help:
	@echo "Fingerland CS:GO server (docker builder)"

build:
	@docker build -t ${IMAGE} .

volume:
	@mkdir -p ${VOLUME}
	@chown -R 1000:1000 ${VOLUME}

run: volume
	@docker kill ${CONTAINER} || echo ""
	@docker rm ${CONTAINER} || echo ""
	@docker run --restart=always -d -ti ${OPTIONS} --name=${CONTAINER} ${IMAGE}

systemd-service:
	@cp service.sample ${SERVICE_FILE}
	@sed -i -e "s;ExecStartPre=-/usr/bin/docker pull.*$$;ExecStartPre=-/usr/bin/docker pull ${IMAGE};"  ${SERVICE_FILE}
	@sed -i -e "s;ExecStartPre=-/usr/bin/docker rm.*$$;ExecStartPre=-/usr/bin/docker rm ${CONTAINER};"  ${SERVICE_FILE}
	@sed -i -e "s;ExecStartPre=-/usr/bin/docker kill.*$$;ExecStartPre=-/usr/bin/docker kill ${CONTAINER};"  ${SERVICE_FILE}
	@sed -i -e "s;ExecStart=.*$$;ExecStart=/usr/bin/docker run -i --name=${CONTAINER} ${OPTIONS} ${IMAGE};"  ${SERVICE_FILE}
	@sed -i -e "s;ExecStop=.*$$;ExecStop=/usr/bin/docker stop ${CONTAINER};"  ${SERVICE_FILE}
	@systemctl enable ${SERVICE_FILE}
	@systemctl daemon-reload

install: build volume systemd-service
	@sudo systemctl start ${CONTAINER}.service
