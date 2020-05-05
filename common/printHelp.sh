#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script prints all required information to run scripts.                        #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

echo ""
echo ""
echo "Usage: Start_Process_Scheduler_Simulation.sh [opt:param1] [opt:param2]"
echo ""
echo "param1 is optional and can be one of the described commands."
echo "param2 is only used with param1=help has to be a valid string."
echo ""
echo "--resume         - Starts the program with the processes from the last session."
echo "--help           - Prints out this help message."
echo "--help [param2]  - Starts the help with the given param2 for specific algorithm."
echo ""
echo "Valid param2's are: "
echo ""
${processSchedulerWorkingDir}/common/printValidParam2.sh
echo ""
echo ""