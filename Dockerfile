FROM	debian
RUN	apt-get update &&\
	apt-get dist-upgrade -y 
RUN	DEBIAN_FRONTEND=noninteractive \
	apt-get install \
		build-essential \
		ca-certificates \
                cmake \
                cron \
                davfs2 \
                fuse \
                liblzma-dev \
                liblzo2-dev \
                libprotobuf-dev \
                libssl-dev \
                protobuf-compiler \
                rsync \
                vim.tiny \
                wget \
                zlib1g-dev \
			-q -y --no-install-recommends

RUN	wget https://github.com/zbackup/zbackup/archive/1.4.4.tar.gz &&\
	tar xzvf 1.4.4.tar.gz &&\
	cd zbackup-1.4.4 &&\
	cmake . &&\
	make &&\
	make install

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
