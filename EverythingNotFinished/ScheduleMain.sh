#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script imports all required information to run scripts.                        #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################


# The command line help is set here

display_help() {
    echo "Usage: $0  "--" {help|resume}" >&2
    echo
    echo "#############################################################################################"
	echo "#                                                                                           #"
	echo "# This helpfile shoukd give you all information to use this script                          #"
	echo "# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #"
	echo "#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #"
	echo "#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #"
	echo "#                                                                                           #"
	echo "# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #"
	echo "#                                                                                           #"
	echo "#############################################################################################"
	echo
    echo "   -h, --help                run help for the given script"
    echo "   -r --resume 			   resume with last given Parameters"
    echo "   -h HRRN --help HRRN       run help for HRRN Algorithm"
    echo "   -h FCFS --help FCFS       run help for FCFS Algorithm"                        
    echo "   -h rRobin --help rRobin      run help for Round Robin Algorithm"
    echo "   -h HRRN --help HRRN       run help for HRRN Algorithm"
   
    exit 1
}

display_help_hrrn() {
    echo "Usage: $0  "--" {help|resume}" >&2
    echo
    echo "#############################################################################################"
	echo "#                                                                                           #"
	echo "# This helpfile shoukd give you all information to use this script                          #"
	echo "# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #"
	echo "#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #"
	echo "#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #"
	echo "#                                                                                           #"
	echo "# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #"
	echo "#                                                                                           #"
	echo "#############################################################################################"
	echo
    echo "   -h, --help                run help for the given script"
    echo "   -r --resume 			   resume with last given Parameters"
    echo "   -h HRRN --help HRRN       run help for HRRN Algorithm"
    echo "   -h FCFS --help FCFS       run help for FCFS Algorithm"                        
    echo "   -h rRobin --help rRobin      run help for Round Robin Algorithm"
    echo "   -h HRRN --help HRRN       run help for HRRN Algorithm"
   
    exit 1
}

# loop for program parameters
while :
do
    case "$1" in
      
      -h | --help)
          display_help  # Call your function
          exit 0
          ;;
      -r | --resume)
          # give first parameter to used script
           exit 0
           ;;

      -h_HRRN | --help_HRRN)
          # give second parameter to used script
          display_help_hrrn
           exit 0
           ;;

      -h_FCFS |--help_FCFS) 
      # explain 
      	echo "Find another cool Stuff for FCFS here"
          exit 0
          ;;

          -h_rRobin |--help_rRobin) 
      # explain
      	echo "Find another cool Stuff for Round Robin here"
          exit 0
          ;;


      -* | --*)
          echo "Error: Unknown option: $1" >&2
          ## or call function display_help
          exit 1 
          ;;
      *)  # No more options
          break
          ;;
    esac
done

echo "\n Welcome to Project Scheduler SoSe 2020 - Engineering Business Information Systems.\n"
echo "......................................................................................\n"

echo "Please choose one of the following Options:\n\n"
echo "1. Go to Simulations"
echo "2. Get a Overview about the features"
echo "3. Run FCFS Scheduling"
echo "4. Run Round Robin Scheduling"
echo "5. Show Gant Chart"
echo "6. Leave this Menue"

echo "Please take one of the given Options and press Enter."
read choise

case "$choise" in
	1)
	. ./start_screen.sh
	;;
		2)
	 	cat ./manpage.txt
	 	;;
	 		3)
			. ./FCFS.sh
			;;
				4)
				. ./RoundRobin.sh
				;;
					5)
					. ./CreateChart.sh
					;;
						6)
						Exit
						;;
					esac

echo "\n\n Would you like to pick another Testrun ? (Y/N) \n"
read yesno
case "$yesno" in
	y*|Y*)
		. ./ScheduleMain.sh
		;;
			n*|N*)
			echo "Goodbye"
			Exit 
		esac



