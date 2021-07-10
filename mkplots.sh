#!/bin/sh
chia plots create -c $CHIA_WALLET -k 32 -t /tmp_plots -d /plots $@
