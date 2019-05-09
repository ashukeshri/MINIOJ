#!/bin/bash

if [ $# -eq 1 ]; then
	if [ -e $1 ]; then
		echo "Choose Language "
		echo "1. C/C++ "
		echo "2. Python3 "
		read a
		case $a in
			1)
				echo "C++"
				if [ -e fcreated ]; then
					rm fcreated
				fi
				g++ -o fcreated "$1"
				if [ ! -e fcreated ]; then
					echo " Compilation Error! "
					exit
				fi
				chmod 777 fcreated
				N=1
				files=$( ls ./in/*.in )
				for LINE in $files
				do
					./fcreated < "$LINE" > "./output/$N.out"
					diff ./output/$N.out ./correctoutput/$N.out > log.txt
					if [ $? -eq 1 ]; then
						echo " Wrong Answer In $LINE "
						exit
					fi
					N=$((N+1))
				done
				echo "ACCEPTED!"
				;;
			2) 
				echo "Python3"
				python "$1" < "./in/input1.in" 
				if [ $? != 0 ]; then
					echo "Copilation Error!"
					exit
				fi
				N=1
				files=$( ls ./in/*.in )
				for LINE in $files
				do
					python "$1" < "$LINE" > "./output/$N.out"
					diff ./output/$N.out ./correctoutput/$N.out > log.txt
					if [ $? -eq 1 ]; then
						echo " Wrong Answer In $LINE "
						exit
					fi
					N=$((N+1))
				done
				echo "ACCEPTED!"
				;;
			*)
				echo "Invalid Choice"
		esac
	else
		echo "$1 File not Found"
	fi
else
	echo "Parameter Missing"
fi
