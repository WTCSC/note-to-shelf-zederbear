#!/bin/bash
NOTE_FILE="notes.txt"

# Add note
if [ $1 == "add" ]; then
    echo $(date +"%F %T") - $2 >> $NOTE_FILE
    echo Note added successfully
# List notes
elif [ $1 == "list" ]; then
    cat $NOTE_FILE
# Search notes
elif [ $1 == "search" ]; then
    grep -i "$2" $NOTE_FILE
else
    exit 1
fi

exit 0
