#!/bin/sh
# runs the various xstow functions on the Makefile with nice output

output=$("$@" 2>&1)
status=$?

if [ $status -eq 0 ]; then
    if [ -z "$output" ]; then
        echo "done successfully, no errors! :>"
    else
        # Separate informational messages from actual warnings
        warnings=$(echo "$output" | grep -iE "warning:|conflict:|already exists|skipping|error:|failed|cannot")
        info=$(echo "$output" | grep -vE "warning:|conflict:|already exists|skipping|error:|failed|cannot")
        
        if [ -n "$warnings" ]; then
            echo "succeeded with following warnings:"
            echo "$warnings"
            if [ -n "$info" ]; then
                echo ""
                echo "Info:"
                echo "$info"
            fi
        else
            # Only informational output, no actual warnings
            echo "done successfully, no errors! :>"
        fi
    fi
else
    echo "FAIL:"
    echo "$output"
    exit $status
fi
