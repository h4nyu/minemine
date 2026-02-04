#!/bin/sh

GPUID=$1

nvidia-smi -i $GPUID -pm ENABLED
nvidia-smi -i $GPUID -pl 300
DISPLAY=:0 nvidia-settings --verbose -a "[fun:$GPUID]/GPUTargetFanSpeed=70" 
