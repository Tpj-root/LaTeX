#!/bin/bash

# Script Name: clean.sh
# Description: A brief description of what the script does.
# Author: Your Name
# Date: 

# --- Global Variables (Optional) ---
# EXAMPLE_VAR="Hello World"

# --- Functions ---

function greet_user() {
  local name="$1"
  echo "Hello, $name!"
}

# --- Main Program ---

# if [[ -z "$1" ]]; then
#   echo "Usage: $0 <name>"
#   exit 1
# fi

echo rm -rf *.log *.aux
sudo rm -rf *.log *.aux

exit 0
