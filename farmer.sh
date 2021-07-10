#!/bin/sh
chia start farmer -r
chia plotnft create -u $CHIA_POOL -s pool
tail -f /dev/null
