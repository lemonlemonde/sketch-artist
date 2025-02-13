FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y python3 python3-pip
RUN apt-get install -y wget

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
    mkdir -p /root/.conda && \
    bash miniconda.sh -b -p /root/miniconda3 && \
    rm -f miniconda.sh

RUN mkdir sketch-artist
COPY * ./sketch-artist

# working directory within the container
WORKDIR /sketch-artist

# startup script
# RUN chmod 777 startup.sh

# user, no longer root
RUN useradd -m artist
USER artist

CMD ["startup.sh"]