FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y python3 python3-pip
RUN apt-get install -y wget git

# miniconda
RUN arch=$(uname -m) && \
    if [ "$arch" = "x86_64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"; \
    elif [ "$arch" = "aarch64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"; \
    else \
    echo "Unsupported architecture: $arch"; \
    exit 1; \
    fi && \
    wget $MINICONDA_URL -O miniconda.sh && \
    mkdir -p /opt/.conda && \
    bash miniconda.sh -b -p /opt/miniconda3 && \
    rm -f miniconda.sh

ENV PATH=/opt/miniconda3/bin:$PATH

# working directory within the container
RUN git clone https://github.com/lemonlemonde/sketch-artist.git
WORKDIR /sketch-artist

RUN useradd -m artist

# give access to git, startup script, etc.
RUN chown -R artist:artist /sketch-artist
RUN chmod -R u+rwx /sketch-artist

# no longer root
USER artist

CMD ["/sketch-artist/startup.sh"]