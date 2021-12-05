#!/bin/bash

rm -rf $3
eval $(cat -n $2|grep 'TRUTH INFORMATION'|awk 'BEGIN{ i=0 } { i++; print "stl["i"]="$1+3} END{}')
#echo ${stl[100]}

for j in $( seq 1 $1 )
do
    #echo ${stl[$j]}
    l=`expr ${stl[$[j+1]]} - ${stl[j]}`
    #echo $l
    #l=$(cat $2 | wc -l)
    cat $2 | tail -n +${stl[$j]} | head -n $l | sed -e '/VERBOSE/d' | \
    awk 'BEGIN{ \
    print "\n# THE FLOW CHART\n\n```mermaid\ngraph TD\nclassDef Amaranth fill:#E52B50;\nclassDef Amber fill:#FFBF00;\nclassDef Amethyst fill:#9966CC;\nclassDef Apricot fill:#FBCCEB1;\nclassDef Azure fill:#007FFF;\nclassDef Aquamarine fill:#7FFFD4;\nclassDef Violet fill:#EE82EE;\nclassDef DarkOrchid fill:#9932CC;";\
    } \
    { \
    split($3,ID,","); split($0,A,"("); split(A[2],PID,")"); split($0,B,"="); split(B[5],NE,","); split(B[7],mass,","); print PID[1]  "-->" ID[1] "(" NE[1] "<br>" B[8] ")";\
    } \
    END{ \
    print "```" \
    }' | \
    sed -e '/>/s/[[:space:]]//g' -e '/>/s/)/ )/g' -e '/>/s/,0//g' -e '/>/s/\,/ \& /g' \
    -e '/K+/s/)/):::Amaranth/g' -e '/K-/s/)/):::Amber/g' \
    -e '/mu+/s/)/):::Amethyst/g' -e '/mu-/s/)/):::Apricot/g' \
    -e '/e+/s/)/):::Aquamarine/g' -e '/e-/s/)/):::Azure/g' \
    -e '/pi+/s/)/):::Violet/g' -e '/pi-/s/)/):::DarkOrchid/g' \
    >> $3
done