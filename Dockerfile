FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y python3 python3-pip

RUN mkdir sketch-artist
COPY * ./sketch-artist

# working directory within the container
WORKDIR /sketch-artist

# startup script
RUN /bin/echo -e "#!/bin/bash\necho startup\n/bin/bash" > /usr/local/bin/startup.sh
RUN chmod 777 /usr/local/bin/startup.sh

# user
RUN useradd -m artist
USER artist

CMD ["/usr/local/bin/startup.sh"]