#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script calculates the average waiting time and burst time.                     #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

sum_wt=0
sum_tat=0

for i in ${process_IDs[@]}
do
	sum_wt=$(($sum_wt+wt[$i]))
	sum_tat=$(($sum_tat+tat[$i]))
done

avg_wt=$(bc <<< "scale=3;$sum_wt/$n")
avg_tat=$(bc <<< "scale=3;$sum_tat/$n")
printf "Average Waiting Time: $avg_wt"
printf "\nAverage Turnaround Time: $avg_tat"



