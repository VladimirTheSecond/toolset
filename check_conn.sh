#!/usr/bin/env bash
# script for checking network availability

work_dir=$(pwd)
# put here desired port to check
# e.g. default MySQL port
port=3306

# check if file ip_addresses.txt exists
if ! test -f ${work_dir}//ip_addresses.txt; then
	echo "File ip_addresses.txt not found - see README.md"
	exit 1
fi

rm ${work_dir}/output.txt 2> /dev/null

while read i; do
	ping -c 3 $i >> output.txt
	traceroute $i >> output.txt
	telnet $i $port
  if [ $? -eq 0 ];
  then
	  echo "$i is available on port $port"
  else
	  "${i} is NOT available on port ${port}, saved to output"
  fi
done < ${work_dir}/ip_addresses.txt
