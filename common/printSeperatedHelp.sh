#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script prints all information about the choosen param2 options.                #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

case "$2" in
      
      --resume)
          echo ""
          echo "--resume"
          echo ""
          echo "The resume option loads the processes of the last session."
          echo ""
          echo ""
           exit 0
           ;;

      --HRRN)

          echo ""
          echo "Highest Response Ratio Next (HRRN)"
          echo ""
          echo "HRRN is a non-preemptive scheduling algorithm that always "
          echo "assigns the process with the highest response ratio to the "
          echo "processor. The processor executes the process until the "
          echo "process does not have any Burst Time left. The quotient is"
          echo "calculated as follows:"
          echo ""
          echo "      ResponseRatio = (Waiting Time / Burst Time) + 1"
          echo ""
          echo ""
           exit 0
           ;;

      --FCFS) 
          echo ""
          echo "First Come First Served (FCFS)"
          echo ""
      	  echo "FCFS is a non-preemptive scheduling algorithm. FCFS simply "
          echo "queues processes in the order that they arrive in the ready "
      	  echo "queue. The process that comes first will be executed first"
      	  echo "and the next process only starts after the previous process  "
          echo "was finished."
          echo ""
          echo ""
          exit 0
          ;;

      --RoundRobin) 
          echo ""
          echo "Round Robin"
          echo ""
      	  echo "Round Robin is a preemptive scheduling algorithm. That means"
      	  echo "that the processor allocates its ressources for a limited "
      	  echo "amount of time to one process before it switches to another"
      	  echo "process. If the already executed process still has remaining "
      	  echo "Burst Time, then the process is placed back in the ready "
      	  echo "queue. That process stays in the ready queue till it gets  "
      	  echo "next chance to execute. You can adjust the amount of time"
      	  echo "the Process Scheduling Simulator executes a process by  "
      	  echo "increasing or decreasing the time slice (time quantum)."
          echo ""
          echo ""
          exit 0
          ;;

      --chart) 
          echo ""
          echo "Example Gantt Chart of FCFS

     1••••••••10••••••••20
A    ░░░▒▒███░░░░░░░░░░░░
B    ░░░░░▒▒▒█████░░░░░░░
C    ░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒█
D    ░░███░░░░░░░░░░░░░░░
E    ░░░░░░▒▒▒▒▒▒▒██████░
     1••••••••10••••••••20
"
          echo ""
          echo "  ░: Process not in queue or already executed."
          echo "  ▒: Process in queue ('Waiting') but not executed."
          echo "  █: Process executed."
          echo ""
          echo "Timeline: Each dot represents one 'time unit'."
          echo ""
          exit 0
          ;;

      *)  # No more options
          break
          ;;
    esac