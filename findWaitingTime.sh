# !/bin/bash

function findWaitingTime() {

	declare -a service_time=( $(for i in $(seq 1 $1); do echo 0; done) )

	declare -a wt=( $(for i in $(seq 1 $1); do echo 0; done) )
	declare -a bt=( 5 3 8 6 )
	declare -a at=( 0 1 2 3 )

	# service_time[0] is always 0, because there is no previous process (executing). Same applies for wt[0], there 
    # is no waiting time
	service_time[0]=0
    wt[0]=0


    # calculating waiting time, iterate through processes. We start at 1 because we don't need to calculate the 
    # service time for process[0], because there is no service time
    n_minus_1=$(($1-1))
    for i in $(seq 1 $n_minus_1)
    do
    	# Add burst time of previous processes  
    	service_time[$i]=$((service_time[$i-1] + bt[$i-1]))

    	# Find waiting time for current 
    	# process = sum - at[i]
    	wt[$i]=$((service_time[$i]-at[$i]))

    	# If waiting time for a process is in  
        # negative that means it is already  
        # in the ready queue before CPU becomes  
        # idle so its waiting time is 0  
        if (( wt[$i] < 0 ))
        then
            wt[$i]=0
        fi

    done

    echo "${service_time[@]}"
    echo "${wt[@]}"
    

}

findWaitingTime 4 

