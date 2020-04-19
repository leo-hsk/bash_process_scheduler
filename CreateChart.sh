#! /bin/bash

# Create some samples here that will later be replaced by the real output from the Algorithms
process_names=(A B C D E F G)

# Wichtig: Ich gehe hier davon aus das jedem Prozess der Reihenfolge nach eine nummer gegeben wird.
# Also A -> 0, B -> 1, C -> 2 ... 
# Und das in der Simulation nicht die namen in die Output Liste geschreiben werden, sondern eben die Nummer:
# Die Output Liste sollte dann so aussehen:
process_flow=( 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 5 5 5 5 5 5 5 3 3 )


declare -a process_nums
declare -a output_data

len_names=${#process_names[@]}

# For every name in the process names we want a number in process nums, satrting with 1:
let x=$len_names-1
for i in $(seq 0 $x)
do 
    process_nums[$i]=$i
    output_data[$i]=${process_names[$i]}'    '
done

#echo ${process_nums[*]}
#echo ${output_data[*]}





# Create the actual chart:
for p in "${process_flow[@]}"
do
    output_data[$p]=${output_data[$p]}'█'
    for p2 in "${process_nums[@]}"
    do
        if [ $p2 != $p ]
        then
            output_data[$p2]=${output_data[$p2]}'▒'
        fi
    done
done



# OUTPUT

n_out=${#process_flow[@]}
echo $n_out
let n_remove=90-$n_out
full_line="      1••••••••10••••••••20••••••••30••••••••40••••••••50••••••••60••••••••70••••••••80••••••••90"

time_line=${full_line::${#full_line}-n_remove+1}
echo  
echo  
echo $time_line
len_out_data=${#output_data[@]}
let x=$len_out_data-1
for i in $(seq 0 $x)
do 
    echo ${output_data[$i]}
done
#echo $time_line





