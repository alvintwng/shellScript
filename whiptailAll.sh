#!/bin/bash

COLOR=$(whiptail --inputbox ".. 1 .. What is your favorite Color?" 8 39 Blue --title "Example Dialog" 3>&1 1>&2 2>&3)
# A trick to swap stdout and stderr.
# Again, you can pack this inside if, but it seems really long for some 80-col terminal users.
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $COLOR
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"



echo ".. 2 ..  Welcome to Bash $BASH_VERSION" > test_textbox
#                  filename height width
whiptail --textbox test_textbox 12 80



PASSWORD=$(whiptail --passwordbox ".. 3 .. please enter your secret password" 8 78 --title "password dialog" 3>&1 1>&2 2>&3)
# A trick to swap stdout and stderr.                                                                                    
# Again, you can pack this inside if, but it seems really long for some 80-col terminal users.
exitstatus=$?
if [ $exitstatus == 0 ]; then
    echo "User selected Ok and entered " $PASSWORD
else
    echo "User selected Cancel."
fi
               
echo "(Exit status was $exitstatus)"



whiptail --title ".. 4 .. Menu example" --menu "Choose an option" 25 78 16 \
"<-- Back" "Return to the main menu." \
"Add User" "Add a user to the system." \
"Modify User" "Modify an existing user." \
"List Users" "List all users on the system." \
"Add Group" "Add a user group to the system." \
"Modify Group" "Modify a group and its list of members." \
"List Groups" "List all groups on the system."



whiptail --title ".. 5 .. Check list example" --checklist \
"Choose user's permissions" 20 78 4 \
"NET_OUTBOUND" "Allow connections to other hosts" ON \
"NET_INBOUND" "Allow connections from other hosts" OFF \
"LOCAL_MOUNT" "Allow mounting of local devices" OFF \
"REMOTE_MOUNT" "Allow mounting of remote devices" OFF



whiptail --title ".. 6 .. Radio list example" --radiolist \
"Choose user's permissions" 20 78 4 \
"NET_OUTBOUND" "Allow connections to other hosts" ON \
"NET_INBOUND" "Allow connections from other hosts" OFF \
"LOCAL_MOUNT" "Allow mounting of local devices" OFF \
"REMOTE_MOUNT" "Allow mounting of remote devices" OFF



{
    for ((i = 0 ; i <= 100 ; i+=5)); do
      sleep 0.25
      echo $i
    done
} | whiptail --gauge ".. 7 .. Please wait while we are sleeping..." 6 50 0


