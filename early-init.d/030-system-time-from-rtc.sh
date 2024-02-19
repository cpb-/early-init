#!/bin/sh
#
# SPDX-License-Identifier: MIT
#
# Script to read the hardware clock and set the system time.
# If the clock is still invalid (prior to reference date) then set a
# default date (this may be needed to check some certificate validity).

REFERENCE_YEAR=2024
REFERENCE_MONTH=02
REFERENCE_DAY=01

hwclock -s

if [ $(date +"%Y%m%d") -lt "${REFERENCE_YEAR}${REFERENCE_MONTH}${REFERENCE_DAY}" ]
then
	date ${REFERENCE_MONTH}${REFERENCE_DAY}0000${REFERENCE_YEAR}
fi
