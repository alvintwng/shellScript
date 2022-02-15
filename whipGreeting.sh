# whipGreeting.sh
# usage: ./whipGreeting.sh
# text append to file: whipGreeting.txt

#!/bin/bash

function timing {
  for ((i = 0 ; i <= 100 ; i+=5)); do
    sleep 0.2
    echo $i
  done
}


# Part 1 - Query for the user's name
NAME=$(whiptail --inputbox "What is your name?" 8 39 --title "Getting to know you" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
  echo "Name: $NAME" >> whipGreeting.txt
  timing | whiptail --gauge "Greetings, $NAME." 6 50 0
else
  echo "User canceled input."
fi

echo "(Exit status: $exitstatus)"


# Part 2 - Query for the user's country
COUNTRY=$(whiptail --inputbox "Which country do you live in?" 8 39 --title "Getting to know you" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
  MYVAR="I hope the weather is nice in ${COUNTRY}!" 
  echo "Country: $COUNTRY" >> whipGreeting.txt
  whiptail --msgbox "$MYVAR" 12 80
else
  echo "User canceled input."
fi

echo "(Exit status: $exitstatus)"
