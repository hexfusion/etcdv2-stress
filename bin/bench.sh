#!/bin/bash -e

source ./config

for size in ${keysize[@]}; do
  for key in ${keys[@]}; do
    ./bin/hey -m PUT -n $req -d value=`head -c $size < /dev/zero | tr '\0' '\141'` -c $con -T application/x-www-form-urlencoded $leader/v2/keys/${key}
    sleep 3
  done
done

./bin/hey -n 256000 -c 256 $leader/v2/keys/foo
