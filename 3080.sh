#!/bin/sh

GPUID=$1
GPU_OFFSET=-300
MEM_OFFSET=2000

nvidia-smi -i $GPUID -pl 225
DISPLAY=:0 nvidia-settings --verbose \
    -a "[gpu:$GPUID]/GPUGraphicsClockOffsetAllPerformanceLevels=$GPU_OFFSET" \
    -a "[gpu:$GPUID]/GPUMemoryTransferRateOffsetAllPerformanceLevels=$MEM_OFFSET"
