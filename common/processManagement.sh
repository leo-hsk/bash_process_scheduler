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

setProcesses() {
	######## Needs to be implemented
}

getProcesses() {
	######## Needs to be implemented
}

remProcesses() {
  rm -f ${processesFilePath}
}