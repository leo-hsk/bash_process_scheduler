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

## Declare global variables
export arrival_time=( 3 5 7 2 6 )
export burst_time=( 3 5 1 3 6 )
export process_names=( A B C D E )
export process_IDs=( 0 1 2 3 4 )

export max_no=75 # Max no. of allowed gantt chart characters
export n=5 # No. of sample processes
export isExit=0

export process_flow=()

export tat=( $(for i in $(seq 1 $n); do echo 0; done) )
export wt=( $(for i in $(seq 1 $n); do echo 0; done) )
