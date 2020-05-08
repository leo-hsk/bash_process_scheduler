#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script returns the next process id in the queue. And than removes it from it.  #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

function getNextInQueue(){
    # If there is nothing in the queue it returns a 44 (44 because -1 does not work - turns it into a 255 wegen zweierkompliment - and 44 is ok because the max number of processes is 25 anyway.).
    if [[ ${#queue[@]} -gt 0 ]]
    then
        x=${queue[0]}
        queue=("${queue[@]:1}")
        return $x
    else
        return 44  # Returns a 44 if queue is empty. There cant be 44 processes - 25 is the max for this simulator.
    fi
}