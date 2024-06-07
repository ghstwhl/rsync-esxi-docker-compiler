# rsync-esxi-compiler
This project is a fork of (gbenguria's)[https://github.com/gbenguria/rsync-esxi-docker-compiler] project, which was was created compile a statically linked version of rsync suitable for use on VMWare ESXi systems.  The purpose of this fork is to bring some of the components up to date.

I have verfied that the version of `rsync` compiled by this container works with ESXi 6.7 and ESXi 7.0 Update 3

## prerequsites

* operating system that support linux x86_64 docker containers i.e. ubuntu 20
* docker 
* bash
* ssh
* scp
* rsync

## usage
In order to generate the statically compiled rsync for esxi 7.0, use one of the below methods.  Both methods will place a copy of the statically linked `rsync` binary on our local machine.  You can then copy this `rsync` binary to the remote ESXi system, most likely into the /bin/ directory.  Be suure to chmod +x /bin/rsync on the remote ESXi system.

If you copy `rsync` into a directory that is not in the default PATH on ESXi, you will need to use the `--rsync-path` parameter when using `rsync` to transfer files *to* the ESXi system.  For example, if I place the `rsync` binary into `/vmfs/volumes/datastore1/tools/bin/` I have to use this parameter when invoking `rsync` *from* a remote system:  `--rsync-path=/vmfs/volumes/datastore1/tools/bin/rsync`


### Use the github built container:
```
docker pull ghcr.io/ghstwhl/rsync-esxi-docker-compiler:master
docker run -v ${PWD}:/tmp/pwd -d ghcr.io/ghstwhl/rsync-esxi-docker-compiler:master /bin/bash -c "cp /root/rsync/rsync /tmp/pwd"
```

### Build your own copy of the container from this repo:
```
git clone https://github.com/ghstwhl/rsync-esxi-docker-compiler.git
cd rsync-esxi-docker-compiler
docker build . -t rsync-esxi-compiler
docker run -v ${PWD}:/tmp/pwd -d rsync-esxi-compiler /bin/bash -c "cp /root/rsync/rsync /tmp/pwd"
```
