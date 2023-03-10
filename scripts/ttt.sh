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
    if [ "${b[0]}" = "$1" ] && [ "${b[1]}" = "$1" ] && [ "${b[2]}" = "$1" ]; then 
        true; return
    fi
    if [ "${b[3]}" = "$1" ] && [ "${b[4]}" = "$1" ] && [ "${b[5]}" = "$1" ]; then 
        true; return
    fi
    if [ "${b[6]}" = "$1" ] && [ "${b[7]}" = "$1" ] && [ "${b[8]}" = "$1" ]; then 
        true; return
    fi 
    false
}

function isWinCols(){
    if [ "${b[0]}" = "$1" ] && [ "${b[3]}" = "$1" ] && [ "${b[6]}" = "$1" ]; then 
        true; return
    fi
    if [ "${b[1]}" = "$1" ] && [ "${b[4]}" = "$1" ] && [ "${b[7]}" = "$1" ]; then 
        true; return
    fi
    if [ "${b[2]}" = "$1" ] && [ "${b[5]}" = "$1" ] && [ "${b[8]}" = "$1" ]; then 
        true; return
    fi 
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
winner=""

if [ $player = 'X' ]; then
    print_board
    player_place $player
fi

while [ $game_state = "running" ]; do 
    computer_place $computer
    print_board
    if isWin $computer; then
        game_state="won"
        winner="computer"
        break
    fi
    if isDraw; then
        game_state="draw"
        break
    fi;

    player_place $player
    print_board
    if isWin $player ; then
        game_state="won"
        winner="player"
        break
    fi
    if isDraw; then
        break
    fi;
done

