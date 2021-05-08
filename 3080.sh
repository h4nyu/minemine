#!/bin/sh

GPUID=$1
GPU_OFFSET=-300
MEM_OFFSET=1000

nvidia-smi -i $GPUID -pl 230 
DISPLAY=:0 nvidia-settings -a "[gpu:$GPUID]/GPUPowerMizerMode=1"
DISPLAY=:0 nvidia-settings -a "[gpu:$GPUID]/GPUGraphicsClockOffset[2]=$GPU_OFFSET"
DISPLAY=:0 nvidia-settings -a "[gpu:$GPUID]/GPUGraphicsClockOffset[3]=$GPU_OFFSET"
DISPLAY=:0 nvidia-settings -a "[gpu:$GPUID]/GPUGraphicsClockOffset[4]=$GPU_OFFSET"
DISPLAY=:0 nvidia-settings -a "[gpu:$GPUID]/GPUMemoryTransferRateOffset[2]=$MEM_OFFSET"
DISPLAY=:0 nvidia-settings -a "[gpu:$GPUID]/GPUMemoryTransferRateOffset[3]=$MEM_OFFSET"
DISPLAY=:0 nvidia-settings -a "[gpu:$GPUID]/GPUMemoryTransferRateOffset[4]=$MEM_OFFSET"
