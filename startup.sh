#!/bin/bash

conda init bash
source ~/.bashrc
echo "------ Done init bash ------"

# make it default :p
# echo "source activate sketch-artist" > ~/.bashrc

conda env create -f ./env.yml
echo "------ Done creating env ------"

conda activate sketch-artist


echo ====== Welcome! ======
/bin/bash