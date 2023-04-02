#!/bin/bash

#set -x

b=(" " " " " " " " " " " " " " " " " ")

function print_board(){
    echo
    echo "   1   2   3"
    echo "A  ${b[0]} | ${b[1]} | ${b[2]}"
    echo "  ---+---+---"
    echo "B  ${b[3]} | ${b[4]} | ${b[5]}"
    echo "  ---+---+---"
    echo "C  ${b[6]} | ${b[7]} | ${b[8]}"
    echo
}

function computer_place(){
    for i in "${!b[@]}"; do
        if [ "${b[$i]}" = " " ]; then
            b[i]=$1
            break
        fi
    done
}

function isWinRows(){
    for i in {0,3,6}; do
        if [ "${b[$i]}" = "$1" ] && [ "${b[$((i+1))]}" = "$1" ] && [ "${b[$((i+2))]}" = "$1" ]; then
            true; return
        fi
    done
    false
}

function isWinCols(){
    for i in {0,1,2}; do
        if [ "${b[$i]}" = "$1" ] && [ "${b[$((i+3))]}" = "$1" ] && [ "${b[$((i+6))]}" = "$1" ]; then
            true; return
        fi
    done
    false
}

function isWinDiags(){
    if [ "${b[0]}" = "$1" ] && [ "${b[4]}" = "$1" ] && [ "${b[8]}" = "$1" ]; then 
        true; return
    fi
    if [ "${b[2]}" = "$1" ] && [ "${b[4]}" = "$1" ] && [ "${b[6]}" = "$1" ]; then 
        true; return
    fi
    false
}

function isWin(){
    isWinRows $1 || isWinCols $1 || isWinDiags $1 
}

function isDraw(){
    for i in "${!b[@]}"; do
        if [ "${b[$i]}" = " " ]; then
            false; return
        fi
    done
    true
}

function player_place(){
    echo "Please enter your move:"
    read move
    move=$(echo $move | tr -d '[:space:]' | tr 'a-z' 'A-Z')  
    if ! [[ "$move" =~ ^[A-C][1-3]$ ]]; then
        repeat_reason="invalid"
    else
        val=$(echo $move | tr '[A-C][1-3]' '[0-2][0-2]') 
        val=$((${val:0:1}*3+${val:1:2}))
        if [ "${b[$val]}" = " " ]; then
            repeat_reason="valid"
        else
            repeat_reason="placed"
        fi
    fi
    while [ "$repeat_reason" = "invalid" ] || [ "$repeat_reason" = "placed" ]; do
        if [ "$repeat_reason" = "invalid" ]; then
            echo "That's not a valid move. Please enter a valid move:"
        else
            echo "That square is not empty. Please enter an empty square:"
        fi
        read move
        move=$(echo $move | tr -d '[:space:]' | tr 'a-z' 'A-Z')  
        if [[ "$move" =~ ^[A-C][1-3]$ ]]; then
            val=$(echo $move | tr '[A-C][1-3]' '[0-2][0-2]') 
            val=$((${val:0:1}*3+${val:1:2}))
            if [ "${b[$val]}" = " " ]; then
                repeat_reason="valid"
            else
                repeat_reason="placed"
            fi
        else
            repeat_reason="invalid"
        fi
    done
    b[$val]=$1
}

echo "Welcome to Tic Tac Toe! "
echo "Would you like to play X or O?"
read player
player=$(echo $player | tr 'a-z' 'A-Z')

while [ "$player" != "X" ] && [ "$player" != "O" ]; do
    echo "That's not a valid answer. Please enter X or O:"
    read player
    player=$(echo $player | tr 'a-z' 'A-Z')
done

if [ $player = "X" ]; then 
    computer="O"
else 
    computer="X"
fi

echo
echo "Okay you will be $player. The computer will be $computer."
echo "X will go first."
echo
echo "Enter your move as LETTER followed by NUMBER." 
echo "For example the center square is B2."
echo

game_state="running"

if [ $player = 'X' ]; then
    print_board
    player_place $player
fi

while [ $game_state = "running" ]; do 
    computer_place $computer
    clear; print_board
    if isWin $computer; then
        game_state="loss"
        break
    fi
    if isDraw; then
        game_state="draw"
        break
    fi;

    player_place $player
    if isWin $player ; then
        game_state="won"
        clear; print_board
        break
    fi
    if isDraw; then
        game_state="draw"
        clear; print_board
        break
    fi;
done

if [ "$game_state" = "draw" ]; then
    echo "Draw!"
elif [ "$game_state" = "won" ]; then
    echo "You won!"
elif [ "$game_state" = "loss" ]; then
    echo "You lost :("
fi