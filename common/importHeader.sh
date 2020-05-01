#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script imports all required information to run scripts.                        #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################


# Import logging unit
source ${processSchedulerWorkingDir}/common/logger.sh

# Import configuration
if [[ -f ${processSchedulerWorkingDir}/setup.conf ]]
then
	source ${processSchedulerWorkingDir}/setup.conf
else
	echo "ERROR: Config file is missing."
	echo "Aborting."
	exit 1
fi