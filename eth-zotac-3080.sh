#!/bin/sh

GPUID=$1
GPU_OFFSET=-200
MEM_OFFSET=1550

nvidia-smi -i $GPUID -pm ENABLED
nvidia-smi -i $GPUID -pl 215

DISPLAY=:0 nvidia-settings --verbose \
    -a "[gpu:$GPUID]/GPUGraphicsClockOffsetAllPerformanceLevels=$GPU_OFFSET" \
    -a "[gpu:$GPUID]/GPUMemoryTransferRateOffsetAllPerformanceLevels=$MEM_OFFSET"
