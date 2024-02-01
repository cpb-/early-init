#!/bin/sh

PARTITION=/dev/mmcblk0p3
MOUNTPOINT=/data
FILESYSTEM=ext4

if mount ${PARTITION} ${MOUNTPOINT} -t ${FILESYSTEM}
then
	exit 0
fi

if fsck.${FILESYSTEM}  -p  ${PARTITION}
then
	if mount ${PARTITION} ${MOUNTPOINT} -t ${FILESYSTEM}
	then
		exit 0
	fi
fi

if [ "${FILESYSTEM}" = "vfat" ]
then
	mkfs.vfat -c -n DATA ${PARTITION} 2>/dev/null
else
	mkfs.${FILESYSTEM} -c -L DATA -q ${PARTITION} 2>/dev/null
fi


if mount ${PARTITION} ${MOUNTPOINT} -t ${FILESYSTEM}
then
	exit 0
fi

exit 1
