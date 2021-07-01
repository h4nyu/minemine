#!/bin/sh
chia plotnft create -u $CHIA_POOL -s pool
chia plots create -c $CHIA_WALLET -k 32 -t /tmp_plots -d /plots $@
