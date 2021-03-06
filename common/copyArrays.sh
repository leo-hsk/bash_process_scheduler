#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script contains functions to copy the arrival and burst time array.            #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################


function copyArrivalTime () {
    at=( $(for i in $(seq 1 $n); do echo 0; done) )
    for i in $(seq 0 $((${#arrival_time[@]}-1)))
    do
        at[$i]=${arrival_time[$i]}
    done
}

function copyBurstTime () {
    bt=( $(for i in $(seq 1 $n); do echo 0; done) )
    for i in $(seq 0 $((${#burst_time[@]}-1)))
    do
        bt[$i]=${burst_time[$i]}
    done
}


function resetTatAndWt () {

    tat=( $(for i in $(seq 1 $n); do echo 0; done) )
    wt=( $(for i in $(seq 1 $n); do echo 0; done) )
}

function resetProcessFlow () {

    process_flow=( )
}

function resetArrays() {

    copyBurstTime
    copyArrivalTime
    resetTatAndWt
    resetProcessFlow
}
