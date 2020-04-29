#a=2
#b=3
#myvar="$( awk -v var="$a" -v var2="$b" 'BEGIN {print ((var/var2)+1)*100000}' )"
#printf $myvar

clock=2
service_units=3

for i in $( seq $clock $(($clock+$service_units-1)))
    do
        echo hi

    done
