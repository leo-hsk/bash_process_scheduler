# !/bin/bash

declare -a wt=( $(for i in $(seq 1 $1); do echo 0; done) )


function findWaitingTime() {

	declare -a service_time=( $(for i in $(seq 1 $1); do echo 0; done) )
	

	for ((i = 0; i < ${#service_time[@]}; i++));
	do
		echo "${service_time[$i]}";
	done
}

findWaitingTime 4