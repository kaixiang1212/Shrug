#!/bin/dash

check_exit_1(){
    if [ $? -ne 1 ]; then
        echo "Program should exit with code 1" >> /dev/stderr
        exit 1
    fi
}
check_out(){
    if echo "$out" | grep -v -q "$exp"; then
        echo "Error : Unexpected Output: $out" >> /dev/stderr
        exit 1
    fi
    echo $out
}

rm -rf .shrug

echo "$ shrug-log"
out=`shrug-log 2>&1`
exp="shrug repository"
check_out

echo "$ shrug-init"
shrug-init

echo "$ shrug-log"
out=`shrug-log 2>&1`
exp="does not have any commit"
check_out

echo "$ shrug-log aaaa"
out=`shrug-log 2>&1`
exp="does not have any commit"
check_out

echo "$ touch a"
touch a b

echo "$ shrug-add a"
shrug-add a

echo "$ shrug-commit -m 'first commit'"
shrug-commit -m 'first commit'

echo "$ shrug-log"
out=`shrug-log`
exp="0 first"
check_out

echo "$ shrug-log aaaa"
out=`shrug-log aaaa 2>&1`
exp="usage"
check_out
