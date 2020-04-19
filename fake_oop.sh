#! /bin/bash


name=process1
burst=14
arrival=10



make_process (){
    touch $name.txt
    echo $burst >> $name.txt
    echo $arrival >> $name.txt
}

make_process