#!/bin/sh

if [ $# -ne 1 ]; then
   echo "Usage: makedata.sh <number of data>"
   exit 1
fi

MAX=$1
i=0
filename=$(cd $(dirname $0);pwd)/kafka.txt
: > $filename
declare -a names=("xxx" "yyy" "zzz")
delimiter=''

while [ "$i" -ne "$MAX" ]
do
  id=$(uuidgen)
  name=${names[$i % 3]}
  value=`expr 1 + $RANDOM % 1000`
  #dd="0$(($RANDOM % 9 + 1))"
  #mm="0$(($RANDOM % 10))"
  #dt="2011-03-${dd}T${mm}:00:00.000"
  unixtime=$(($RANDOM*100+1581000000))

  # Mac
  dt=$(date -u -r ${unixtime} +"%Y-%m-%dT%H:%M:%S.000")
  # Linux
  #date -u -d @1557961216 +"%Y-%m-%dT%H:%M:%S.000"

  printf "{\"id\": \"%s\", \"name\": \"%s\", \"datetime\": \"%s\", \"schemaless\": {\"abc\": 0}, \"unixtime\": %d, \"term\": 10000, \"value\": %d}\n" ${id} ${name} "${dt}" ${unixtime} ${value} >> $filename
  let i++
done

exit 0
