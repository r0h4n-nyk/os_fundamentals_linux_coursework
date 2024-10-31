#!/bin/bash

generate_password() {
  length=$1

  # Define character sets
  uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  lowercase="abcdefghijklmnopqrstuvwxyz"
  numbers="0123456789"
  special="!@#\$%^&*()_+-=[]{}|:<>?/"
  
  
  # Concatenation
  all_characters="$uppercase$lowercase$numbers$special"


  # Generation
  password=""
  for i in $(seq 1 $length); do
    random_char="${all_characters:RANDOM % ${#all_characters}:1}"
    password+="$random_char"
  done

  # Display the generated password and its length
  echo "Generated password ($length characters): $password"
}


# User input
while true; do
  read -p "Enter the desired password length (12-32): " password_length
  
  # Validate input
  if [[ "$password_length" =~ ^[0-9]+$ ]] && (( password_length >= 12 && password_length <= 32 )); then
    break
  else
    echo "Invalid input. Please enter a number between 12 and 32."
  fi
done


# Generate the password
generate_password "$password_length"
