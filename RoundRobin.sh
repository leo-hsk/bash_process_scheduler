#!/bin/bash

############ input

# Max no. of gantt chart characters
max_no=75

# No. of (sample) processes
n=5

declare -a process_names=( A B C D E )

# List of process IDs
declare -a process_IDs=( 0 1 2 3 4 )

# List of burst time
declare -a bt=( 4 4 4 4 4 )

# Arrival Time
declare -a at=( 0 4 3 1 0 ) # Copy (mutable)
declare -a arrival_time=( 3 5 7 2 6 ) # Original (immutable)

# Waiting Time
declare -a wt=( $(for i in $(seq 1 $n); do echo 0; done) )

# One if process is waiting and zero if not
isWaiting=( $(for i in $(seq 1 $n); do echo 0; done) )

# Turnaround Time
declare -a tat=( $(for i in $(seq 1 $n); do echo 0; done) )

#output of the "function"
declare -a process_flow=()

declare -a queue=()


quantum=1

clock=0  # This is the simulations clock = passed time since start.

declare -a output

function is_in_order() {
    for p2 in ${queue[@]}
    do 
        if [[ $p2 -eq $1 ]]
        then
            return 1

        fi
    done
    return 0
}

function make_order() {
    for p in ${process_IDs[@]}
    do 
        if [[ $p -ne $1 ]]
        then
            is_in_order $p
            x=$?
            if [[ ${at[$p]} -le $clock ]]  && [[ $x -eq 0 ]]
            then
                queue+=($p)
            fi
        fi



    done
}


function get_next_in_queue(){
    # This function returns the next character in the queue and at the same time removes it from the queue.
    # If there is nothing in the queue it returns a negative 1.
    printf "called"
    if [[ ${#queue[@]} -gt 0 ]]
    then
        x=${queue[0]}
        queue=("${queue[@]:1}")
        printf "x is $x \n"
        return $x
    else
        printf "else"
        return 44

    fi

}
make_order 44

while [ $(IFS=+; echo "$((${bt[*]}))") -gt 0 ]
do

    processed=0 # ToDo remove this indicator
    get_next_in_queue
    id=$?
    echo id: $id
    echo qu: ${queue[@]}
    if [[ $id -ne 44 ]]
    then 
        let time_to_start=${at[$id]}-$clock
        if [ $time_to_start -le 0 ] # If arival time minus the passed time is less or equal than 0, the process is ready to be serviced.
        then
            service_units=${bt[$id]}  # The Service time for round robin is the time slice / quantum but it might be the case that a processes as less than quantum units left.
            echo $service_units
            if [ $service_units -gt 0 ]
            then
                if [ $service_units -gt $quantum ]
                then 
                    service_units=$quantum  # If the Process has more than 3 (or whatever value quantum has) time units of service left, it gets shortend to the value of quantum. 
                fi
                for i in $( seq $clock $(($clock+$service_units-1)))
                    do
                        clock=$(($clock+1))
                        make_order $id 
                        echo clock $clock
                        echo queue ${queue[@]}
                    done
                    make_order 44
                
                let new_burst_time=${bt[$id]}-$service_units  # Set the new left burst time.
                bt[$id]=$new_burst_time
                processed=1
                echo processed $processed
                for _ in $(seq 1 $service_units)
                do
                    output+=$id' '
                done
                last=$id
                echo last set to $last
                echo end clock $clock
                echo - - - - 
            fi            
        fi
    else
        echo notimg
        let clock=$clock+1  # And of course the time gets increased by one.
        output+=-1' '
        make_order 44
    fi


    echo endend clock $clock
    echo - - - 
done

echo 
echo RoundRobin Output:
echo $output
