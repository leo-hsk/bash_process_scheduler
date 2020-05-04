#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script returns a 0 if a passed process is not in thw queue or a 1 if it is.    #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################


function isInOrder() {
    # If the passsed process is alredy in the queue return 1. If not return 0.
    for p2 in ${queue[@]}  # Loop all processes in queue.
    do 
        if [[ $p2 -eq $1 ]]  # If the one passed as an argument equals one of the ones inside queue.
        then
            return 1

        fi
    done
    # If no process in queue equaled the passed one:
    return 0
}