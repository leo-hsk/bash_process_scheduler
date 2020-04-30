#!/bin/bash



echo "\n Welcome to Project Scheduler SoSe 2020 - Engineering Business Information Systems.\n"
echo "......................................................................................\n"

echo "Please choose one of the following Options:\n\n"
echo "1. Go to Simulations"
echo "2. Get a Overview about the features"
echo "3. Run FCFS Scheduling"
echo "4. Run Round Robin Scheduling"
echo "5. Show Gant Chart"
echo "6. Exit the Program"

echo "Please take one of the 5 Options and press Enter."
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



