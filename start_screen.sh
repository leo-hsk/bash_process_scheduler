# !/bin/bash


########## Declaring global variables

version="0.001 alpha"

# No. of (sample) processes
n=5

# List of process names
declare -a process_names=( 1 2 3 4 5 )

# List of burst time
declare -a bt=( 5 3 8 6 7 )

# Arrival Time
declare -a at=( 0 1 2 3 5 )

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

	## changing the no. of elements in each array to the choosen number n
	declare -a process_names=( $(for i in $(seq 1 $n); do echo 0; done) )
	declare -a bt=( $(for i in $(seq 1 $n); do echo 0; done) )
	declare -a at=( $(for i in $(seq 1 $n); do echo 0; done) )

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