#!/bin/sh
#
# SPDX-License-Identifier: MIT
#
# Script to mount a read-write data partition, to check the filesystem in
# case of mount failure, and to reformate the partition if the check failed.
#

PARTITION=/dev/mmcblk0p3
MOUNTPOINT=/data
FILESYSTEM=ext4
NAME=data

printf "Mounting ${NAME} partition..." >&2
if mount ${PARTITION} ${MOUNTPOINT} -t ${FILESYSTEM} >/dev/null 2>&1
then
	printf "Ok\n" >&2
	exit 0
fi
printf "Failed\n" >&2

printf "Checking ${NAME} partition..." >&2
if fsck.${FILESYSTEM}  -p  ${PARTITION} >/dev/null 2>&1
then
	if mount ${PARTITION} ${MOUNTPOINT} -t ${FILESYSTEM} >/dev/null 2>&1
	then
		printf "Ok\n" >&2
		exit 0
	fi
fi
printf "Failed\n" >&2

printf "Formating ${NAME} partition..." >&2
if [ "${FILESYSTEM}" = "vfat" ]
then
	mkfs.vfat -c -n DATA ${PARTITION} >/dev/null 2>&1
else
	mkfs.${FILESYSTEM} -c -L DATA -q ${PARTITION} >/dev/null 2>&1
fi


if mount ${PARTITION} ${MOUNTPOINT} -t ${FILESYSTEM} >/dev/null 2>&1
then
	printf "Ok\n" >&2
	exit 0
fi

printf "Failed\n" >&2
exit 1
