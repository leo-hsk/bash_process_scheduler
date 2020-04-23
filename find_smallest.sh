# !/bin/bash
# returns the index of the smallest value in an array

at=( 7 7 6 1 9 )
smallest=0

let len=${#at[*]}-1

for i in $(seq 0 $len)
do

     if [[ $((at[$i])) -lt $((at[$smallest])) ]]
     then
        smallest=$i
     fi
done

echo $smallest