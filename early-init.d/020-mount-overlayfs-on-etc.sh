#!/bin/sh
#
# SPDX-License-Identifier: MIT
#
# Script to mount an overlayfs over `/etc/`.
# The `/` partition is supposed to be mounted read-only.
# The `/data` partition is mounted in read-write mode (see script 010).
#
WORKDIR=/data/overlayfs/etc/workdir
UPPERDIR=/data/overlayfs/etc/upperdir

mkdir -p "${WORKDIR}"  "${UPPERDIR}"

mount none /etc -t overlay -o lowerdir=/etc,workdir="${WORKDIR}",upperdir="${UPPERDIR}"

