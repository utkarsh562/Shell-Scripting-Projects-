#!/bin/bash

#This is going to be the simnple password generator 

echo "Please enter the range of the password"

read PASS_LENGTH

for p in $(seq 1 5);
do
        openssl rand -base64 48 | cut -c -$PASS_LENGTH
done
~       
