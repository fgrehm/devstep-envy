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
