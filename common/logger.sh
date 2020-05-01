#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script is used to log important data in an external file for debugging.        #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

thisLogfileName=_ProcessScheduler.log

create_logfile() {
  if [ ! -d $1 ]; then
    mkdir $1
  fi
  touch ${logFileName}_${thisLogfileName}
}