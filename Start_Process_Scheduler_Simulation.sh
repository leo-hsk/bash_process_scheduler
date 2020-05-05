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

# Configure logging unit
logFileName=${processSchedulerWorkingDir}/_log_/$(date +"%Y-%m-%d")_$(date +"%H-%M-%S")_VERSION=${version}
create_logfile ${logFilePath} # Uncomment if implemented 

log_info "############################################################"
log_info "#              Process Scheduling Simulator                #"
log_info "############################################################"


#Print usage if param1 is not a valid value
if [[ $1 != "" ]]
then
  if ( [ $1 = "--help" ] ||  [ $1 != "--resume" ] )
  then
    echo "Print HELP here"
    exit 0
  fi
fi


# Main programm loop
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
		source ${processSchedulerWorkingDir}/EverythingNotFinished/start_screen.sh
	fi

	source ${processSchedulerWorkingDir}/common/createProcessOverview.sh
	printf "\n"
	${processSchedulerWorkingDir}/common/sleep.sh 15
	printf "\n"

    declare -a process_flow=()
    
	while [[ $isExit -ne 1 ]]
	do
		source ${processSchedulerWorkingDir}/common/chooseAlgorithm.sh
        
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
        
        echo 'process_flow' ${process_flow[@]}
		echo "createChart"
		${processSchedulerWorkingDir}/common/calcAvgWaitingTurnaroundTime.sh
		printf "\n"

		echo "what do u wanna do?"
		source ${processSchedulerWorkingDir}/common/chooseNextOperation.sh
	done

	#isExit=$(($isExit-1))
	#isExit=1
done
