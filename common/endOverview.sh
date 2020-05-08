#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script creates an table-like process overview in the console.                  #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

awk 'BEGIN {printf("%-12s %-12s %-12s %-12s %-12s  \n" ,"Process", "AT", "BT", "WT", "TAT")}'
for i in ${process_IDs[@]}
do
    echo "------------------------------------------------------------"
    awk -v p_names="${process_names[$i]::8}" -v at="${arrival_time[$i]}" -v bt="${burst_time[$i]}" -v wtt="${wt[$i]}" -v tt="${tat[$i]}" 'BEGIN {printf("%-12s %-12s %-12s %-12s %-12s  \n" ,p_names, at, bt, wtt, tt)}'
done
