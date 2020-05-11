#!/bin/bash

#############################################################################################
#                                                                                           #
# This is our implementation of the First Come First Served scheduling algorithm.           #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

source ${processSchedulerWorkingDir}/FCFS/findSmallestValue.sh
source ${processSchedulerWorkingDir}/common/getAllWaitingJobs.sh

isWaiting=( $(for i in $(seq 1 $n); do echo 0; done))  # One if process is waiting and zero if not

clock=0  # Track the no. of iterations

while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]  # Loop until the sum of the burst time array is zero.
do	
	id=$(findSmallestValue)  # Find index of the process with smallest arrival time.

	if [[ ${at[$id]} -le $clock ]]
	then
		service_units=${bt[$id]}

		for burst in $(seq 1 $service_units) # Iterate through service_units (number of bursts).
		do
			getAllWaitingJobs
			# Update waiting times each iteration for every process other than id.
			for p in $(seq 0 $((${#isWaiting[@]}-1))) 
			do
				if [[ $p -ne $id ]]
				then
					wt[$p]=$((wt[$p]+isWaiting[$p]))
				fi
				#printf "."
			done

			process_flow[$(($clock))]=$id  # Add the id of the process to the process_flow array.
			clock=$(($clock+1))  # Increase clock by one.
		done
		
		bt[$id]=0  # As soon as a process is finished, its burst time is set to 0.
		at[$id]=$(($max_no+1)) # IMPORTANT To Do: the algorithm is only working if the arrival time is set to high number.
		tat[$id]=$(($clock-${arrival_time[$id]}))  # Calculate the turnaround time using the immutable arrival time array.
	else
		process_flow[$(($clock))]=-1  # If there is no process ready to burst, add -1 to the process flow array
		clock=$(($clock+1))  # And increase clock by one.
	fi
done
