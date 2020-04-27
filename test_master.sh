# !/bin/bash


########## Declaring global variables

version="0.001 alpha"

# No. of (sample) processes
n=5

# Max no. of gantt chart characters
max_no=75

# List of process names
declare -a process_names=( 1 2 3 4 5 )

# List of process IDs. The IDs represent the index of the process.
declare -a process_IDs=( 0 1 2 3 4 )

# List of burst time
declare -a bt=( 5 3 8 6 7 )

# Arrival Time
declare -a at=( 0 1 2 3 5 )

# Array to save the flow of the processes
process_flow=()

# error color
red=$'\e[1;31m'

# white color
end=$'\e[0m'


########## Starting text, version information, etc.

# Clear console but remain scrollback
clear -x
printf "Lorem ipsum dolor sit amet, consetetur sadipscing elitr,\nsed diam nonumy eirmod tempor invidunt ut labore et doloremagna aliquyam erat,\n sed diam voluptua. At vero eos et accusamet justo duo dolores et ea rebum. \nStet clita kasd gubergren.\n\n"


##########

read -p "Do you want to use sample processes? (Y|N)" -n 1 -r
echo   " " # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
	#### NO: Create new processes

	clear -x

	## Choose no. of processes
	printf "\nEnter the number of processes you want to create: "
	read n
	# Check if input is integer and NOT zero
	while ! [[ "$n" =~ ^[1-9]+$ ]]
	do
       	printf "${red}Sorry integers > 0 only${end}\n"
       	printf "\nEnter the number of processes you want to create: "
       	read n
	done

	## Empty all arrays
		
	declare -a process_names=( )
	declare -a process_IDs=( )
	declare -a bt=( )
	declare -a at=( )

	### declare each process
	for i in $(seq 0 $(($n-1)))
	do
		## Get the name
		printf "\nEnter the name of process number $(($i+1)): "
		read tmp

		# Assign input value to the array element
		process_names[$i]=$tmp


		## Get the arrival time
		printf "\nEnter the arrival time of process number $(($i+1)): "
		read tmp

		# Check if input is integer
		while ! [[ "$tmp" =~ ^[0-9]+$ ]]
		do
       		printf "${red}Sorry integers only${end}\n"
       		printf "Enter the arrival time of process number $(($i+1)): "
       		read tmp
		done

		# Assign input value to the array element
		at[$i]=$tmp


		## Get the burst time
		printf "\nEnter the burst time of process number $(($i+1)): "
		read tmp

		# Check if input is integer
		while ! [[ "$tmp" =~ ^[0-9]+$ ]]
		do
       		printf "${red}Sorry integers only${end}\n"
       		printf "Enter the burst time of process number $(($i+1)): "
       		read tmp
		done

		# Assign input value to the array element
		bt[$i]=$tmp
	done

	clear -x

	### Use processes
	printf "\n\nPROCESSES OVERVIEW\n\n"
	printf "Process   Arrival Time   Burst Time\n\n"
	for i in $(seq 0 $(($n-1)))
	do
		printf "%3s  %10s  %12s" "${process_names[$i]}" "${at[$i]}" "${bt[$i]}"
		printf "\n"

	done


else
	clear -x
	#### Yy: Use sample processes
	printf "\n\nSAMPLE PROCESSES OVERVIEW\n\n"
	printf "Process   Arrival Time   Burst Time\n\n"
	for i in $(seq 0 $(($n-1)))
	do
		printf "%3s  %10s  %12s" "${process_names[$i]}" "${at[$i]}" "${bt[$i]}"
		printf "\n"
	done
fi
######################################################




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


##############################


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

	#echo ${process_flow[@]}



###################################################




    algorithm="'First Come First Serve'"

    declare -a process_nums=( )
    declare -a output_data=( )

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



    # Create the actual chart:
    for p in "${process_flow[@]}"
    do
        if [[ $p == -1 ]]
        then 
            for p2 in "${process_nums[@]}"
            do
                output_data[$p2]=${output_data[$p2]}'░' # On every other processe's line a ░ gets added.
            done
        else

            output_data[$p]=${output_data[$p]}'█' # In the line of the process that gets processed in this time unit a █ gets added.
            for p2 in "${process_nums[@]}"
            do
                if [[ $p2 != $p ]]
                then
                    output_data[$p2]=${output_data[$p2]}'░' # On every other processe's line a ░ gets added.
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

