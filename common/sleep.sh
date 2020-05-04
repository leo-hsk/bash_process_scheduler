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

IFS=''
for (( i=$1; i>0; i--))
do
	printf "\rYou have %02d seconds left to review processes or press [ENTER]" ${i}
	read -s -N 1 -t 1 key

	if [ "$key" == $'\x0a' ] # '\x0a' is Enter
	then
		break
	fi
done