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

echo "$ shrug-show"
out=`shrug-show 2>&1`
exp="shrug repository"
check_out

echo "$ shrug-init"
shrug-init

echo "$ shrug-show"
out=`shrug-show 2>&1`
exp="usage"
check_out

echo "$ shrug-show aaaa"
out=`shrug-show aaaa 2>&1`
exp="invalid object"
check_out

echo "$ shrug-show aaaa:"
out=`shrug-show aaaa: 2>&1`
exp="unknown commit"
check_out

echo "$ echo hello > a"
echo hello > a

echo "$ shrug-add a"
shrug-add a

echo "$ shrug-commit -m 'first commit'"
shrug-commit -m 'first commit'

echo "$ shrug-log aaaa"
out=`shrug-log aaaa 2>&1`
exp="usage"
check_out

echo "$ shrug-show :a"
out=`shrug-show :a`
exp="hello"
check_out

echo "$ shrug-show 0:a"
out=`shrug-show :a`
exp="hello"
check_out

echo "echo world >> a"
echo world >> a

echo "$ shrug-show :a"
out=`shrug-show :a`
exp="[^world]"
check_out

echo "$ shrug-add a"
shrug-add a

echo "$ shrug-show :a"
out=`shrug-show :a`
exp="hello
world"
check_out
