FROM	debian
RUN	apt-get update &&\
	apt-get dist-upgrade -y 
RUN	DEBIAN_FRONTEND=noninteractive \
	apt-get install \
		ca-certificates \
                cron \
                davfs2 \
		duplicity \
                fuse \
                protobuf-compiler \
                rsync \
                vim.tiny \
                wget \
			-q -y --no-install-recommends


COPY	secrets /etc/davfs2/secrets
RUN	chmod 0600 /etc/davfs2/secrets
RUN	DAV=`cat /etc/davfs2/secrets |  awk {'print $1'} `; echo "$DAV /mnt/davfs davfs noauto,user,rw 0 0" >> /etc/fstab
RUN	mkdir /mnt/davfs && mkdir /backup-scripts

COPY	backup-scripts/* /backup-scripts/
RUN	chmod 700 /backup-scripts/*.sh
COPY	passwd /root/passwd

RUN	rm /etc/cron.daily/* &&\
	ln -s /backup-scripts/backup.sh /etc/cron.daily/


VOLUME	/mnt/local

CMD	/backup-scripts/entrypoint.sh
