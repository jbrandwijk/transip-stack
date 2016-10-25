FROM	debian
RUN	apt-get update &&\
	apt-get dist-upgrade -y 
RUN	apt-get install ca-certificates \ 
			davfs2 \
			fuse \
			rsync \
			vim.tiny \
			 -y --no-install-recommends

COPY	secrets /etc/davfs2/secrets
RUN	chmod 0600 /etc/davfs2/secrets
RUN	DAV=`cat /etc/davfs2/secrets |  awk {'print $1'} `; echo "$DAV /mnt/davfs davfs noauto,user,rw 0 0" >> /etc/fstab
RUN	mkdir /mnt/davfs && mkdir /docker
COPY	docker/sync.sh /docker/sync.sh
RUN	chmod 700 /docker/sync.sh

VOLUME	/mnt/local

CMD	/docker/sync.sh
