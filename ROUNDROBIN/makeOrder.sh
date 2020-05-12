#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script checks if there are waiting processes and adds them to the queue.       #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################


function makeOrder() { 
    for p in ${process_IDs[@]}  # Loop all processes there are.
    do 
        if [[ $p -ne $1 ]]  # One can pass a process_id as an argument and the one won't be put in queue.
        then
            isInOrder $p  # Check if the process is already in queue 1=YES, 0=NO.
            x=$?  # Store the 1 or 0 in x.
            if [[ ${at[$p]} -le $clock ]]  && [[ $x -eq 0 ]]  # Check if the process has already arrived. And is not already in queue.
            then
                queue+=($p)  # Only if the two conditions apply the process_id is added to the queue.
            fi
        fi
    done
}