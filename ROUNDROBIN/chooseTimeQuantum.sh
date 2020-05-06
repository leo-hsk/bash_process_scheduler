#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script asks the user to choose the time quantum for the round robin scheduling.#
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################



while True
do
    echo "How long do you want the time slice to be? 1-50."
    read -p "--> " -n 2 -r
    echo 
    q_answer=$REPLY 
    echo   " " # (optional) move to a new line
    if [[ $q_answer -gt 50 ]] || [[ $q_answer -le 0 ]]
    then 
        echo "Answer must be an integer between 1 and 50."
    else
        quantum=$q_answer
        break
    fi
done
