#! /bin/bash
at=( 3 5 7 2 6 )
bt=( 3 5 1 3 6 )
process_names=( A B C D E )
process_IDs=( 0 1 2 3 4 )

max_no=75 # Max no. of allowed gantt chart characters
n=5 # No. of sample processes


process_flow=()

tat=( $(for i in $(seq 1 $n); do echo 0; done) )
wt=( $(for i in $(seq 1 $n); do echo 0; done) )

# One if process is waiting and zero if not
isWaiting=( $(for i in $(seq 1 $n); do echo 0; done) )

# Response Ratio
responseR=( $(for i in $(seq 1 $n); do echo 0; done) )

########################################################################


#output of the "function"


processSchedulerWorkingDir=$(pwd)

############# FOR FINAL IMPLEMENTATION CHANGE TO:	source ${processSchedulerWorkingDir}/FCFS/xxxxxxxxxxx.sh
function findHighestResponseRatio(){
    # Start with index 0

    highest=0

    # Iterate through each responseRatio element
    for i in ${process_IDs[@]}
    do
        # Check if process already arrived
        if [[ ${at[$i]} -le $clock ]]
        then
        
            # Check if the value of the response ratio element is more than the highest (first) at this time
            if [[ $((responseR[$i])) -ge $((responseR[$highest])) ]]
             then
                 # If yes, set the current index of the response ratio element to the highest value
                highest=$i
             fi
         fi
done
# Return index of the highest value
echo $highest

}

function calcResponseRatio() {
    # Reset the isWaiting array to all zeros
    for p in ${process_IDs[@]}
    do
        # Calculate response ratio fo each process * 1000
        if [[ ${bt[$p]} -eq 0 ]]
        then
            responseR[$p]=0
        else
            rratio=$(bc <<< "scale=0;(${wt[$p]}+${bt[$p]})*1000/${bt[$p]}")
            responseR[$p]=$rratio
        fi
    done
}

function getAllWaitingJobs() {

    # Reset the isWaiting array to all zeros
    for i in $(seq 0 $((${#isWaiting[@]}-1)))
    do
        isWaiting[$i]=0
    done

    for p in ${process_IDs[@]}
    do
        if [[ $((at[$p]-$clock)) -le 0 ]]
        then
            isWaiting[$p]=1
        fi
    done
    # Controlling
    # echo "Finished" ${isWaiting[@]}

}


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
        #tat[$id]=$(($clock-${arrival_time[$id]}))

    else
        # If there is no process ready to process, add -1 to the process flow array
        process_flow[$(($clock))]=-1
        clock=$(($clock+1))

    fi
done

echo ${process_flow[@]}
#echo tat ${tat[@]}
#echo at ${at[@]}
