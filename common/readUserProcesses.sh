#!/bin/bash

#############################################################################################
#                                                                                           #
# The user can choose process parameters.                                                   #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

echo "Do you want to use sample processes? (Y|N)"
read -p "--> " -n 1 -r 
echo   " " # (optional) move to a new line

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
	
	printf "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	clear -x
	## Choose no. of processes
	printf "\nEnter the number of processes you want to create. \n"
	read -p "--> " n 
	# Check if input is integer and NOT zero
	while ([[ $n -gt 25 ]] || [[ $n -lt 1 ]])
	do
       	printf "${red}Sorry integers > 0 and < 25 only${endRed}\n"
       	printf "\nEnter the number of processes you want to create. \n"
       	read -p "--> " n
	done

	## Empty arrays
	export process_names=( )
	export process_IDs=( $(seq 0 1 $((n-1))) )
	export burst_time=( )
	export arrival_time=( )

	export tat=( $(for i in $(seq 1 $n); do echo 0; done) )
	export wt=( $(for i in $(seq 1 $n); do echo 0; done) )

	### declare each process
	for i in $(seq 0 $(($n-1)))
	do
		## Get the name
		printf "\nEnter the name of process number $(($i+1)).\n"
		read -p "--> " tmp
		process_names[$i]=$tmp

		## Get the arrival time
		printf "\nEnter the arrival time of process number $(($i+1)).\n"
		read -p "--> " tmp

		while ! [[ "$tmp" =~ ^[0-9]+$ ]]
		do
       		printf "${red}Sorry integers only${endRed}\n"
       		printf "Enter the arrival time of process number $(($i+1)).\n"
       		read -p "--> " tmp
		done
		arrival_time[$i]=$tmp

		## Get the burst time
		printf "\nEnter the burst time of process number $(($i+1)).\n"
		read -p "--> " tmp

		while ! [[ "$tmp" =~ ^[0-9]+$ ]]
		do
       		printf "${red}Sorry integers only${endRed}\n"
       		printf "Enter the burst time of process number $(($i+1)).\n"
       		read -p "--> " tmp
		done
		burst_time[$i]=$tmp

	done

	remProcesses
	setProcesses

else
	source ${processSchedulerWorkingDir}/common/importHeader.sh  	# Neccessary to load sample processes if already loaded own processes
fi


