install:
	@test -z '${SSH_PORT}' && { echo 'You need to provide the SSH port'; exit 1; } || true
	docker run -d --name devstep-envy \
		--restart="always" \
		-v /var/data/envy:/data \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-p 80:80 \
		-p ${SSH_PORT}:22 \
		-e HOST_DATA=/var/data/envy \
		fgrehm/devstep-envy

reinstall:
	@test -z '${SSH_PORT}' && { echo 'You need to provide the SSH port'; exit 1; } || true
	docker stop devstep-envy || true
	docker rm devstep-envy || true
	docker run -d --name devstep-envy \
		--restart="always" \
		-v /var/data/envy:/data \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-p 80:80 \
		-p ${SSH_PORT}:22 \
		-e HOST_DATA=/var/data/envy \
		fgrehm/devstep-envy

pristine:
	docker rm -fv $$(docker ps -qa -f 'label=envy') || true
	docker rmi $$(docker images -q -f 'label=envy') || true
	docker run --rm -v /var/data:/tmp/data \
		alpine \
		rm -rf /data/envy

build:
	docker build -t fgrehm/devstep-envy .

hack: build
	docker run --rm --name devstep-envy.dev \
		-v /tmp/data:/data \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-p 8000:80 \
		-p 2222:22 \
		-e HOST_DATA=/tmp/data \
		fgrehm/devstep-envy
