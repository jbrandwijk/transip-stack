mount /mnt/davfs
cd /mnt
rsync -r local davfs
umount /mnt/davfs
