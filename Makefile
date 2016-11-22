############################### change if needed ###############################
CONTAINER=ark-csgo
VOLUME=/data/dockers/${CONTAINER}
IMAGE=fingerland/${CONTAINER}
PORT=27015
OPTIONS=-v '${VOLUME}:/cs-go' -p '${PORT}:${PORT}'
################################ computed data #################################
SERVICE_ENV_FILE=${PWD}/${CONTAINER}.env
SERVICE_FILE=${PWD}/${CONTAINER}.service
################################################################################

help:
	@echo "Fingerland CS:GO server (docker builder)"

build:
	@docker build -t ${IMAGE} .

volume:
	@sudo mkdir -p ${VOLUME}
	@sudo chown -R 1000:1000 ${VOLUME}

run: volume
	@docker run -ti ${OPTIONS} ${IMAGE}

systemd-service:
	@echo "CONTAINER=${CONTAINER}" > ${SERVICE_ENV_FILE}
	@echo "VOLUME=${VOLUME}" >> ${SERVICE_ENV_FILE}
	@echo "OPTIONS=${OPTIONS}" >> ${SERVICE_ENV_FILE}
	@cp service.sample ${SERVICE_FILE}
	@sed -i -e "s;EnvironmentFile=.*$$;EnvironmentFile=${SERVICE_ENV_FILE};" ${SERVICE_FILE}
	#@sudo systemctl enable ${SERVICE_FILE}

install: build volume systemd-service
	@sudo systemctl start ${CONTAINER}.service