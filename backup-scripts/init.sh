cd /backup-scripts
mount /mnt/davfs &&\
if [ -e /mnt/davfs/backup-dup ]
then
	echo -e "\033[1m\033[31mSKIPPING BACKUP REPOSITORY INITIALIZATION\033[0m\n"
else
	mkdir /mnt/davfs/backup-dup
fi
umount /mnt/davfs
