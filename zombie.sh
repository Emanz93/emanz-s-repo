#!/bin/bash

#This script allow to count number of zombies process will be create during the execution of a process.
#The script will terminate when the process will die.
#Author Emanz93 - Emanuele Lovera

echo "Please enter the name of the process to be monitored:"
read process #variable that contains the name of the process

logfile="zombie_$process.log" #Name of the logfile

let "c_process = 0" #counter of number of 'process'

#loop util i'll find '$process'
while [ $c_process -le 0 ]
do
	c_process=`ps awx | awk '{ print $3 " " $5 }' | grep $process | wc -l`
done

let "c_past = 0" #Number of zombie in previous-loop.
let "c_now = 0" #Number of zombie in this loop.
let "zombie = 0" #Number of real zombie.

while [ $c_process -gt 1 ]
do
	#Update the number(s) of process
	c_process=`ps awx | awk '{ print $3 " " $5 }' | grep $process | wc -l`

	#Count the number of zombie process in this moment
	c_now=`ps awx | awk '{ print $3 " " $5 }' | grep $process | grep Z | wc -l`

	#calculating the difference because i'll increase the number of Zombie only if there's an increase in the
	#difference between c_pat and c_now
	difference=`expr $c_now - $c_past`
	if [ $difference -gt 0 ]; then
		#I'll count if difference is more than 0. count real number of zombie.
		zombie=`expr $zombie + 1`
		echo "zombie!" > $logfile 
		echo "zombie!"
	fi

	#Update the c_past for the next loop
	c_past=$c_now
done

echo "$process has created: $zombie Zombies" >> $logfile
echo "$process has created: $zombie Zombies"
