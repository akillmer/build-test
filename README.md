build-test.sh
=======

Lately I've been pursuing some online classes that focus on C++, specifically with algorithms and data structures. In these courses you develop on your local machine, then submit your code to the server where it undergoes testing.

I wrote this little script to help facilitate my process of coding, building, testing, then back to coding. This script handles the *build-test* part.

This is my first bash script and as such it could be much better. I would appreciate anyone's input. I certainly do hope you find this script helpful, too.

Setting up the script
-------
I recommend that you create a symbolic link of this script to `/usr/local/bin/build-test` or your system's equivalent. Note that I dropped the file extension of `.sh` as a personal preference.
~~~~
sudo ln -s /path/to/build-test.sh /usr/local/bin/build-test
~~~~
Now you can run this script anywhere by running the command `build-test`. But you may need to give the script permission to execute, so in that case:
~~~~
sudo chmod a+x /usr/local/bin/build-test
~~~~

Using the script
-----
So far all of my coding on a per-assignment basis has been contained within a single C++ file. The behavior of this script represents that.

You'll need to be in the current working directory of the code that you want to build and test. When you run the script it will compile the first `.cpp` or `.cc` file it finds. *You will have to modify the script to compile C programs (see default compiler below).*

If there are no test data files passed as arguments to the script then your program executes and it's business as usual.

Providing test input data files
-----
Individual test cases should be within its own text file in the same directory of the code that you are testing. Each line from this text file is sent to your program as input. For example, if your program expects two `int` values via `std::cin`, then your text file will have those two values on separate lines.
~~~~
build-test test0.txt test1.txt test2.txt ...
~~~~

Script's default compiler
-----
~~~~
g++ -pipe -O2 -std=c++11
~~~~
Change this in the script to suit your particular needs.


Why bother with all this?
-----
This was ultimately for my convenience, obviously, to help speed up my coursework. Typically when you receive an assignment you're given some sample problems with solutions. So these sample problems become your initial test input data files.

Then as you start exploring edge cases you can create more test files, without having to retype the input to your program every time you try again. Since your test files persist you can take that much deserved break and come back later.

Also, I personally wanted to try out some bash scripting. I think I like it!

Ideas for improvement
----
  * Provide solutions with test input data files to compare against program's output
  * Is it possible to record metrics? Such as memory used, execution time, etc?
  * This README is too wordy and needs to be shortened, but thanks for reading. :)
