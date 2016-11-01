# Docker transip-stack

The goal of this container is to periodically send an encrypted backup to Transip Stack. Transip Stack is a commercial storage product of [TransIP](http://www.transip.nl).

Current container does store the backup at Stack encrypted and performs a daily incremental update of this backup, using [Duplicity](http://duplicity.nongnu.org/).

## Quickstart
In order to get this up and running, a couple of actions need to be done:

***Check out***

Check out this repository with your favourite GIT client.

*** Set up Slack ***

Locate the file `davfshost` and replace the contents of the file with the WebDav URL of *your* stack. This is typically something like `http://<username>.stackstorage.com/webdav.php/remote`.

Next, locate the file `confidential/secrets`. This file contains one line in following format:
```
<url> <username> <password>
```

so this needs to be filled in with your data.

*** Set up passphrase ***

This passphrase is being used to encrypt (or decrypt) your backups. Place your passphrase in `confidential/passwd`.

*** Build your container ***

Build the container conform the Doc ker documentation. This is typically something like `docker build -t transip-stack .`

*** Run your contanier ***

That's unfortunately less simple than usual, since the container mounts the remote davFs-volume in order to get your backup at your Stack. To keep things simple these have been put into a single script. So just run: `. run_docker.sh <container-name>`

## Manual work

In the typical setup, the container fires up cron in order to send a backup every 24 hours. In order to prevent multiple instances being fired (if it takes more than 24 hrs to get one backup transferred) it places a lock-file in `/var/lock/zbackup`. If the process crashes for some reasons, please remove this file manually.

All scripts being executed (automatically) by this container are located in `/backup-scripts`. Here you'll find:

| Filename      | Are           |
| ------------- |:-------------:|
| backup.sh     | Used to create a new or incremental backup |
| entrypoint.sh      | Script fired as entrypoint for the container      |
| mount-idempotent.sh | Script to mount the remote DavFs, idempotentally. |
| init.sh | Script to intiate a new backup set       |


Witin the container you can initiate the `duplicity` command in order to perform complexer operations on your backup set or to restore. Please see [Duplicity documentation](http://duplicity.nongnu.org/) for more information.

_Please note this is all work in progress..._

