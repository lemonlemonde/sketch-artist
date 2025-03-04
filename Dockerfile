FROM dustynv/l4t-pytorch:r36.4.0

RUN apt-get update
RUN apt-get install -y python3 python3-pip
RUN apt-get install -y wget git


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