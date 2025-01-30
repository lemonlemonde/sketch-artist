FROM nvcr.io/nvidia/l4t-ml:r36.2.0-py3

# working directory within the container
RUN mkdir /sketch-artist
WORKDIR /sketch-artist

# user
RUN useradd artist
USER artist

# git clone
RUN git clone 


# run ls to check everything good
CMD ["ls", "-l"]
