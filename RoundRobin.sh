#!/bin/bash

n=4

# Names of the processes
processes=( A B C D )
process_nums=( 0 1 2 3 ) # ToDo Create with a function.

# Burst Time
bt=( 5 4 8 7 )

# Arrival Time
at=( 22 1 1 7 )


quantum=3

clock=0  # This is the simulations clock = passed time since start.

declare -a output


while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]
do
    processed=0
    echo p1 $processed
    for i in ${process_nums[@]}
    do 
        let time_to_start=${at[$i]}-$clock
        if [ $time_to_start -le 0 ] # If ariival time minus the passed time is less or equal than 0, the process is ready to be serviced.
            then
                service_units=${bt[$i]}  # The Service time for round robin is the time slice / quantum but it might be the case that a processes as less than quantum units left.
                if [ $service_units -gt 0 ]
                then
                    if [ $service_units -gt $quantum ]
                    then 
                        service_units=$quantum  # If the Process has more than 3 (or whatever value quantum has) time units of service left, it gets shortend to the value of quantum. 
                    fi
                    let clock=$clock+$service_units  # Set the new clock time.
                    let new_burst_time=${bt[$i]}-$service_units  # Set the new left burst time.
                    bt[$i]=$new_burst_time
                    processed=1
                    echo p2 $processed
                    for _ in $(seq 1 $service_units)
                    do
                        output+=$i' '
                    done
                fi            
                

        fi
    done
    echo p3 $processed
    if [ $processed -eq 0 ]  # If there isnt a Process to service st this time, a -1 gets added to the process flow output. 
    then 
        echo notimg
        let clock=$clock+1  # And of course the time gets increased by one.
        output+=-1' '
    fi


    echo bt ${bt[*]}
    echo clock $clock
    echo - - $i
done

echo 
echo RoundRobin Output:
echo $output
