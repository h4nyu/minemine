#!/bin/sh

GPUID=$1
POWERLIMIT=210

nvidia-smi -i $GPUID -pm ENABLED
nvidia-smi -i $GPUID -pl $POWERLIMIT
