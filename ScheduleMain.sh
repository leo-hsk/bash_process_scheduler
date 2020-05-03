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
    echo "Usage: $0  "--" {help|parameters1|parameters2|and so on}" >&2
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
    echo "   -p1 					   give parameter 1"
    echo "   -p2                       give parameter 2"
    echo "   -aso                      give random stuff"
    echo
   
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
      -p1)
          # give first parameter to used script
           shift 2
           ;;

      -p2)
          # give second parameter to used script
           shift 2
           ;;

      --) # End of all options
          shift
          break
          ;;
      -*)
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



