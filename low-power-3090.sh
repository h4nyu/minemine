#!/bin/sh

GPUID=$1

nvidia-smi -i $GPUID -pm ENABLED
nvidia-smi -i $GPUID -pl 250
