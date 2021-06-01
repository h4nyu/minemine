#!/bin/sh

chia keys add -f /chia_keys

chia plots add -d /plots
$@
