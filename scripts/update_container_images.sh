#!/usr/bin/env bash

for i in $(podman images -n | awk '{print $1":"$2}'); do
    podman pull $i -q
done
