#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script contains functions to copy the arrival and burdt time array.            #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################


function copyArrivalTime () {
    for i in $(seq 0 $((${#arrival_time[@]}-1)))
    do
        echo hi
        at[$i]=${arrival_time[$i]}
    done
}

function copyBurstTime () {
    for i in $(seq 0 $((${#burst_time[@]}-1)))
    do
        echo hi
        bt[$i]=${burst_time[$i]}
    done
}

function resetArrays() {
    
    copyBurstTime
    copyArrivalTime
    
    #printf "reseted\n"

}

