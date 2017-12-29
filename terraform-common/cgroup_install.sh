#!/bin/bash

#
# file: cgroup_install.sh
# description: create a cgroup to limit resources used by the database to force IOPS usage
#

set -x

DEBIAN_FRONTEND=noninteractive apt-get install cgroup-bin cgroup-lite libcgroup1 -y
cgcreate -g memory:DBLimitedGroup
echo 30G > /sys/fs/cgroup/memory/DBLimitedGroup/memory.limit_in_bytes
sync; echo 3 > /proc/sys/vm/drop_caches

