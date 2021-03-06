#!/bin/sh

GPUID=$1
GPU_OFFSET=100
MEM_OFFSET=1930

nvidia-smi -i $GPUID -pm ENABLED
nvidia-smi -i $GPUID -pl 270
DISPLAY=:0 nvidia-settings --verbose \
    -a "[gpu:$GPUID]/GPUGraphicsClockOffsetAllPerformanceLevels=$GPU_OFFSET" \
    -a "[gpu:$GPUID]/GPUMemoryTransferRateOffsetAllPerformanceLevels=$MEM_OFFSET"
