#!/bin/bash

workers="2"

column="link"

result="result"

file="labelled_newscatcher_dataset.csv"

while getopts ":n:w:o:d:" opt; do
  case $opt in
    n) column="$OPTARG"
    ;;
    w) workers="$OPTARG"
    ;;
    o) result="$OPTARG"
    ;;
    d) file="$OPTARG"
	;;
    \?) echo "error: Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "error: Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

number=$(head -1 $file | tr ';' '\n' | nl | grep -w "$column" | tr -d " " | awk -F " " '{print $1}')

cat $file | awk -F ";" -v n=$number 'NR>=2 { print $n }' | parallel --progress -j $workers wget -q {} -P "$result"
    
