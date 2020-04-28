#! /bin/bash
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
declare -a at=( 3 5 7 2 6 )

# Waiting Time
declare -a wt=( $(for i in $(seq 1 $n); do echo 0; done) )

# One if process is waiting and zero if not
isWaiting=( $(for i in $(seq 1 $n); do echo 0; done) )

# Response Ratio
responseR=( $(for i in $(seq 1 $n); do echo 0; done) )


#output of the "function"
declare -a process_flow=()

function calcResponseRatio() {
	# Reset the isWaiting array to all zeros
	for p in ${process_IDs[@]}
	do
		# Calculate response ratio fo each process * 1000
		if [[ ${bt[$p]} -eq 0 ]]
		then
			responseR[$p]=0
		else
			rratio=$(bc <<< "scale=0;(${wt[$p]}+${bt[$p]})*1000/${bt[$p]}")
			responseR[$p]=$rratio
		fi
	done
}

# Return idex of the smallest value in the arrival array
function findHighestResponseRatio(){
	# Start with index 0

	highest=0

	# Iterate through each responseRatio element
	for i in ${process_IDs[@]}
	do
		if [[ ${at[$i]} -le $clock ]]
		then
		# If the element is -1, increase it by one
			if [[ $((at[$i])) -eq -1 ]]
			then
				highest=$(($highest+1))
			else
				# Check if the value of the response ratio element is more than the highest (first) at this time
	    		if [[ $((responseR[$i])) -ge $((responseR[$highest])) ]]
	     		then
	     			# If yes, set the current index of the response ratio element to the highest value
	        		highest=$i
	     		fi
	     	fi
	     fi
done
# Return index of the highest value
echo $highest

}

function getAllWaitingJobs() {

	# Reset the isWaiting array to all zeros
	for i in ${process_IDs[@]}
	do
		isWaiting[$i]=0
	done

	for p in ${process_IDs[@]}
	do
		if [[ $((at[$p]-$clock)) -le 0 ]]
		then
			isWaiting[$p]=1
		fi
	done
	# Controlling
	# echo "Finished" ${isWaiting[@]}

}





# Track the no. of iterations
	clock=0

	# Loop until the sum of the burst time array is zero
	while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]
	do
		# Find index of the smallest arrival time
		calcResponseRatio
		id=$(findHighestResponseRatio)
		echo ${responseR[@]}
		let tmp=${at[$id]}-$clock
		if [[ $tmp -le 0 ]]
		then
			service_units=${bt[$id]}

			# Iterate through service_units ( Number of bursts)
			for burst in $(seq 1 $service_units)
			do

				getAllWaitingJobs
				# Update waiting times each iteration for every process other than id
				for p in $(seq 0 $((${#isWaiting[@]}-1))) 
				do
					if [[ $p -ne $id ]]
					then
						wt[$p]=$((wt[$p]+isWaiting[$p]))
					fi
				done
				# Controlling
				# echo "wt" ${wt[@]}
				# echo $clock

				# Add the id of the process to the process_flow array
				process_flow[$(($clock))]=$id


				# Add the number of service units to the clock
				clock=$(($clock+1))
			done

			bt[$id]=0
			at[$id]=$(($max_no+1)) # IMPORTANT To Do: the algorithm is only working if the arrival time is set to high number.

		else
			# If there is no process ready to process, add -1 to the process flow array
			process_flow[$(($clock))]=-1
			clock=$(($clock+1))
			echo clock1

		fi
	done

	echo ${process_flow[@]}
	