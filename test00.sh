#!/bin/dash

# Test different behaviors of shrug-init

rm -rf .shrug
# Test if arguments is given to shrug-init
echo "$ shrug-init a"
if shrug-init a; then
    echo "Program not exited with code 1"
    exit 1
fi

# Test if shrug-init work correctly
echo "$ shrug-init"
if ! shrug-init; then
    echo "Program not exited with code 0"
    exit 1
fi

# Test if .shrug directory exist
if [ ! -d .shrug ]; then
    echo ".shrug directory does not exist"
fi

# Test if .shrug already exist
echo "$ shrug-init"
if shrug-init; then
    echo "Program not exited with code 1"
    exit 1
fi
