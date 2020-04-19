#! /bin/bash

# Create some samples here that will later be replaced by the real output from the Algorithms
process_names=(A B C D E F G)

process_flow=( 0 0 0 0 0 0 0 0 0 0 0 0 0 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 5 5 5 5 5 5 5 3 3 3 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 4 4 6 6 6 6 6 6 6 6)


declare -a process_nums
declare -a output_data

len_names=${#process_names[@]}

# For every name in the process names we want a number in process nums, satrting with 1:
let x=$len_names-1
echo $x
for i in $(seq 0 $x)
do 
    process_nums[$i]=$i
    output_data[$i]=${process_names[$i]}'    '
done

#echo ${process_nums[*]}
echo ${output_data[*]}





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


echo  
echo  
echo '      1••••••••10••••••••20••••••••30••••••••40••••••••50••••••••60••••••••70••••••••80••••••••90'
echo ${output_data[0]}
echo ${output_data[1]}
echo ${output_data[2]}
echo ${output_data[3]}
echo ${output_data[4]}
echo ${output_data[5]}
echo ${output_data[6]}
echo '      1••••••••10••••••••20••••••••30••••••••40••••••••50••••••••60••••••••70••••••••80••••••••90'





