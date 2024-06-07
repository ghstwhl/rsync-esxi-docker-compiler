FROM centos:centos7

# Set the version of rsync you want to install.
ARG RSYNC_VERSION=v3.3.0


RUN yum -y install epel-release
RUN yum check-update ; yum update -y
RUN yum install -y automake \
  doxygen \
  gcc \
  git \
  glibc-static \
  libzstd \
  libzstd-devel \
  libzstd-static \
  lz4-devel \
  lz4-static \
  make \
  openssl-static \
  popt-devel \
  popt-static \
  python3-devel \
  python3-pip \
  rpm-build \
  wget \
  xxhash-devel

RUN yum install -y libffi libffi-devel


RUN pip3 install cmarkgfm

RUN cd /root/ && wget https://dl.fedoraproject.org/pub/epel/7/SRPMS/Packages/x/xxhash-0.8.2-1.el7.src.rpm && rpm -ivh xxhash-*.el7.src.rpm
RUN cd ~/rpmbuild/SPECS && \
  rpmbuild -bp xxhash.spec && \
  cd ~/rpmbuild/BUILD/xxHash-*/ &&\
  make install
# 
#  

RUN cd /root && \
  git clone https://github.com/RsyncProject/rsync.git && \
  cd rsync && \
  git checkout $RSYNC_VERSION

  
WORKDIR /root/rsync
RUN LIBS="-ldl" ./configure && \
  make -B CFLAGS="-static" 
