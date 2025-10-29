#!/bin/bash

# Script to generate a new GetX module

# --- SCRIPT SETUP ---
# Get the directory path where the script is located
SCRIPT_DIR=$(dirname -- "$0")
# Change to the project root directory (one level above 'scripts')
cd "$SCRIPT_DIR/.." || exit

# --- ARGUMENT PARSING ---
# Default values
OUTPUT_DIR="lib/src/modules"
MODULE_NAME=""

# Parse arguments for the -o flag
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -o)
      OUTPUT_DIR="$2"
      shift # past argument
      shift # past value
      ;;
    *)
      # Assume the first non-flag argument is the module name
      if [ -z "$MODULE_NAME" ]; then
        MODULE_NAME="$1"
        shift # past argument
      else
        echo "Error: Unknown argument or duplicate module name: $1"
        echo "Usage: ./scripts/generate_getx_module.sh <module_name> [-o <output_directory>]"
        exit 1
      fi
      ;;
  esac
done

# --- VALIDATION ---
# Validate that the module name has been provided
if [ -z "$MODULE_NAME" ]; then
  echo "Error: You must provide the module name."
  echo "Usage: ./scripts/generate_getx_module.sh <module_name> [-o <output_directory>]"
  exit 1
fi

# --- EXECUTION ---
echo "Generating module '$MODULE_NAME' in '$OUTPUT_DIR'..."

# Execute the Dart script with the corresponding arguments
dart run scripts/generate_module.dart --name "$MODULE_NAME" --output "$OUTPUT_DIR"
