FROM debian:bullseye

RUN apt update && apt install -y curl apache2-utils \
	&& apt install -y apt-transport-https ca-certificates \
	&& apt clean && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/portainer/portainer/releases/download/2.19.5/portainer-2.19.5-linux-amd64.tar.gz -o portainer.tar.gz && \
    tar -xzvf portainer.tar.gz && \
    rm portainer.tar.gz

COPY requirements/bonus/portainer/tools/setup_run.sh /

CMD ["bash", "setup_run.sh"]
