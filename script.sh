#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage $0 <process>"
    exit 1
fi


PROC="$1"
Output=$(ps aux --sort=-%cpu | grep -i "$PROC" | grep -v "grep" | grep -v "$0" | awk '
    NR<=8 { 
        printf "%-10s %-6s %-6s ", $2, $3, $4; 
        for(i=11; i<=NF; i++) {
            printf "%s ", $i;
        }
        printf "\n";
    }
' )

if [ -z "$Output" ]; then
    echo "No process found"
else
    title="PID CPU MEM COMMAND"
    echo $title | awk '{printf "%-10s %-6s %-6s %s ", $1, $2, $3 ,$4; }'
    echo ""
    echo "$Output" | cut -c 1-$(tput cols)

fi

