############ input

# Max no. of gantt chart characters
max_no=75

# No. of (sample) processes
n=5

declare -a process_names=( A B C D E )

# List of process IDs
declare -a process_IDs=( 0 1 2 3 4 )

# List of burst time
declare -a bt=( 3 5 1 3 6)

# Arrival Time
declare -a at=( 3 0 7 2 6 )


#output of the "function"
declare -a process_flow=()



# Return idex of the smallest value in the arrival array
function findSmallest(){
	smallest=0

	let len=${#at[*]}-1

	for i in $(seq 0 $len)
	do
		if [[ $((at[$i])) -eq -1 ]]
		then
			continue
		else
    		if [[ $((at[$i])) -lt $((at[$smallest])) ]]
     		then
        		smallest=$i
     		fi
     	fi
done
# index
echo $smallest

}




clock=0

while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]
do
	
	id=$(findSmallest)
	let tmp=${at[$id]}-$clock

	if [[ $tmp -le 0 ]]
	then
		service_units=${bt[$id]}

		for burst in $(seq 1 $service_units)
		do
			process_flow+=$id" "
		done

		clock=$(($clock+$service_units))
		bt[$id]=0
		at[$id]=$(($max_no+1)) # IMPORTANT To Do: the algorithm is only working if the arrival time is set to high number.

	else
		process_flow+=-1" "
		clock=$(($clock+1))
	fi
done

echo ${process_flow[@]}
