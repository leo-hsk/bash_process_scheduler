#! /bin/bash

# Create some samples here that will later be replaced by the real output from the Algorithms

process_names=(0 1 2 3 4 5 6)
process_flow=( 0 0 0 0 0 0 0 0 0 0 0 0 0 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 5 5 5 5 5 5 5 3 3 3 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 4 4 6 6 6 6 6 6 6 6)

output_data=( 'A    ' 'B     ' 'C     ' 'D     ' 'E     ' 'F     ' 'G     ' )



# Create the actual chart:
for p in "${process_flow[@]}"
do
    output_data[$p]=${output_data[$p]}'█'
    for p2 in "${process_names[@]}"
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





