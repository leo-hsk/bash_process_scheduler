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
create_logfile ${logFilePath}

echo "############################################################"
echo "#              Process Scheduling Simulator                #"
echo "############################################################"