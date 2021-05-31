cd /chia-blockchain

. ./activate

chia init

chia keys add -f /chia_keys

if [[ ! "$(ls -A /plots)" ]]; then
  echo "Plots directory appears to be empty and you have not specified another, try mounting a plot directory with the docker -v command "
fi

for d in /mnt/*/ ; do
    chia plots add -d $d
done

sed -i 's/localhost/127.0.0.1/g' ~/.chia/mainnet/config/config.yaml

chia start farmer
while true; do sleep 30; done;
