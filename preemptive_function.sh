

############ input

# Max no. of gantt chart characters
max_no=75

# No. of (sample) processes
n=5

declare -a process_names=( 1 2 3 4 5 )

# List of process IDs
declare -a process_IDs=( 0 1 2 3 4 )

# List of burst time
declare -a bt=( 5 3 8 6 7 )

# Arrival Time
declare -a at=( 0 1 2 3 5 )


#output of the "function"
declare -a process_flow=()




########## FCFS

# timestamp to increase the iterator "i"
timestamp=0

## Iterate through each process ID (increasing number from 0 to n)
for id in ${process_IDs[@]}
do
		
	# Length of the burst time of the process
	burst_length=$((bt[$id])) 


	## Iterate through the burst time and add the process ID to the process_flow array
	for i in $(seq 0 $burst_length)
	do
		# Controlling
		#echo $id

		process_flow[$(($i+$timestamp))]=$id

		# Check if the output arrays elements are max_no, if yes, leave all loops. max_no is the max allowed number of characters
		if [ $(($i+$timestamp)) -ge $max_no ]
		then
			break 2 # break 2 loops
		fi


	done

	# Adding the process ID (no. of process) to the timestamp
	timestamp=$(($timestamp+$i))

	# Controlling
	#echo "-----------"
	#echo $timestamp
	#echo "-----------"
	
done


# Controlling
echo ${process_flow[@]}


