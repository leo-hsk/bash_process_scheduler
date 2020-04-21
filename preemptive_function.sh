

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

# Initialize output with -1 values

declare -a output=( $(for i in $(seq 1 $max_no); do echo -1; done) )




########## FCFS

# timestamp to increase the iterator "i"
timestamp=0

## Iterate through each process ID (increasing number from 0 to n)
for id in ${process_IDs[@]}
do
	
	# Length of the burst time of the process
	burst_length=$((bt[$id])) 

	## Iterate through the burst time and set an element of the output to the process ID
	for i in $(seq 0 $burst_length)
	do
		# Controlling
		#echo $id

		output[$(($i+$timestamp))]=$id

	done

	# Adding the process ID (no. of process) to the timestamp
	timestamp=$(($timestamp+$i))


	# Controlling
	#echo "-----------"
	#echo $timestamp
	#echo "-----------"
	
done

## Shorten the output by deleting the -1 values if there are any left.




echo ${output[@]}


