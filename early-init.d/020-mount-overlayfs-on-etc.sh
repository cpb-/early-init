#!/bin/sh

WORKDIR=/data/overlayfs/etc/workdir
UPPERDIR=/data/overlayfs/etc/upperdir
mkdir -p "${WORKDIR}"  "${UPPERDIR}"

mount none /etc -t overlay -o lowerdir=/etc,workdir="${WORKDIR}",upperdir="${UPPERDIR}"

