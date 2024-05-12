FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements/bonus/vsftpd/tools/ftp_setup.sh /usr/local/bin

WORKDIR /var/www

EXPOSE 21

CMD ["bash", "/usr/local/bin/ftp_setup.sh"]
