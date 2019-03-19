# Firefly development environment based on Ubuntu 16.04 LTS.

# Start with Ubuntu 16.04 LTS.
FROM ubuntu:16.04

MAINTAINER tchip <teefirefly@gmail.com>

# Required dependencies
ENV KERNEL_BUILDDEPS="git-core gnupg flex bison gperf build-essential zip curl \
        zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev \
        x11proto-core-dev libx11-dev lib32z1-dev ccache libgl1-mesa-dev \
        libxml2-utils xsltproc unzip device-tree-compiler" \
    BUILDROOT_BUILDDEPS="libfile-which-perl sed make binutils gcc g++ bash \
        patch gzip bzip2 perl tar cpio python unzip rsync file bc libmpc3 \
        git repo texinfo pkg-config cmake tree" \
    TOOLS="genext2fs time wget liblz4-tool" \
    PROJECT="/home/project"

# Update repository of Alibaba
# COPY sources.list /etc/apt/sources.list

# ENTRYPOINT
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Default workdir
WORKDIR $PROJECT

# Update package lists
RUN apt-get update \
    && apt-get upgrade -y \
# Install gosu
    && apt-get -y install curl \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
# Install dependencies
    && apt-get install -y $KERNEL_BUILDDEPS \
    && apt-get install -y $BUILDROOT_BUILDDEPS \
    && apt-get install -y $TOOLS \
# Clean
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
# Change the access permissions of entrypoint.sh
    && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD [ "/bin/bash" ]
