# Docker to send files from local dir to Transip Stack

## To run

You need:
* An activated account at Transip Stack
* This docker container (and all prequisites to run it ;) )

You do:
* Clone this repo
* Create a file `secrets` containing:
    
```
https://<your_stack_url> <your_stack_username> <your_stack_password>
```

* Issue `docker build -t transip-stack .`



To run:
* `. run_docker.sh transip-stack`


Unfortunately, in order to be able to mount a volume in user space in docker, SYS_ADMIN capabilities need to be added to the container. This is part of the run_docker shell script. This shell script is there for convenience reasons only, feel free to change paths etc. ;)

_Please note this is all work in progress..._
