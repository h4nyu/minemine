#!/bin/sh
echo $CHIA_KEY > /chia_key
chia keys add -f /chia_key
$@
