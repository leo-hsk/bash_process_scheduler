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
	# Start with index 0
	smallest=0

	# Get length -1 of the arrival time array
	let len=${#at[*]}-1

	# Iterate through each arrival time element
	for i in $(seq 0 $len)
	do
		# If the element is -1, ignore it
		if [[ $((at[$i])) -eq -1 ]]
		then
			continue
		else
			# Check if the value of the arrival time element is less then the smallest (first) at this time
    		if [[ $((at[$i])) -lt $((at[$smallest])) ]]
     		then
     			# If yes, set the current index of the arrival time element to the smallest value
        		smallest=$i
     		fi
     	fi
done
# Return index of the smallest value
echo $smallest

}



# Track the no. of iterations
	clock=0

	# Loop until the sum of the burst time array is zero
	while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]
	do
		# Find index of the smallest arrival time
		id=$(findSmallest)
		let tmp=${at[$id]}-$clock

		if [[ $tmp -le 0 ]]
		then
			service_units=${bt[$id]}

			# Iterate through service_units ( Number of bursts)
			for burst in $(seq 1 $service_units)
			do
				# Add the id of the process to the process_flow array
				process_flow[$(($clock+$burst))]=$id
			done

			# Add the number of service units to the clock
			clock=$(($clock+$service_units))
			bt[$id]=0
			at[$id]=$(($max_no+1)) # IMPORTANT To Do: the algorithm is only working if the arrival time is set to high number.

		else
			# If there is no process ready to process, add -1 to the process flow array
			process_flow[$(($clock+1))]=-1
			clock=$(($clock+1))
		fi
	done

	echo ${process_flow[@]}