#!/bin/sh

GPUID=$1
GPU_OFFSET=-200
MEM_OFFSET=1850
FAN_SPEED=80

nvidia-smi -i $GPUID -pm ENABLED
nvidia-smi -i $GPUID -pl 220

DISPLAY=:0 nvidia-settings --verbose \
    -a "[gpu:$GPUID]/GPUGraphicsClockOffsetAllPerformanceLevels=$GPU_OFFSET" \
    -a "[gpu:$GPUID]/GPUMemoryTransferRateOffsetAllPerformanceLevels=$MEM_OFFSET" \
    -a "[gpu:$GPUID]/GPUFanControlState=1" \
    -a "[fan:$GPUID]/GPUTargetFanSpeed=$FAN_SPEED"
