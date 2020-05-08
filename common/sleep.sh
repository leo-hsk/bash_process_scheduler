#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script pauses the script for given seconds.                                    #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

i=15
while [[ i -ge 0 ]]
do 

    printf "\rYou have %02d seconds left." ${i}
    i=$(($i-1))
    read -s -t 1 -p " Or Press ENTER to continue."
    a=$?
    if [[ $a == 0 ]]
    then
        break
    fi
done
