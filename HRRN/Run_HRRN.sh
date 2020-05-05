#! /bin/bash


# One if process is waiting and zero if not
isWaiting=( $(for i in $(seq 1 $n); do echo 0; done) )

# Response Ratio
responseR=( $(for i in $(seq 1 $n); do echo 0; done) )

########################################################################


#output of the "function"
declare -a process_flow=()


############# FOR FINAL IMPLEMENTATION CHANGE TO:	source ${processSchedulerWorkingDir}/FCFS/xxxxxxxxxxx.sh
source ${processSchedulerWorkingDir}/HRRN/findHighestResponseRatio.sh
source ${processSchedulerWorkingDir}/HRRN/calcResponseRatio.sh
source ${processSchedulerWorkingDir}/common/getAllWaitingJobs.sh


# Track the no. of iterations
clock=0

# Loop until the sum of the burst time array is zero
while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]
do
    # Find index of the smallest arrival time
    calcResponseRatio
    id=$(findHighestResponseRatio)
    let tmp=${at[$id]}-$clock
    if [[ $tmp -le 0 ]]
    then
        service_units=${bt[$id]}

        # Iterate through service_units ( Number of bursts)
        for burst in $(seq 1 $service_units)
        do

            getAllWaitingJobs
            # Update waiting times each iteration for every process other than id
            for p in $(seq 0 $((${#isWaiting[@]}-1)))
            do
                if [[ $p -ne $id ]]
                then
                    wt[$p]=$((wt[$p]+isWaiting[$p]))
                fi
            done
            # Controlling
            # echo "wt" ${wt[@]}
            # echo $clock

            # Add the id of the process to the process_flow array
            process_flow[$(($clock))]=$id


            # Add the number of service units to the clock
            clock=$(($clock+1))
        done

        bt[$id]=0
        at[$id]=$(($max_no+1))

        # Calculate the turnaround time using the immutable arrival time array.
        tat[$id]=$(($clock-${arrival_time[$id]}))

    else
        # If there is no process ready to process, add -1 to the process flow array
        process_flow[$(($clock))]=-1
        clock=$(($clock+1))

    fi
done

#echo ${process_flow[@]}
#echo tat ${tat[@]}
#echo at ${at[@]}
	
