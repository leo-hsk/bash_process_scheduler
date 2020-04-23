# !/bin/bash


at=( 7 7 6 1 9 )


function findSmallest(){
	smallest=0

	let len=${#at[*]}-1

	for i in $(seq 0 $len)
	do
		if [[ $((at[$i])) -eq -1 ]]
		then
			continue
		else
    		if [[ $((at[$i])) -lt $((at[$smallest])) ]]
     		then
        		smallest=$i
     		fi
     	fi
done

echo $smallest

}

id=$(findSmallest)

echo $id