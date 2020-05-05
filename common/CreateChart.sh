#! /bin/bash

# Create some samples here that will later be replaced by the real output from the Algorithms


# Wichtig: Ich gehe hier davon aus das jedem Prozess der Reihenfolge nach eine nummer gegeben wird.
# Also A -> 0, B -> 1, C -> 2 ... 
# Und das in der Simulation nicht die namen in die Output Liste geschreiben werden, sondern eben die Nummer:
# Die Output Liste sollte dann so aussehen:


##########################
# Calculated through previous steps or user input
# Arrival Time

# Turnaround Time

##########################

algorithm=$algo_choice

declare -a process_nums
declare -a output_data

len_names=${#process_names[@]}

spaces="     "
# For every name in the process names we want a number in process nums, satrting with 1:
let x=$len_names-1
for i in $(seq 0 $x)  # Loop trough range 0 to length of namesList.
do 
    process_nums[$i]=$i  # Every Process names gets a corresponding number (its own index i all the arrays) in the numbersList.

    process_names[$i]=${process_names[$i]::5}  # If a Process name is longer than five chars it gets shortend to five.
    

    let l=5-${#process_names[$i]}  
    s=${spaces::$l}  # If name is less than 5 chars -> fill rest with spaces.
    output_data[$i]=${process_names[$i]}$s  # Add name with spaces to the beginning of every processe's output line.
done

#echo ${process_nums[*]}
#echo ${output_data[*]}

# Track each iteration
ticker=0

# Create the actual chart:
for p in "${process_flow[@]}"
do
    ticker=$(($ticker+1))
    # If no process is in the queue
    if [[ $p == -1 ]]
    then 
        for p2 in "${process_nums[@]}"
        do
            output_data[$p2]=${output_data[$p2]}'░' # On every other processe's line a ░ gets added.
        done
    else
        # If process is in the queue
        output_data[$p]=${output_data[$p]}'█' # In the line of the process that gets processed in this time unit a █ gets added.

        # Add symbols to all processes which are not processed in this iteration
        for p2 in "${process_nums[@]}"
        do
            ct=$((${tat[$p2]}+${at[$p2]})) # Calculate completion time
            # Add a ▒ if the process already arrived in the queue and is not finished.
            if [[ $p2 != $p ]] && [[ ${at[$p2]} -lt $ticker ]] && [[ $ct -ge $ticker ]]
            then
                output_data[$p2]=${output_data[$p2]}'▒' # On every other processe's line a ░ gets added.
            elif [[ $p2 != $p ]]
                then
                output_data[$p2]=${output_data[$p2]}'░' # Add ░ if process did not arrive
            fi
        done
    fi
done


echo_n (){
    # Just a quick function to get n empty lines just pass as  " echo_n 12 " to print 12 empty lines.
    for i in $(seq 1 $1)
    do
        echo
    done
}
# OUTPUT

n_out=${#process_flow[@]} # The length of the process simulation
let n_remove=91-$n_out # 91 is the lentgh of the full time line and we want to remove the extending part.
full_line="     1••••••••10••••••••20••••••••30••••••••40••••••••50••••••••60••••••••70••••••••80••••••••90"

# Remove from the full line everything that extends the length of the process simulation 
time_line=${full_line::${#full_line}-n_remove}

echo_n 5  # Make some space.
echo Gantt Chart of $algorithm  # Diagramm Title with name of the chosen algorithm.
echo_n 2
echo "$time_line"
len_out_data=${#output_data[@]}
let x=$len_out_data-1
for i in $(seq 0 $x)
do 
    echo "${output_data[$i]}"  # Print every processe's output line.
done
echo "$time_line"
echo_n 5




