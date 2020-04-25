#!/bin/bash -x

echo "-------SNAKE AND LADDER GAME-------"

START=0
NO_PLAY=0
SNAKE=1
LADDER=2
WIN=100

player1Pos=$START

echo "Starting position is $START"

function playerMove() {
	playerOption=$1
	playerPos=$2
	if [ $playerOption -eq $SNAKE ]
	then
		if [ $((playerPos - diceValue)) -lt 0 ]
		then
			playerPos=$START
		else
			((playerPos-=$diceValue))
		fi
	else
		if [ $((playerPos + diceValue)) -le 100 ]
		then
			((playerPos+=$diceValue))
		fi
	fi
	echo $playerPos
}

function playGame() {
	player1Pos=$START
	player2Pos=$START
	totalDiceRolls=0
	currentPlayer=1
	while [[ $player1Pos -lt $WIN && $player2Pos -lt $WIN ]]
	do
		echo -e "\nCurrent player is player $currentPlayer"
		diceValue=$((RANDOM % 6 + 1))
		((totalDiceRolls++))
		echo "Dice value is $diceValue"
		option=$((RANDOM % 3))
		case $option in
			$NO_PLAY)
				echo "No Play";;
			$SNAKE)
				echo "Snake"
				if [ $currentPlayer -eq 1 ]
            	then
              		player1Pos="$( playerMove $SNAKE $player1Pos )"
            	else
              		player2Pos="$( playerMove $SNAKE $player2Pos )"
            	fi;;
			$LADDER)
				echo "Ladder"
				if [ $currentPlayer -eq 1 ]
				then
					player1Pos="$( playerMove $LADDER $player1Pos )"
				else
					player2Pos="$( playerMove $LADDER $player2Pos )"
				fi;;
		esac
		echo "Player 1: $player1Pos	Player 2: $player2Pos"
		currentPlayer=$((3 - currentPlayer))
	done
	echo -e "\nThe dice was rolled $totalDiceRolls times to reach winning position"
}

function findWinner() {
	if [ $player1Pos -eq 100 ]
	then
		echo -e "PLAYER 1 IS THE WINNER\n"
	else
		echo -e "PLAYER 2 IS THE WINNER\n"
   fi
}

continueGame="y"
while [ $continueGame == "y" ]
do
	playGame
	findWinner
	read -p "Do you want to continue playing (y/n) ?: " continueGame
done
