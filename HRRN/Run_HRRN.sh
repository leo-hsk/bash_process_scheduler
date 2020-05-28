#!/bin/bash

#############################################################################################
#                                                                                           #
# This is our implementation of the Highest Response Ratio Next scheduling algorithm.       #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

source ${processSchedulerWorkingDir}/HRRN/findHighestResponseRatio.sh
source ${processSchedulerWorkingDir}/HRRN/calcResponseRatio.sh
source ${processSchedulerWorkingDir}/common/getAllWaitingJobs.sh
source ${processSchedulerWorkingDir}/common/spinner.sh

isWaiting=( $(for i in $(seq 1 $n); do echo 0; done) )
responseR=( $(for i in $(seq 1 $n); do echo 0; done) )

clock=0  # Track the no. of iterations

# Loop until the sum of the burst time array is zero
while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]
do
    calcResponseRatio  # Find index of the smallest arrival time
    id=$(findHighestResponseRatio)
    let tmp=${at[$id]}-$clock
    if [[ $tmp -le 0 ]]
    then
        service_units=${bt[$id]}

        # Iterate through service_units ( Number of bursts)
        for burst in $(seq 1 $service_units)
        do

            getAllWaitingJobs
            # Update waiting times each iteration for every process other than id
            for p in $process_IDs
            do
                if [[ $p -ne $id ]]
                then
                    wt[$p]=$((wt[$p]+isWaiting[$p]))
                fi
            done

            spin
            process_flow[$(($clock))]=$id # Add the id of the process to the process_flow array
            clock=$(($clock+1)) # Add the number of service units to the clock
        done

        bt[$id]=0
        at[$id]=$(($max_no+1))
        tat[$id]=$(($clock-${arrival_time[$id]}))  # Calculate the turnaround time using the immutable arrival time array.

    else
        process_flow[$(($clock))]=-1  # If there is no process ready to process, add -1 to the process flow array
        clock=$(($clock+1))
    fi
done
endspin