IMAGES = images/*

install:
	@test -z '${SSH_PORT}' && { echo 'You need to provide the SSH port'; exit 1; } || true
	./installer.sh ${SSH_PORT}

reinstall:
	@test -z '${SSH_PORT}' && { echo 'You need to provide the SSH port'; exit 1; } || true
	docker stop devstep-envy || true
	docker rm devstep-envy || true
	./installer.sh ${SSH_PORT}

pristine:
	docker rm -fv $$(docker ps -qa -f 'label=devstep-envy') || true
	docker rmi $$(docker images -q -f 'label=devstep-envy') || true
	docker run --rm -v /mnt/devstep-envy:/tmp/data \
		alpine \
		sh -c 'rm -rf /tmp/data/* && rm -f /tmp/data/.envcmd'

build:
	docker build -t fgrehm/devstep-envy .

hack: build
	docker run --rm --name devstep-envy.dev \
		-v /tmp/devstep-envy:/envy \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-p 8000:80 \
		-p 2222:22 \
		-e HOST_ROOT=/tmp/devstep-envy \
		fgrehm/devstep-envy

images: $(IMAGES)
	for dir in $(IMAGES); do ${MAKE} build -C $$dir; exit_status=$$?; \
	if [ $$exit_status -ne 0 ]; then exit $$exit_status; fi; done
