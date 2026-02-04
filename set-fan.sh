#!/bin/bash

# 第1引数にGPU ID、第2引数にファン速度(%)を指定
# 例: ./set-fan.sh 0 80
GPUID=${1:-0}
FAN_SPEED=${2:-85}

# エラーの直接の原因である「Display」を環境変数で指定
export DISPLAY=:0

echo "GPU:${GPUID} のファン速度を ${FAN_SPEED}% に設定します..."

# ファン制御を手動モード(1)に変更
nvidia-settings -a "[gpu:${GPUID}]/GPUFanControlState=1"

# ファン速度を設定
nvidia-settings -a "[fan:${GPUID}]/GPUTargetFanSpeed=${FAN_SPEED}"

echo "設定が完了しました。"
