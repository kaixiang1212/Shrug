#!/bin/sh

# Test shrug-add edge case
./shrug-add             # usage: shrug-add <filenames>
./shrug-add -           # shrug-add: error: invalid filename '-'
./shrug-add -f          # usage: shrug-add <filenames>
./shrug-add --          # usage: shrug-add <filenames>
./shrug-add -- f.txt    # shrug-add: error: can not open 'f.txt'
./shrug-add -ff         # usage: shrug-add <filenames>
./shrug-add --f         # usage: shrug-add <filenames>
./shrug-add .           # shrug-add: error: invalid filename '.'
./shrug-add .f          # shrug-add: error: invalid filename '.f'
./shrug-add f.          # shrug-add: error: can not open 'f.'
./shrug-add /c          # shrug-add: error: invalid filename '/c'
./shrug-add c/          # shrug-add: error: invalid filename 'c/'

