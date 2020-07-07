#!/bin/bash

rm -rf .shrug a b 
shrug-init
touch a b
shrug-add a b
shrug-commit -m 'initial'