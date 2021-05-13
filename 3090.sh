#!/bin/sh

GPUID=$1
GPU_OFFSET=-400
MEM_OFFSET=2100

nvidia-smi -i $GPUID -pl 325
DISPLAY=:0 nvidia-settings --verbose \
    -a "[gpu:$GPUID]/GPUPowerMizerMode=1" \
    -a "[gpu:$GPUID]/GPUGraphicsClockOffset[4]=$GPU_OFFSET" \
    -a "[gpu:$GPUID]/GPUMemoryTransferRateOffset[4]=$MEM_OFFSET"
