FROM fgrehm/devstep:v0.4.0

# Speed things up by having the Docker binary around
RUN sudo bash -c 'curl -sL https://get.docker.com/builds/Linux/x86_64/docker-latest > /usr/bin/docker' \
    && sudo chmod +x /usr/bin/docker \
    && echo '#!/bin/bash' > $DEVSTEP_CONF/init.d/01-fix-docker-socket-permission.sh \
    && echo 'if [[ -S /env/run/docker.sock ]]; then' >> $DEVSTEP_CONF/init.d/01-fix-docker-socket-permission.sh \
    && echo '  sudo chown developer: /env/run/docker.sock' >> $DEVSTEP_CONF/init.d/01-fix-docker-socket-permission.sh \
    && echo 'fi' >> $DEVSTEP_CONF/init.d/01-fix-docker-socket-permission.sh \
    && chmod +x $DEVSTEP_CONF/init.d/01-fix-docker-socket-permission.sh \
    && echo 'alias commit="exec sudo -E \\commit"' >> $HOME/.profile.d/docker-aliases.sh \
    && echo 'alias rebuild="exec sudo -E \\rebuild"' >> $HOME/.profile.d/docker-aliases.sh \
    && echo 'source /envy/envyrc' >> $HOME/.bashrc

# Always clean up after ourselves
ENV CLEANUP=1

# Make it easy to cleanup environments
ONBUILD LABEL devstep-envy=true
ONBUILD COPY . /env/code
ONBUILD WORKDIR /env/code
ONBUILD RUN /opt/devstep/bin/build-project /env/code
