#!/bin/bash

for arg in "$@"; do
  shift
  case "$arg" in
    "--input") 			set -- "$@" "-h" ;;
    "--train_ratio") 	set -- "$@" "-r" ;;
    *)        			set -- "$@" "$arg"
  esac
done

file="dataset.csv"
train_ratio="0.5"

# Parse short options
OPTIND=1
while getopts "hrw" opt
do
  case "$opt" in
    "h") file=$2 ;;
    "r") train_ratio=$2 ;;
    "?") print_usage >&2; exit 1 ;;
  esac
done
shift $(expr $OPTIND - 1)

train=$(awk "BEGIN {print int(($(cat $file | wc -l) - 1) * $train_ratio)}")
test=$(awk "BEGIN {print $train + 1}")

echo "$(head -1 $file)" > train.csv
echo "$(head -1 $file)" > test.csv

awk -F ","  -v end="$train" 'NR>=2 && NR<=end { print }' $file >> train.csv
awk -F "," -v start="$test" -v end="$(cat $file | wc -l)" 'NR>=start && NR<=end { print }' $file >> test.csv
