#!/bin/bash
NOTE_FILE="notes.txt"

if [ $1 == "add" ]; then
    echo $(date +"%F %T") - $2 >> $NOTE_FILE
    echo Note added successfully
elif [ $1 == "list" ]; then
    cat $NOTE_FILE
elif [ $1 == "search" ]; then
    grep -i "$2" $NOTE_FILE
else
    exit 1
fi

exit 0
