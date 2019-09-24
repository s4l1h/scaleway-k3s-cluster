#!/usr/bin/env bash
set -e
token=$(cat ./data/node-token)
# Trim
token=`echo $token`
echo "{\"token\":\"$token\"}"