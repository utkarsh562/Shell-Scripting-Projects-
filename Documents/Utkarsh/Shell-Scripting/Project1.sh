#!/bin/bash

######################################
# I'm Going to write the bash Script that
# provide the options for managing the user
# Accounts on the System. 
# this Script allow user to perform many actions on the 
# basis of account related on the command line interface.
#######################################

function display_usage {
	echo "Usage $0 [OPTIONS]"
	echo "Options" :
	echo " -c,  --create                Create a new user Account"
	echo " -d,  --delete                Delete an exixting user account "
	echo " -r,  --reset                 Reset password for an existing user account"
	echo " -l,  --list                  List all user account on the system"
	echo " -h,  --help                  Display this help and exit"

}

function create_user {
	read -p "Enter the new Username : " username
	
	if id "$username" &>/dev/null; then
		echo "ERROR: This account is already exist . Please choose  a different account "
	else
		read -p " Enter the password for $username : " password
		useradd -m -p "$password" "$username"
		echo " User account '$username' created Successfully."

	fi

}

function delete_user {
	read -p "Enter the username to delete : " username

	if id "$username" &>/dev/null; then
		userdel -r "$username" 
		echo "User Account $username deleted Successfully!!!!"
	else
		echo " This username $username doesn't exist. Please enter the Valid username. "
	
	fi
}

function reset_password {
	read -p " Enter the username to reset the password : " username
	
	if id "$username" &>/dev/null; then
		read -p "Enter the new password for username : $username " password
		echo " $username:$password " | chpasswd
		echo " Password for the username $username chnaged Successfully!! "
	else
		echo " This user $username  doesn't exist. Please enter the valid username. "
	fi
}

function list_users {
    echo "User accounts on the system:"
    cat /etc/passwd | awk -F: '{ print "- " $1 " (UID: " $3 ")" }'
}

if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    display_usage
    exit 0
fi

while [ $# -gt 0 ]; do
    case "$1" in
        -c|--create)
            create_user
            ;;
        -d|--delete)
            delete_user
            ;;
        -r|--reset)
            reset_password
            ;;
        -l|--list)
            list_users
            ;;
        *)
            echo "Error: Invalid option '$1'. Use '--help' to see available options."
            exit 1
            ;;
    esac
    shift
  
 done



