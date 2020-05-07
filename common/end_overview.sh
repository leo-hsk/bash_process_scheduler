#! /bin/bash

awk 'BEGIN {printf("%-12s %-12s %-12s %-12s %-12s  \n" ,"Process", "AT", "BT", "TAT", "WT")}'
for i in ${process_IDs[@]}
do
    echo "------------------------------------------------------------"
    awk -v p_names="${process_names[$i]::8}" -v at="${arrival_time[$i]}" -v bt="${burst_time[$i]}" -v tt="${tat[$i]}" -v wtt="${wt[$i]}" 'BEGIN {printf("%-12s %-12s %-12s %-12s %-12s  \n" ,p_names, at, bt, tt, wtt)}'
done
