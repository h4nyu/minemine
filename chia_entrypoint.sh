#!/bin/sh
chia init
sed -i 's/localhost/127.0.0.1/g' ~/.chia/mainnet/config/config.yaml
echo $CHIA_KEY > /chia_key
chia keys add -f /chia_key
for d in /mnt/disk*/ ; do
    chia plots add -d $d
done
$@
