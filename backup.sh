#!/bin/bash

set -e

# set the amount of images to keep
KEEP_SNAPSHOTS=${KEEP:-2}

# get all server ids in project
SERVERSID=$(hcloud server list -o noheader -o columns=id)

function make_snapshot {
  echo "Creating snapshot to server id $1"
  hcloud server create-image --type snapshot --label id=$1 --description server-$1 --poll-interval 0 $1
}

function rotate_snapshots {
  echo "Check if rotate is needed"
  if [[ `hcloud image list --type snapshot --selector id=$1 -o noheader -o columns=id | wc -l | xargs` > $KEEP_SNAPSHOTS ]]; then
    echo "Deleting oldest snapshot"
    SNAPSHOTID=$(hcloud image list --type snapshot --selector id=$1 -o noheader -o columns=id | head -1)
    hcloud image delete $SNAPSHOTID
  else 
    echo "No need to delete snapshot"
  fi
}

for ID in $SERVERSID; do
  echo "working on server id $ID"
  make_snapshot $ID
  rotate_snapshots $ID
done
