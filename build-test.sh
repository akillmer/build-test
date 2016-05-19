#!/bin/bash
# build-test.sh | https://github.com/mix-plate/build-test
# I know this script could use a lot of improvement, so please
# feel free to contribute! Thanks!

clear # personally, I prefer starting with a clean slate

# find a C++ (.cpp or .cc) file to compile for this build-test run
file=$(find ./ -maxdepth 1 -name '*.c*')

if [ -z "$file" ]; then
  echo "No compilable source file found in this directory."
  exit 1
fi

# right now $file is something like, './/source.cpp'
# but I just want the filename and nothing else
file=$(basename $file) # now it's 'source.cpp'

# drop the file extension, this will be the name of the compiled program
program=$(echo $file | cut -f 1 -d '.')

# remove any pre-existing program with the same name as $program
rm $program 2> /dev/null  # suppress any warning messages if not found

echo "Compiling $file..."
$(g++ -pipe -O2 -std=c++11 -o $program "./$file")
# I use these settings because that's what my current course requires

# if $program now exists then it was compiled successfully
if [ -f "$program" ]; then
  hr="--------------------------------------------------------"
  clear

  # if there are no tests to run, so just run the program then exit
  if [ $# -eq 0 ]; then
    echo "Manually testing: $program"
    echo $hr
    echo "Provide input test data to continue..."
    eval "./$program"
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
      echo -e "$testNum / $# :: $testFile :: $program"
      echo $hr

      inputFile="$testFile.input"
      outputFile="$testFile.output"

      if [ ! -f $inputFile ]; then
        echo "$inputFile not found"
        exit 0
      fi

      inputData=$(cat "$inputFile")   # this iteration's test input data
      result=$(eval "./$program" <<< $inputData)

      echo "Test Input:"
      echo "$inputData"

      echo -e "\nYour Output:"
      echo "$result"
      echo ""

      # is there a correspanding $testFile.output to results to?
      if [ -f $outputFile ]; then
        # compare program output to $outputFile
        diffResults=$(diff $outputFile <(echo "$result"))

        if [ "$diffResults" != "" ]; then
          # contents are not the same
          echo "FAILED, expected output:"
          echo "$(cat "$outputFile")"
        else
          echo "PASSED, good job!"
        fi
      fi

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
