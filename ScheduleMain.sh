#!/bin/bash



printf "\n Welcome to Project Scheduler SoSe 2020 - Engineering Business Information Systems.\n\n"
printf "######\n"

printf "Please choose one of the following Options:\n\n"
printf "1. Go to Simulations\n"
printf "2. Get a Overview about the features\n"
printf "3. Check Documentation and Help\n"
printf "4. Exit this Program\n"

echo "Please take one of the 4 Options and press Enter."
read menu
if [[ $menue -lt 4 ]]; then
	. ./start_screen.sh
fi

