rm /etc/davfs2/secrets && ln -s /confidential/secrets /etc/davfs2/secrets
ln -s /confidential/passwd /root/passwd
chmod 0600 /etc/davfs2/secrets
/etc/init.d/cron start
/bin/bash
