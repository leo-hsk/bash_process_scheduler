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
          # give first parameter to used script
          echo "run the progamm with the last given paramters"
           exit 0
           ;;

      --HRRN)
          # give second parameter to used script
          echo ""
          echo "###############################################################"
          echo "#          HRRN algorithm overview and  function              #"
          echo "###############################################################"
          echo ""
          echo "Given n processes with their Arrival times and Burst times," 
          echo "the task is to find average waiting time and average turn around"
          echo "time using HRRN scheduling algorithm. The name itself states that"
          echo "need to find the response ratio of all available processes and"
          echo "select the one with the highest Response Ratio. A process once "
          echo "selected will run till completion."
           exit 0
           ;;

      --FCFS) 
      # explain 
          echo ""
          echo "###############################################################"
          echo "#          FCFS algorithm overview and  function              #"
          echo "###############################################################"
          echo ""
      	  echo "Given n processes with their burst times, the task is to find"
      	  echo "average waiting time and average turn around time using FCFS "
      	  echo "scheduling algorithm. First in, first out (FIFO), also known as "
      	  echo "first come, first served (FCFS), is the simplest scheduling "
      	  echo "algorithm. FIFO simply queues processes in the order that they  "
      	  echo "arrive in the ready queue. In this, the process that comes first "
      	  echo "will be executed first and next process starts only after the "
          echo "previous gets fully executed. Here we are considering that  "
          echo "arrival time for all processes is 0."
          exit 0
          ;;

      --RoundRobin) 
      # explain
          echo ""
          echo "###############################################################"
          echo "#         RoundRobin algorithm overview and  function         #"
          echo "###############################################################"
          echo ""
      	  echo "is one of the algorithms employed by process and network "
      	  echo "schedulers in computing. As the term is generally used, time  "
      	  echo "slices (also known as time quanta) are assigned to each process "
      	  echo "in equal portions and in circular order, handling all processes  "
      	  echo "without priority (also known as cyclic executive). Round-robin  "
      	  echo "scheduling is simple, easy to implement, and starvation-free.  "
      	  echo "Round-robin scheduling can be applied to other scheduling  "
      	  echo "problems, such as data packet scheduling in computer networks. "
      	  echo "It is an operating system concept."
          exit 0
          ;;

      --chart) 
      # explain
          echo ""
          echo "###############################################################"
          echo "#         RoundRobin algorithm overview and  function         #"
          echo "###############################################################"
          echo ""
          echo "is one of the algorithms employed by process and network "
          echo "schedulers in computing. As the term is generally used, time  "
          echo "slices (also known as time quanta) are assigned to each process "
          echo "in equal portions and in circular order, handling all processes  "
          echo "without priority (also known as cyclic executive). Round-robin  "
          echo "scheduling is simple, easy to implement, and starvation-free.  "
          echo "Round-robin scheduling can be applied to other scheduling  "
          echo "problems, such as data packet scheduling in computer networks. "
          echo "It is an operating system concept."
          exit 0
          ;;


      --*)
          echo "Error: Unknown option: $1" >&2
          ## or call function display_help
          exit 1 
          ;;
      *)  # No more options
          break
          ;;
    esac