#!/bin/bash




i=10
while [[ i -ge 0 ]]
do 

    printf "\rYou have %02d seconds left." ${i}
    i=$(($i-1))
    read -t 1 -p " Or Press ENTER to continue."
    a=$?
    if [[ $a == 0 ]]
    then
        break
    fi
done
echo 
echo ...


