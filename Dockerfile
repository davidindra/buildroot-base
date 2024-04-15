FROM debian:12

WORKDIR /root

# Install dependencies.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive\
    apt-get install -y build-essential libncurses5-dev rsync cpio python3 python-is-python3 unzip bc wget file htop nano && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

# Install Buildroot.
RUN wget -nv https://buildroot.org/downloads/buildroot-2024.02.1.tar.gz &&\
    tar xf buildroot-*.tar* &&\
    rm buildroot-*.tar* &&\
    ln -s buildroot-* buildroot

#RUN mkdir -v buildroot/patches
#RUN mkdir -vpm775 buildroot/rootfs_overlay/srv
#COPY    in/buildroot.conf       /root/buildroot/.config

RUN echo "alias ll='ls -lah --color=auto'" >> .bashrc

ENTRYPOINT [ "/bin/bash" ]

# build: docker build -t buildroot .
# use: docker run --name buildroot -itd buildroot:latest