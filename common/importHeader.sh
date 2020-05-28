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

if [[ -f ${processSchedulerWorkingDir}/setup.conf ]]  # Import configuration
then
	source ${processSchedulerWorkingDir}/setup.conf
else
	echo "ERROR: Config file is missing."
	echo "Aborting."
	exit 1
fi

### Declare global variables. Those are the sample processes: ###
export arrival_time=( 4 3 0 5 12 20 9 15 )
export burst_time=( 7 8 3 2 5 5 12 1 )
export process_names=( a b c d e f g h )
export process_IDs=( 0 1 2 3 4 5 6 7 )

export max_no=75 # Max no. of allowed gantt chart characters
export n=8 # No. of sample processes

export isExit=0

export process_flow=()  # This is the array that gets filled by the scheduling algorithm and later visualized as a gantt chart.

export tat=( $(for i in $(seq 1 $n); do echo 0; done))  # Arrays to store turnaround time.
export wt=( $(for i in $(seq 1 $n); do echo 0; done))  # Arrays to store waiting time.

export quantum=3  # Quantum/time-slice for RoundRobin scheduling. The defualt value is 3.

export validParam2=("--FCFS" \ 
			 		"--HRRN" \
			 		"--RoundRobin" \
			 		"--resume" \
			 		"--chart" )

export red=$'\e[1;31m'  # Red color


export endRed=$'\e[0m'  # White color