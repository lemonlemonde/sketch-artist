#!/bin/bash

conda env create -f ./env.yml
source activate base
conda init
conda activate sketch-artist

echo ====== Welcome! ======
/bin/bash