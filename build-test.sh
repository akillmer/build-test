#!/bin/bash

# build-test.sh | https://github.com/mix-plate/build-test
# I wrote this script to help facilitate the building and testing of
# solutions to satisfy coursework at Coursera. I am complete noob when
# it comes to shell scripting, so any guidance is appreciated.

# This shell script should be executed in the directory that contains a
# single C++ source file, being your solution that you want to build and
# test. The compiler will output the program with the same name as the
# source file, then the script will execute the program.

# Test data can be passed to this script so that you can build, run,
# and test your solution with convenience. Each set of test data must
# be in its own text file, e.g. 'test0.txt', 'test1.txt', etc.
# Run the script with the filename(s): ./build-test.sh test0.txt test1.txt

# personally, I prefer starting with a clean slate
clear

# find a C++ (.cpp or .cc) file to compile for this build-test run
file=$(find ./ -maxdepth 1 -name '*.c*')
# may be better if the script expects a source file to always be specified,
# but for now this works for me (how about for you?)

if [ -z "$file" ]; then
  echo "No C++ source file found in this directory."
  exit 1
fi

# right now $file is something like, './/source.cpp'
# but I just want the filename and nothing else
file=$(basename $file) # now it's 'source.cpp'

# drop the file extension, this will be the name of the compiled program
output=$(echo $file | cut -f 1 -d '.')

# remove any pre-existing program with the same name as $output
rm $output 2> /dev/null  # suppress any warning messages if not found

echo "Compiling $file..."
$(g++ -pipe -O2 -std=c++11 -o $output "./$file")
# I use these settings because that's what my current course requires

# if $output now exists then it was compiled successfully
if [ -f "$output" ]; then
  hr="--------------------------------------------------------"
  clear

  # if there are no tests to run, so just run the program then exit
  if [ $# -eq 0 ]; then
    echo "Manually testing: $output"
    echo $hr
    echo "Provide input test data to continue..."
    eval "./$output"
    echo ""
    exit 0
  else
    testNum=0
    echo $hr

    # iterate through all of the passed test data files
    for testFile in "$@"
    do
      testNum=$((testNum+1))
      # simple header for this current test
      echo -e "$testNum / $# :: $testFile :: $output"
      echo $hr

      testData=$(cat $testFile)   # this iteration's test file
      echo "Input"
      echo "$testData"

      echo -e "\nOutput"
      eval "./$output" <<< $testData
      echo ""
      echo $hr

      # this is the last iteration, so break early (skip the next message)
      if [ $testNum -eq $# ]; then
        break
      fi

      # I personally don't like fast scrolling screens when I'm trying to
      # analyze what's going on, so give me a chance to slow it down
      read -n1 -r -p "Press space to continue..." key
      if [ "$key" = '' ]; then
        echo -e "\n$hr"
        continue
      else
        echo ""
        break
      fi
      echo $hr
    done
  fi
fi
exit 0
