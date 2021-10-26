#!/bin/sh

GPUID=$1
GPU_OFFSET=-200
MEM_OFFSET=1995

nvidia-smi -i $GPUID -pm ENABLED
nvidia-smi -i $GPUID -pl 310
DISPLAY=:0 nvidia-settings --verbose \
    -a "[gpu:$GPUID]/GPUPowerMizerMode=1" \
    -a "[gpu:$GPUID]/GPUGraphicsClockOffset[4]=$GPU_OFFSET" \
    -a "[gpu:$GPUID]/GPUMemoryTransferRateOffset[4]=$MEM_OFFSET"
