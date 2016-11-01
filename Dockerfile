FROM	debian

#	Install and update packages
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

#	Setup Webdav mount
COPY	./davfshost /tmp/davfshost
RUN	DAV=`cat /tmp/davfshost |  awk {'print $1'} `; echo "$DAV /mnt/davfs davfs noauto,user,rw 0 0" >> /etc/fstab
RUN	mkdir /mnt/davfs

#	Setup location for backup scripts and copy them
RUN	mkdir /backup-scripts
COPY	backup-scripts/* /backup-scripts/
RUN	chmod 700 /backup-scripts/*.sh

#	Setup CRON
RUN	rm /etc/cron.daily/* &&\
	ln -s /backup-scripts/backup.sh /etc/cron.daily/

#	Mounts
VOLUME	["/mnt/local", "/confidential"]

#	When container starts, run entrypoint.sh
CMD	/backup-scripts/entrypoint.sh
