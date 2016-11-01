docker run -ti --device /dev/fuse --cap-add SYS_ADMIN -v /mnt/backup:/mnt/local -v `pwd`/confidential:/confidential $1
