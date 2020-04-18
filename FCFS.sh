# !/bin/bash

declare -a wt=( $(for i in $(seq 1 $1); do echo 0; done) )
declare -a bt=( 5 3 8 6 )


function findWaitingTime() {

	declare -a service_time=( $(for i in $(seq 1 $1); do echo 0; done) )
	

	# service_time[0] is always 0, because there is no previous process (executing). Same applies for wt[0], there 
    # is no waiting time
	service_time[0]=0
    wt[0]=0

    a=$3
    echo $a

    # calculating waiting time, iterate through processes. We start at 1 because we don't need to calculate the 
    # service time for process[0], because there is no service time
    n_minus_1=$(($1-1))
    for i in $(seq 1 $n_minus_1)
    do
    	# Add burst time of previous processes  
    	#service_time[$i]=$((service_time[$i] + $3[$i]))
    	echo "${service_time[$i]}";
    	#echo "$i"
    done

}

findWaitingTime 4 "$(echo ${wt[@]})" "$(echo ${bt[@]})"