#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script implements a loading bar function.                                      #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

export sp="/-\|"
export sc=0

spin() {
    tput civis      -- invisible  # hide cursor
    printf "\b${sp:sc++:1}"
    ((sc==${#sp})) && sc=0
}

endspin() {
    printf "\r"
    tput cnorm   -- normal  # display cursor
}