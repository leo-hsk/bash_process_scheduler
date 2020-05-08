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

log_info ""
log_info ""
log_info "############################################################"
log_info "#                    Process Overview                      #"
log_info "############################################################"
log_info

awk 'BEGIN {printf("%-22s %-26s %-20s  \n" ,"Process", "Arrival Time", "Burst Time")}'
for i in ${process_IDs[@]}
do
	echo "------------------------------------------------------------"
	awk -v p_names="${process_names[$i]::20}" -v at="${arrival_time[$i]}" -v bt="${burst_time[$i]}" 'BEGIN {printf("%-26s %-26s %-20s  \n" ,p_names, at, bt)}'
done