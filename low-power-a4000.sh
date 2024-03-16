#!/bin/sh

GPUID=$1
POWERLIMIT=100

nvidia-smi -i $GPUID -pm ENABLED
nvidia-smi -i $GPUID -pl $POWERLIMIT
