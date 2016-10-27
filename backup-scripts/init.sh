cd /backup-scripts
mount /mnt/davfs &&\
if [ -e /mnt/davfs/backup-repo ]
then
	echo -e "\033[1m\033[31mSKIPPING BACKUP REPOSITORY INITIALIZATION\033[0m\n"
else
	zbackup init --password-file /root/passwd /mnt/davfs/backup-repo/
fi
umount /mnt/davfs
