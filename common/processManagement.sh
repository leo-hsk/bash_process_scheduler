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
	echo "n=$n" >> .processes.log
	echo "export process_names=( ${process_names[@]} )" >> .processes.log
	echo "export arrival_time=( ${arrival_time[@]} )" >> .processes.log
	echo "export burst_time=( ${burst_time[@]} )" >> .processes.log
	echo "export process_IDs=( ${process_IDs[@]} )" >> .processes.log

}

function loadProcesses() {
	source ${processSchedulerWorkingDir}/.processes.log
}

function remProcesses() {
	rm -f .processes.log
}

function checkIfProcessesExist() {
	if [ -f ".processes.log" ]
	then
    	echo 1
    else
    	echo 0
	fi

}