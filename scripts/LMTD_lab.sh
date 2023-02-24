#!/bin/bash

#group6
#https://github.com/LMTD/phase-1A/tree/master/units/unit1/lab1

function s1(){
    echo What is your name?
    read name
    echo Hello $name!
}

function s2(){
    echo "What operating system do you use?"
    read os
    os=$(echo $os | tr "A-Z" "a-z")
    if [ $os = "linux" ]; then
        echo "Nice!"
    elif [ $os = "macos"]; then
        echo "Not bad!"
    else
        echo "Alright"
    fi
}

function s3(){
    echo What range would you like to sum? 
    echo "(Enter 2 numbers separated by spaces)"
    read start end
    
    sum=0
    for ((i = $start; i <= $end; i++)); do
        sum=$(($sum+$i))
    done
    echo $sum
}

function s4(){
    s=$(echo "scale=4; ($1+$2+$3)/2" | bc)
    sm=$(echo "scale=4; $s*($s-$1)*($s-$2)*($s-$3)" | bc)
    area=$(echo "scale=4; sqrt($sm)" | bc)
    echo The area of a triangle with sides $a, $b, $c is $area
}

function s5(){
    file="./randomfile.txt"
    #each line in randomfile is either a number or letters
    
    sum=0
    count=0
    nonsense=0

    while read -r line; do
        if [[ $line =~ ^[0-9]+$ ]]; then
            sum=$((sum+line))
        elif [[ $line =~ ^[A-Za-z]+$ ]]; then
            ch_cnt=$(echo $line | wc -c)
            count=$(($count+$ch_cnt))
        else
            ((nonsense++))
        fi
    done < $file
    
    echo Total sum of numbers: $sum > out
    echo Total count of characters: $count >> out
    echo Total count of nonsense: $nonsense >> out
}

s1
echo
s2
echo
s3
echo
echo Enter three side lengths separated by spaces
read a b c
s4 $a $b $c
echo
s5
