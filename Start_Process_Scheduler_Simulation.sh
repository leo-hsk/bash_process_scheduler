#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script controls the Process Scheduler Simulation.                              #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

# Export working directory
export processSchedulerWorkingDir=$(pwd)

# Import configuration
source ${processSchedulerWorkingDir}/common/importHeader.sh

# Import functions
source ${processSchedulerWorkingDir}/common/copyArrays.sh


# Configure logging unit
logFileName=${processSchedulerWorkingDir}/_log_/$(date +"%Y-%m-%d")_$(date +"%H-%M-%S")_VERSION=${version}
create_logfile ${logFilePath} # Uncomment if implemented 

log_info "############################################################"
log_info "#              Process Scheduling Simulator                #"
log_info "############################################################"


#Print usage if param1 is not a valid value
if [[ $1 != "" ]] && [[ $2 = "" ]]
then
	if ( [ $1 = "--help" ] || ( [ $1 != "--resume" ] ) )
	then
    	source ${processSchedulerWorkingDir}/common/printHelp.sh
    	exit 0
  	fi
fi

#Print valid parameters if param1 is "--help" and param2 is invalid
if [[ $1 = "--help" ]]
then
	for param2 in ${validParam2[@]}
 	do
 		if [ $2 = $param2 ]
   		then
 			source ${processSchedulerWorkingDir}/common/printSeperatedHelp.sh
 			exit 0 
   		fi
 	done 
	echo ""
    echo "No valid parameter 2 given."
    echo "Valid parameters are:"
    echo ""
    source ${processSchedulerWorkingDir}/common/printValidParam2.sh
    echo ""
    echo ""
    exit 0
fi

echo ""
echo "This bash script simulates the scheduling of processes in a"
echo "single processor system using First Come First Serve (FCFS),"
echo "Highest Response Ratio Next (HRRN) or Round Robin scheduling"
echo "algorithm."
echo ""
echo "The program was developed as part of the examination for the"
echo "'Operating Systems and Computer Networks' module of the EBIS"
echo "(Engineering Business Information Systems) degree program at"
echo "Frankfurt University of Applied Sciences in 2020."
echo ""
echo "Running version: "${version}
echo ""
echo "Contributors:"
echo "   -Anton Roesler"
echo "   -Leonard Husske"
echo "   -Patrick Frech"
echo ""
echo ""

# Main program loop
while [[ $isExit -ne 1 ]]
do

	source ${processSchedulerWorkingDir}/common/processManagement.sh

	if [[ $1  = "--resume" ]]
	then
		
		if [[ $(checkIfProcessesExist) -eq 1 ]]
		then
			loadProcesses
			log_file "Loading processess successful."
			set -- "" # change command line parameter from "--resume" to ""
		else
			log_error "processManagement.sh checkIfProcessesExist failed."
			log_error "Process stopped."
    		exit 0
		fi
		
		

	else
		# Code is not clean.
		source ${processSchedulerWorkingDir}/common/readUserProcesses.sh
	fi

	source ${processSchedulerWorkingDir}/common/createProcessOverview.sh
	echo ""
	${processSchedulerWorkingDir}/common/sleep.sh 25

    
	while [[ $isExit -ne 1 ]]
	do
		echo ""
		echo ""
		log_info "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		source ${processSchedulerWorkingDir}/common/chooseAlgorithm.sh
        resetArrays
        #echo bt ${bt[@]}
        #echo wt ${wt[@]}
        
		if [ $algo_choice = "FCFS" ]
		then
            source ${processSchedulerWorkingDir}/FCFS/Run_FCFS.sh

		elif [ $algo_choice = "HRRN" ]
		then
            source ${processSchedulerWorkingDir}/HRRN/Run_HRRN.sh
   
		elif [ $algo_choice = "RoundRobin" ]
		then
            source ${processSchedulerWorkingDir}/ROUNDROBIN/Run_RoundRobin.sh
		fi
        
        #echo 'process_flow' ${process_flow[@]}
		source ${processSchedulerWorkingDir}/common/createChart.sh
		source ${processSchedulerWorkingDir}/common/calcAvgWaitingTurnaroundTime.sh
        echo
        echo
		source ${processSchedulerWorkingDir}/common/endOverview.sh

		echo ""
		echo ""
		log_info "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		echo ""
		source ${processSchedulerWorkingDir}/common/chooseNextOperation.sh
	done
done