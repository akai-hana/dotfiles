#!/bin/sh
# runs the various xstow functions on the Makefile with nice output

output=$("$@" 2>&1)
status=$?

if [ $status -eq 0 ]; then
    if [ -z "$output" ]; then
        echo "Done successfully! No errors!"
    else
        echo "Succeeded with following warnings:"
        echo "$output"
    fi
else
    echo "FAIL:"
    echo "$output"
    exit $status
fi
