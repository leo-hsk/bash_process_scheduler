# !/bin/bash

############# Should be implented as keyboard inputs ############
#
#

# No. of processes
n=4

# Names of the processes
declare -a processes=( 1 2 3 4 )

# Burst Time
declare -a bt=( 5 3 8 6 )

# Arrival Time
declare -a at=( 0 1 2 3 )


#
#
#############

# Declaring arrays for storing the waiting time and the turnaround time
declare -a wt=( $(for i in $(seq 1 $n); do echo 0; done) )
declare -a tat=( $(for i in $(seq 1 $n); do echo 0; done) )



############# Finding the waiting time of all processes

declare -a service_time=( $(for i in $(seq 1 $n); do echo 0; done) )

# service_time[0] is always 0, because there is no previous process (executing). Same applies for wt[0], there 
# is no waiting time
service_time[0]=0
wt[0]=0


# calculating waiting time, iterate through processes. We start at 1 because we don't need to calculate the 
# service time for process[0], because there is no service time
n_minus_1=$(($n-1))
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

# Just for controlling
# echo "service_time:    ""${service_time[@]}"
# echo "waiting_time:    ""${wt[@]}"




############# Getting the Turnaround Time for all processes


# Calculating turnaround time by 
# adding bt[i] + wt[i]

for i in $(seq 0 $n_minus_1)
do
    tat[$i]=$((bt[$i]+wt[$i]))
done

# Just for controlling  
#echo "turnaround_time: ""${tat[@]}"
#printf "\n\n"


############# Display processes along with all details

total_wt=0
total_tat=0

printf "Processes   Burst Time   Arrival Time     Waiting Time   Turn-Around Time  Completion Time\n\n" 

for i in $(seq 0 $n_minus_1)
do
	total_wt=$((total_wt+wt[$i]))
	total_tat=$((total_tat+tat[$i]))
	compl_time=$((tat[$i]+at[$i]))

	printf "%5s  %10s  %12s  %16s  %16s  %14s" "${processes[$i]}" "${bt[$i]}" "${at[$i]}" "${wt[$i]}" "${tat[$i]}" "$compl_time"
	printf "\n"
done 


# Using awk to calculate the floating points, because there are no floating points in bash
printf "\nAverage waiting time = "
awk "BEGIN {print $total_wt/$n}"
printf "\nAverage turn around time = "
awk "BEGIN {print $total_tat/$n}"


