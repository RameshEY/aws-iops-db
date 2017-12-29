#!/bin/bash
# Parses the ycsb output to a csv format. Needs to be run only for individual load or "run" runs of ycsb
# usage: parse.sh {logfile.log} > {logfile.csv}
cat $1 | egrep 'OVERALL|READ|UPDATE|INSERT' | awk -F ',' '{b=$1$2; print b, ",", $3}' | awk -F ',' '
{
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str", "a[i,j];
        }
        print str
    }
}'
