#!/bin/bash
# Ulasovets Vladimir ulasovetsvladimir@gmail.com 08.11.2025
# Script for counting server responses

# variables
read -p "Enter target IP or hostname: " URL
URL=${URL:-10.97.37.33}
COUNT=100
echo "Addressing $COUNT curl calls to $URL"

declare -A responses
for ((i=1; i<=$COUNT; i++)); do
    response=$(curl -s $URL)
    ((responses[$response]++))

    # progress bar
    if (( i % 10 == 0 )); then
        echo "Done: $i/$COUNT"
    fi
done

echo "Result is:"

total=0
for code in "${!responses[@]}"; do
    echo "Code $code: ${responses[$code]} times"
    total=$((total + ${responses[$code]}))
done
