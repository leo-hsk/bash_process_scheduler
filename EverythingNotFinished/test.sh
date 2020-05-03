#a=2
#b=3
#myvar="$( awk -v var="$a" -v var2="$b" 'BEGIN {print ((var/var2)+1)*100000}' )"
#printf $myvar

queue=( 17 11 4 )

function take_out_first() {
    x=${queue[0]}
    queue=("${queue[@]:1}")
    return $x

}


take_out_first
y=$?
echo $y
echo q ${queue[@]}
queue+=(99)
take_out_first
y=$?
echo $y
echo q ${queue[@]}