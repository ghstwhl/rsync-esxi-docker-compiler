# rsync-esxi-compiler
This project is a fork of (gbenguria's)[https://github.com/gbenguria/rsync-esxi-docker-compiler] project, which was was created compile a statically linked version of rsync suitable for use on VMWare ESXi systems.  The purpose of this fork is to bring some of the components up to date.

I have verfied that the version of `rsync` compiled by this container works with ESXi 7.0 Update 3

## prerequsites

* operating system that support linux x86_64 docker containers i.e. ubuntu 20
* docker 
* bash
* ssh
* scp
* rsync

## usage
in order to generate the statically compiled rsync for esxi 7.0 do the following:

```bash
cd this_repo
echo to create the image that compiles rsync statically
docker build . -t rsync-esxi-compiler

echo To copy the compiled rsync binary to the current directory:
docker run -v ${PWD}:/tmp/pwd -d --name rsync-esxi-compiler rsync-esxi-compiler /bin/bash -c "cp /root/rsync/rsync /tmp/pwd"

echo You can now copy rsync to the remote ESXi system, to the /bin/ directory.
echo Be suure to chmod +x /bin/rsync on the remote ESXi system.
```