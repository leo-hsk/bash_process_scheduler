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
# create_logfile ${logFilePath} # Uncomment if implemented 

echo "############################################################"
echo "#              Process Scheduling Simulator                #"
echo "############################################################"


#Print usage if param1 is not a valid value
if [[ $1 != "" ]]
then
  if ( [ $1 = "--help" ] ||  [ $1 != "--resume" ] )
  then
    echo "Print HELP here"
    exit 0
  fi
fi


isExit=3
# Main programm loop
while [[ $isExit -ne 1 ]]
do

	if [[ $1  = "--resume" ]]
	then
		# Have a look into the processManagement file
		echo "checkiffileexists"
		echo "load arrays"
		
		set -- "" # change command line parameter to ""

	else
		# Code is not clean.
		source ${processSchedulerWorkingDir}/EverythingNotFinished/start_screen.sh
	fi

	
	source ${processSchedulerWorkingDir}/common/createProcessOverview.sh
	printf "\n"
	${processSchedulerWorkingDir}/common/sleep.sh 15
	printf "\n"


	while [[ $isExit -ne 1 ]]
	do
		${processSchedulerWorkingDir}/common/chooseAlgorithm.sh

		if [ $? = "FCFS" ]
		then
			echo "FCFS"

		elif [ $? = "HRRN" ]
		then
			echo "HRRN" 
		elif [ $? = "RoundRobin" ]
		then
			echo "RoundRobin"
		fi

		echo "createChart"
		${processSchedulerWorkingDir}/common/calcAvgWaitingTurnaroundTime.sh
		printf "\n"

		echo "what do u wanna do?"
		source ${processSchedulerWorkingDir}/common/chooseNextOperation.sh
	done

	#isExit=$(($isExit-1))
	#isExit=1
done