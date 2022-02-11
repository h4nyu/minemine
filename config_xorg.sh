#!/bin/sh
nvidia-xconfig --enable-all-gpus
nvidia-xconfig -a --allow-empty-initial-configuration --cool-bits=28 
