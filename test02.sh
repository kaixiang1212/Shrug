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

echo "$ shrug-commit"
out=`shrug-commit 2>&1`
check_exit_1
exp="shrug-commit: error: no .shrug directory containing shrug repository exists"
check_out

echo "$ shrug-init"
shrug-init

echo "$ shrug-commit"
out=`shrug-commit`
check_exit_1
exp="usage"
check_out

echo "$ shrug-commit -a -m 'first commit'"
out=`shrug-commit -a -m 'first commit'`
exp="nothing to"
check_out

echo "$ touch a"
touch a b

echo "$ shrug-add a"
shrug-add a

echo "$ shrug-commit -m 'first commit'"
out=`shrug-commit -m 'first commit'`
exp="commit 0"
check_out

echo "$ shrug-add b"
shrug-add b
echo "$ shrug-commit -m 'second commit'"
out=`shrug-commit -m 'second commit'`
exp="commit 1"
check_out

echo "$ echo "hello" >> a"
echo "hello" >> a

echo "$ shrug-commit -m 'third commit'"
out=`shrug-commit -m 'third commit'`
exp="nothing"
check_out

echo "$ shrug-commit -a -m 'third commit'"
out=`shrug-commit -a -m 'third commit'`
exp="commit 2"
check_out