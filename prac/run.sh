#!/bin/bash

function check_param() {
    if [ -z "$1" ]; then
        echo "Error: parameter $2 is not set."
        exit 1
    fi
}

./clear.sh

# Parse arguments
while [ "$1" != "" ]; do
    case $1 in
        -p )    shift
                num_proc=$1
                ;;
        -N )    shift
                N=$1
                ;;
        -eps )  shift
                eps=$1
                ;;
        -A )    shift
                A=$1
                ;;
        -b )    shift
                b=$1
                ;;
        -source ) shift
                source=$1
                ;;
        -program ) shift
                program=$1
                ;;
        * )     echo "Error: unknown parameter $1"
                exit 1
    esac
    shift
done

# Check that all required parameters are present
check_param "$num_proc" "-p num_proc"
check_param "$N" "-N"
check_param "$eps" "-eps"
check_param "$A" "-A"
check_param "$b" "-b"
check_param "$source" "-source"
check_param "$program" "-program"

# Compile source code
mpixlc -o "$program" "$source"

# Run program with given parameters and extract job_id
job_info=$(mpisubmit.pl -p "$num_proc" ./"$program" -- N="$N" eps="$eps" A="$A" b="$b")
job_id=$(echo "$job_info" | awk '{print $2}')
queue=$(echo "$job_info" | awk '{print $6}')  # Get name of the queue

# Print info about waiting
echo "Job with ID $job_id has been sent to queue $queue."

