#!/bin/bash

############ input

# Max no. of gantt chart characters
max_no=75

# No. of (sample) processes
n=3

declare -a process_names=( A B C )

# List of process IDs
declare -a process_IDs=( 0 1 2 )

# List of burst time
declare -a bt=( 3 4 7 )

# Arrival Time
declare -a at=( 0 0 3 ) # Copy (mutable)
declare -a arrival_time=( 0 0 3 ) # Original (immutable)

# Waiting Time
declare -a wt=( $(for i in $(seq 1 $n); do echo 0; done) )

# One if process is waiting and zero if not
isWaiting=( $(for i in $(seq 1 $n); do echo 0; done) )

# Turnaround Time
declare -a tat=( $(for i in $(seq 1 $n); do echo 0; done) )

#output of the "function"
declare -a process_flow=()

declare -a queue=()


quantum=2

clock=0  # This is the simulations clock = passed time since start.


function isInOrder() {
    # If the passsed process is alredy in the queue return 1. If not return 0.
    for p2 in ${queue[@]}  # Loop all processes in queue.
    do 
        if [[ $p2 -eq $1 ]]  # If the one passed as an argument equals one of the ones inside queue.
        then
            return 1

        fi
    done
    # If no process in queue equaled the passed one:
    return 0
}

function makeOrder() {
    # This function updates the queue list. 
    for p in ${process_IDs[@]}  # Loop all processes there are.
    do 
        if [[ $p -ne $1 ]]  # One can pass a process_id as an argument and the one wont be put in queue.
        then
            isInOrder $p  # Check if the process is already in queue 1=YES, 0=NO.
            x=$?  # Store the 1 or 0 in x.
            if [[ ${at[$p]} -le $clock ]]  && [[ $x -eq 0 ]]  # Check if the process has already arrived. And is not already in queue.
            then
                queue+=($p)  # Only if the two conditions apply the process_id is added to tehe queue.
            fi
        fi



    done
}


function getNextInQueue(){
    # This function returns the next process_id in the queue and at the same time removes it from the queue.
    # If there is nothing in the queue it returns a 44 (44 because -1 does not work - turns it into a 255 wegen zweierkompliment - and 44 is ok because the max number of processes is 25 anyway.).
    if [[ ${#queue[@]} -gt 0 ]]
    then
        x=${queue[0]}
        queue=("${queue[@]:1}")
        return $x
    else
        return 44

    fi

}

function getAllWaitingJobs() {

    # Reset the isWaiting array to all zeros
    for i in ${process_IDs[@]}
    do
        isWaiting[$i]=0
    done

    for p in ${process_IDs[@]}
    do
        if [[ $((at[$p]-$clock)) -le 0 ]] && [[ ${bt[$p]} -gt 0 ]]
        then
            isWaiting[$p]=1
        fi
    done
    # Controlling
    # echo "Finished" ${isWaiting[@]}

}

makeOrder 44

while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]  # This summs up the whole burst time array, if EVERY process has a burst time of 0 we are done. As long as that is not the case, do all this again and agin:
do
    getNextInQueue  # Get the next process in queue by calling the function.
    id=$?  # Store the output inside the variable id.
    if [[ $id -ne 44 ]]  # The function returns a 44 in the case the queue is empty, meaning no process is waiting -> skip to else to increase clock by one.
    then 
        service_units=${bt[$id]}  # The Service time for round robin is the time slice / quantum but it might be the case that a processes as less than quantum units left.
        if [ $service_units -gt 0 ]  # If service units is greater then 0 -> continue. If it is 0 the process is already fully completed. 
        then
            if [ $service_units -gt $quantum ]  # In the likely case the service units are larger than the time quantum: reduce to quantum.
            then 
                service_units=$quantum  # If the Process has more than 3 (or whatever value quantum has) time units of service left, it gets shortend to the value of quantum. 
            fi 
            for i in $( seq 1 $service_units )  # Now do the following steps for *service_units* times.
                do

                    getAllWaitingJobs
                    # Update waiting times each iteration for every process other than id
                    for p in $(seq 0 $((${#isWaiting[@]}-1))) 
                    do
                        if [[ $p -ne $id ]]
                        then
                            wt[$p]=$((wt[$p]+isWaiting[$p]))
                            echo c $clock
                            echo p $p
                            echo wt ${wt[@]}
                            echo is ${isWaiting[$p]}
                            echo - - -
                        fi
                    done

                    process_flow[$clock]=$id  # Add the id of the process to the process_flow array
                    



                    clock=$(($clock+1))  # Increase clock by one.
                    makeOrder $id  # Call the make order function and pass id, beacuse we do not want to include id in the queue since it is processed at the moment. If another process comes in at that moment of time, the other processes must get the spot in queue infront of theone processed right now.
                done
                makeOrder 44  # Now we need to call make order again, because id might not be finished and so must be put in the queue, but we excluded it inside the loop.
            
            # Update the burst time.
            bt[$id]=$((${bt[$id]}-$service_units))
            # Calculate the turnaround time using the immutable arrival time array.
            tat[$id]=$(($clock-${arrival_time[$id]})) 

        fi           
    else
        # If there is no process ready to process, add -1 to the process flow array.
        process_flow[$clock]=-1
        clock=$(($clock+1))
        makeOrder 44  # Call make order to add new processes that might appeared in the clock increase by one.
    fi


done

echo 
echo ${process_flow[@]}
echo __w ${wt[@]}
echo tat ${tat[@]}
echo _at ${at[@]}