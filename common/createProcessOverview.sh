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

##### DECLARED ONLY FOR TESTING
#declare -a process_names=( 1sdssds 2lkdsergdfgsdfgsdfgsdajfl 3ss 42 5 )

# List of process IDs. The IDs represent the index of the process.
#declare -a process_IDs=( 0 1 2 3 4 )

# List of burst time
#declare -a bt=( 5 333 8 63 7 )

# Arrival Time
#declare -a at=( 0 12 2 3 5 )

#######################################################

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