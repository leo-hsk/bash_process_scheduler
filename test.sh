#a=2
#b=3
#myvar="$( awk -v var="$a" -v var2="$b" 'BEGIN {print ((var/var2)+1)*100000}' )"
#printf $myvar

id=( 0 1 2 3 4 )

wt=( 3 5 7 2 6 )
bt=( 3 5 1 3 6 )

repsonseR=( 0 0 0 0 0 )


for p in ${id[@]}
do
	a=${wt[$p]}
	b=${bt[$p]}
	responseRatio="$( awk -v var="$a" -v var2="$b" 'BEGIN {print ((var/var2)+1)*100000}' )"
	repsonseR[$p]=$responseRatio
done

echo ${repsonseR[@]}

