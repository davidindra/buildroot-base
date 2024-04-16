FROM debian:12

WORKDIR /

# Install dependencies.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive\
    apt-get install -y build-essential libncurses5-dev rsync cpio python3 python-is-python3 unzip bc wget file git \
                       htop nano mc && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

# Install Buildroot. NOTICE: update tag in .github/workflows/docker.yml when changing the version here!

RUN wget -nv https://buildroot.org/downloads/buildroot-2024.02.1.tar.gz &&\
    tar xf buildroot-*.tar* &&\
    rm buildroot-*.tar* &&\
    mv buildroot-* buildroot

LABEL org.buildroot.version="2024.02.1"

VOLUME [ "/buildroot/dl", "/buildroot/output" ]

ENTRYPOINT [ "/bin/bash" ]

# build: docker build -t buildroot .
# use: docker run --name buildroot -itd buildroot:latest
# use prebuilt: docker run --name buildroot -itd davidindracz/buildroot-base:latest