#!/bin/sh
echo $CHIA_KEY > /chia_key
chia keys add -f /chia_key
for d in /mnt/disk*/ ; do
    chia plots add -d $d
done
$@
