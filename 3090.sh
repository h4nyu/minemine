#!/bin/sh

GPUID=$1
GPU_OFFSET=-300
MEM_OFFSET=500

nvidia-smi -i $GPUID -pl 285
DISPLAY=:0 nvidia-settings --verbose \
    -a "[gpu:$GPUID]/GPUPowerMizerMode=1" \
    -a "[gpu:$GPUID]/GPUGraphicsClockOffset[4]=$GPU_OFFSET" \
    -a "[gpu:$GPUID]/GPUMemoryTransferRateOffset[4]=$MEM_OFFSET"
