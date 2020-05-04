#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script provides functions to create a process log file, read it and set it.    #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

export processSchedulerWorkingDir=$(pwd)
processesFilePath=${releaseCreatorWorkingDir}/.processes.log

function setProcesses() {
	touch .processes.log
	######## Needs to be implemented
	# Create hidden file
	# save processes into the file (name, waiting time, burst time, maybe no of processes?)

}

function getProcesses() {
	echo
	######## Needs to be implemented
	# read data from file
	# add data to arrays
}

function remProcesses() {
	rm -f ${processesFilePath}
}

function checkIfProcessesExist() {
	if [ -f "$processesFilepath" ]
	then
    	echo 1
	fi

}

setProcesses 1