cd /backup-scripts

if [ ! -f /var/lock/zbackup ]
then

touch /var/lock/zbackup
./mount-idempotent.sh
cd /mnt
tar -c local | zbackup backup --password-file ~/passwd /mnt/davfs/backup-repo/backups/backup-`date '+%Y-%m-%d-%H-%M-%S'`
umount /mnt/davfs
rm /var/lock/zbackup

fi
