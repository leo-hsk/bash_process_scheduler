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

processesFilePath=${releaseCreatorWorkingDir}/.processes.log

function setProcesses() {
	######## Needs to be implemented
	# Create hidden file
	# save processes into the file (name, waiting time, burst time, maybe no of processes?)

}

function getProcesses() {
	######## Needs to be implemented
	# read data from file
	# add data to arrays
}

function remProcesses() {
  rm -f ${processesFilePath}
}

function checkIfProcessesExist() {
	######## Needs to be implemented
	# Check if file exists
	# If not: print message that there are no saved processses and exit script

}