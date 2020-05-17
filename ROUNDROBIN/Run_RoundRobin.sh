#!/bin/bash

#############################################################################################
#                                                                                           #
# This is our implementation of the Round Robin scheduling algorithm.                       #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

source ${processSchedulerWorkingDir}/ROUNDROBIN/chooseTimeQuantum.sh
source ${processSchedulerWorkingDir}/ROUNDROBIN/isInOrder.sh
source ${processSchedulerWorkingDir}/ROUNDROBIN/makeOrder.sh
source ${processSchedulerWorkingDir}/ROUNDROBIN/getNextInQueue.sh
source ${processSchedulerWorkingDir}/ROUNDROBIN/getAllWaitingJobs.sh

declare -a queue=()

clock=0  # This is the simulations clock = passed time since start.

makeOrder 44

while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]  # This summs up the whole burst time array, if EVERY process has a burst time of 0 we are done. As long as that is not the case, do all this again and agin:
do
    getNextInQueue  # Get the next process in queue by calling the function.
    id=$?  # Store the output inside the variable id.
    if [[ $id -ne 44 ]]  # The function returns a 44 in the case the queue is empty, meaning no process is waiting -> skip to else to increase clock by one.
    then
        service_units=${bt[$id]}  # The Service time for round robin is the time slice / quantum but it might be the case that a processes as less than quantum units left.
        if [ $service_units -gt 0 ]  # If service units is greater then 0 -> continue. If it is 0 the process is already fully completed.
        then
            if [ $service_units -gt $quantum ]  # In the likely case the service units are larger than the time quantum: reduce to quantum.
            then
                service_units=$quantum  # If the Process has more than 3 (or whatever value quantum has) time units of service left, it gets shortend to the value of quantum.
            fi
            for i in $( seq 1 $service_units )  # Now do the following steps for *service_units* times.
                do

                    getAllWaitingJobs
                    # Update waiting times each iteration for every process other than id
                    for p in $(seq 0 $((${#isWaiting[@]}-1)))
                    do
                        if [[ $p -ne $id ]]
                        then
                            wt[$p]=$((wt[$p]+isWaiting[$p]))
                        fi
                    done

                    process_flow[$clock]=$id  # Add the id of the process to the process_flow array
                    clock=$(($clock+1))  # Increase clock by one.
                    makeOrder $id  # Call the make order function and pass id, beacuse we do not want to include id in the queue since it is processed at the moment. If another process comes in at that moment of time, the other processes must get the spot in queue infront of theone processed right now.
                done

            bt[$id]=$((${bt[$id]}-$service_units))  # Update the burst time.
            if [[ ${bt[$id]} -gt $((0)) ]]  # If the process is not finished:
            then
                queue+=($id)  # Add the process back to the queue.
            fi
            tat[$id]=$(($clock-${arrival_time[$id]}))  # Calculate the turnaround time using the immutable arrival time array.
        fi
    else
        process_flow[$clock]=-1  # If there is no process ready to process, add -1 to the process flow array.
        clock=$(($clock+1))
        makeOrder 44  # Call make order to add new processes that might appeared in the clock increase by one.
    fi
done