#!/bin/bash

if [ $1 == "add" ]; then
    echo $(date +"%F %T") - $2 >> notes.txt
    echo Note added successfully
elif [ $1 == "list" ]; then
    cat notes.txt
elif [ $1 == "search" ]; then
    grep -i $2 notes.txt
else
    exit 1
fi

exit 0
