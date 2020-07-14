#!/bin/dash


# Test different behavoir of shrug-add
rm -rf .shrug a b
echo "$ touch a"
touch a

echo "$ shrug-add a"
err=`shrug-add a 2>&1`
if [ $? -ne 1 ]; then
    echo "Program should exit with error code 1"
    exit
elif echo "$err" | grep -v -q "error: no .shrug directory containing shrug repository exists"; then
    echo "Expect output: shrug-add: error: no .shrug directory containing shrug repository exists"
    echo "Actual output: $err"
    exit 
fi
echo "$err"
echo "$ shrug-init a"
shrug-init

out=`shrug-add a`
if [ -n "$out" ]; then 
    echo "Unexpected output: $out"
fi

err=`shrug-add b 2>&1`
if [ $? -ne 1 ]; then
    echo "Program should exit with code 1"
    exit
elif echo "$err" | grep -v -q "error: can not open 'b'"; then
    echo "Expect output: shrug-add: error: can not open 'b'"
    echo "Actual output: $err"
    exit
fi
echo $err
