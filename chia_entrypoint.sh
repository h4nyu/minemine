#!/bin/sh
chia keys add -f /chia_keys

for d in /mnt/*/ ; do
    chia plots add -d $d
done

$@
