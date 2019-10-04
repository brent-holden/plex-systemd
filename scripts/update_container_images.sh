#!/usr/bin/env bash

for i in $(docker images -n | awk '{print $1":"$2}'); do
    docker pull $i -q
done
