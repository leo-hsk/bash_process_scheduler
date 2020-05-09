#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script creates a gantt chart using the process flow array.                     #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

algorithm=$algo_choice

declare -a output_data

len_names=${#process_names[@]}

spaces="     "

for i in ${process_IDs[@]}  # Loop trough process IDs.
do
    process_names[$i]=${process_names[$i]::5}  # If a Process name is longer than five chars it gets shortend to five.
    
    let l=5-${#process_names[$i]}  
    s=${spaces::$l}  # If name is less than 5 chars -> fill rest with spaces.
    output_data[$i]=${process_names[$i]}$s  # Add name with spaces to the beginning of every processe's output line.
done

# Track each iteration
ticker=0

# Create the actual chart:
for p in "${process_flow[@]}"
do
    ticker=$(($ticker+1))
    
    if [[ $p == -1 ]]  # If no process is in the queue
    then 
        for p2 in "${process_IDs[@]}"
        do
            output_data[$p2]=${output_data[$p2]}'░' # On every other processe's line a ░ gets added.
        done

    else  # If process is in the queue
        output_data[$p]=${output_data[$p]}'█' # In the line of the process that gets processed in this time unit a █ gets added.

        # Add symbols to all processes which are not processed in this iteration
        for p2 in "${process_IDs[@]}"
        do
            ct=$((${tat[$p2]}+${arrival_time[$p2]})) # Calculate completion time
            
            if [[ $p2 != $p ]] && [[ ${arrival_time[$p2]} -lt $ticker ]] && [[ $ct -ge $ticker ]]  # Add a ▒ if the process already arrived in the queue and is not finished.
            then
                output_data[$p2]=${output_data[$p2]}'▒' # On every other processe's line a ░ gets added.
            elif [[ $p2 != $p ]]
                then
                output_data[$p2]=${output_data[$p2]}'░' # Add ░ if process did not arrive
            fi
        done
    fi
done

# OUTPUT
n_out=${#process_flow[@]} # The length of the process simulation
let n_remove=91-$n_out # 91 is the lentgh of the full time line and we want to remove the extending part.
full_line="     1••••••••10••••••••20••••••••30••••••••40••••••••50••••••••60••••••••70••••••••80••••••••90"
 
time_line=${full_line::${#full_line}-n_remove}  # Remove from the full line everything that extends the length of the process simulation

log_info "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo Gantt Chart of $algorithm  # Diagramm Title with name of the chosen algorithm.
echo
echo "$time_line"

for i in $(seq 0 $(($n-1)))
do 
    echo "${output_data[$i]::96}"  # Print every processe's output line.
done
echo "$time_line"
echo




