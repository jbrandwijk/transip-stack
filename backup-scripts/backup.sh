cd /backup-scripts

if [ ! -f /var/lock/zbackup ]
then

touch /var/lock/zbackup
./mount-idempotent.sh
cd /mnt
PASSPHRASE=`cat /root/passwd` \
duplicity local file:///mnt/davfs/backup-dup
umount /mnt/davfs
rm /var/lock/zbackup

fi
