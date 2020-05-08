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

thisLogfileName=ProcessScheduler.log

create_logfile() {
  if [ ! -d $1 ]; then
    mkdir $1
  fi
  touch ${logFileName}_${thisLogfileName}
}

log_info() {
  printf "%s\r\n" "${1}" | tee -a ${logFileName}_${thisLogfileName}
}

log_error() {
  printf "ERROR: %s\r\n" "${1}" | tee -a ${logFileName}_${thisLogfileName}
}

log_file() {
  printf "%s\r\n" "${1}" >> ${logFileName}_${thisLogfileName}
}