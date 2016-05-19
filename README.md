build-test.sh
=======

This is a simple bash script (my first, actually) to help automate building and testing simple programs written in C++. I've been using this for a series of assignments over at Coursera. Currently, as I'm focusing on C++, the compiler is set to `g++ -pipe -O2 -std=c++11`, this is at line 27.

Within a directory you must have a single CPP source file (like I said, for *simple programs*) and your test input/output files (optional). If you run `build-test` without specifying a test, then the first CPP file it finds is compiled and will execute your program.

There are two files when it comes to testing your program: an `.input` file and an `.output` file. Only the extension matters, not the filename itself. Then to specify a test you just pass the filename *without* the extension. For example, I have `test0.input` and `test0.output`. To test this I run `build-test test0`. You can pass multiple tests, too, such as `build-test test0 test1 test2`.

Check out the `demo` folder for an example.

Thank you.

**TODO:**
- Combine `.input` file and `.output` file into a single `.test` file.
- Support different compiler and settings as I (or you) need them
- Handle larger projects as my assignments get more complicated.
