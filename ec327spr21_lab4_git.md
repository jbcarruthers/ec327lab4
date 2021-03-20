% Lab 3
% Version Control with git
% EC327 Spring 2021

![xkcd: The beauty of git](https://imgs.xkcd.com/comics/git.png)

# Introduction

The laboratory goals are help you learn about

- general debugging operations
- using the debugger to find seg faults
- using the debugger to find exceptions


This laboratory is due Friday Mar 5th, 2021  at 23:59 (i.e. 11:59pm), with a late 
window of $H=24$ hours 

If the *natural grade* on the lab is $g$, the number of hours late is $h$,
and the number of hours in the late window is $H$, the 
new grade will be

    (h > H) ? 0 : g * (1- h/(2*H))

If the same lab is submitted ontime *and* late, the grade for that component will
be the maximum of the ontime submission grade and the scaled late submission grade.


This lab must be submitted by all students individually.


This lab is worth 2 points.


You can submit here: [Lab3 submit link](https://curl.bu.edu:32721/submit_assignment/lab3)

# Background

This lab will focus on the use of `gdb` the command line debugger. However, the debugger
is only one of many tools that can and should be used to develop and test software.

Here are some other suggestions.

## Debugging Techniques

### Getting programs to compile

- add code slowly, compile often
- only deal with the first compilation error, many of the
others may be caused by the first one
- check your `include` statement, include guards and namespace usage
- get back to a compilable program by commenting out code
- use an IDE or syntax-highlighting editor to help identify correct syntax
- Stuck? Start over with a clean program, and follow steps above

### Debugging Running Programs: Strategies

- Write test suites to exercise your code
- Simplify your main() to be the smallest program that replicates the problem
- Add "print" statements to understand the flow of your program and variable values
- Compare and contrast a working example and a non-working example
- Run a debugger

## GDB

gdb is a debugging tool which allows one to do these and other operations:

- Step-by-step execution
- Breakpoints
- Watchpoints
- Memory content and variable value examination
- Backtracing


## Compiling for `gdb`

C++ programs need to have debugging information embedded in the executable 
that `g++` creates, using the `-g` flag, as follows:

```
g++ -g myprog.cpp -o myprog
```

Now, the debugger can be run using

```
gdb myprog
```


### gdb: Running the program

Here are the essential commands for getting things done in gdb.

- run: start running the program under test
- break line_number : stop execution when the line_number is reached
- step: next line, go into the function if called
- next: next line, dont examine the function line-by-line
- continue: continue running the program until a breakpoint is hit.
- return: immediately exit the current function.
- list: show a chunk of source cocde
- print  *expression*: print out a value
- ptype  *variable*
- info local
- info breakpoints
- help: launch the built-in help system
- quit: exit `gdb`

Most of these commands have a single letter shortcut, especially useful
when stepping line by line, just type `n` and enter/return.

### Resources for learning more

#### `gdb` itself.

Using a working Linux-based C++ development environment, like the VM, open a terminal and
try

```
man gdb
gdb --help
```

 Run `gdb` and type `help`

#### User Manuals and Guides

- [official gdb documentation](http://www.gnu.org/software/gdb/documentation)
- [manual](https://sourceware.org/gdb/current/onlinedocs/gdb/)
- [GDB quick reference](https://curl.bu.edu:32721/static/content/ec327_spring2021/gdb-refcard-v5.pdf)


# The Assignment

## Getting Started

Download the file [ec327spr21_lab3.zip](https://curl.bu.edu:32721/static/content/ec327_spring2021/ec327spr21_lab3.zip)
using the link or with

```
cget ec327spr21_lab3.zip
```

which contains the following files:

- gdb-refcard-v5.pdf
- calclog.cpp
- sheep.cpp
- fibonnaci.cpp
- tichu.cpp

The first file is for you to read and refer to while working with `gdb`.
In the VM, you can view it using

```
xdg-open gdb-refcard-v5.pdf
```

## Debug Capture / Lab Documentation

We will use a linux technique to capture your work and document
that you completed the lab. For example, when you 
debug `calclog.cpp` you can document your work using

```
gdb calclog | tee debug_calclog.txt
```

This allows you to run the program
```
gdb calclog
```
and interact normally with the program, while the rest of
the command `| tee debug_calclog.txt` causes everything 
you type, and all the responses of `gdb`, to be saved into
a file. You can read the documentation for `tee` if you 
want to understand how this works (although it is not
required for this lab).


## Breakpoints: debugging `calclog`

Compile and run `calclog.cpp` and verify that it does not work. 
Try to calculate the natural log of 10.

We will explore a few features of `gdb` and in the process discover
the bug in `calclog.cpp`

Try the following commands to debug this program. 

Run

    gdb calclog | tee debug_calclog.txt

and then do the following:


1. Type the command `list` to see where you are

2. Set breakpoints at lines 10, 14, and 19

3. Use the `info breakpoints` command to confirm you have the breakpoints
   properly set.

4. Begin execution with `run`. The debugger should be waiting to execute 
   line 10.

5. Each time you hit those breakpoints, use `print` to show both the value and 
   the address of the variable lognum using

        print lognum
        print &lognum

   then continue (c) execution to go to the next one.

You should have observed something unusual with this variable.


Now, run the program again, but this time, before continuing, also use the examine command like this

        x/gf  ADDR

for both of the addresses of `lognum` as discovered by your 
print commands. This command shows the contents of memory 
address ADDR interpreted as a floating point number 
(that is what the `f` is for) of word size giant 
(that is what the `g` is for, representing 8 bytes, i.e. a double).

Before exiting, use the help system to show the information about the examine command:

        help x


If done correctly, you should be able to display the natural log of 10 using
the debugger output as described in the above steps.


## Watchpoints: debugging `sheep.cpp`


Compile and run `sheep.cpp`. This
program is supposed to print out the multiples of 1000 forever. Verify that the "infinite loop" is
not infinite at all.

Now, debug the program using

    gdb sheep | tee debug_sheep.txt

and try out the following `gdb` commands.

1. Set a breakpoint on the line where `counter` is created, then
   run

2. Take a look at the local variables using

        info locals

3. We want to investigate what is happening, 
   so we use a watchpoint. In this case, we 
   are going to stop the program when i becomes 0, like this

        watch i==0

   Technically, what a watchpoint does is stop when the expression changes value,
   in this case from false to true.

4. When the watchpoint has been reached, show the value of `counter` using one 
   or more of the following:

        print counter
        info locals

5. Exit the debugger with `quit`

In more complicated code, we could use a watchpoint to
examine other variables and the call stack when an error
condition that we are interested in fixing occurs.

Use the debugger or other information to answer Q2 in
3.7 (what is the largest value that `i` achieves
before the program exits?)

## Seg fault: fibonacci.cpp

Compile and run the program `fibonacci.cpp` and verify that it (more or less)
calculates the fibonnaci number of the value entered. Try, for example, 6.

Now, we will attempt (and succeed) in causing this program to crash.
Enter the number -6. 

You should see something like this:

```
> fibonacci                
Enter a number x to calculate F_x :-6
zsh: segmentation fault (core dumped)  fibonacci
```

You have experienced a segmentation fault (you will experience many more!). This means your program has attempted to access memory beyond the reach of its allocated space in your computer, and the operating system has chosen to kill the
running program because of this problem.

We will now use `gdb` to find out what happened.

Run


    gdb fibonacci | tee debug_fibonacci.txt

and then try the following:

1. Run the program, and enter -6 as the value of x.

2. The program will crash (seg fault). Notice that the 
   function in which the program crashed is displayed. 
   Type the command

    backtrace 10

   and 

    backtrace -10


   to see the top and the bottom of the call stack.

3. Quit

Thats it-- we have successfully used the debugger to find the location
of our segmentation fault. In a real debugging situation, the hard
work of fixing the problem would begin.

## Out of range exception: `tichu.cpp`


Compile and run `tichu.cpp` and verify that it crashes with 
an out of range error.


Run


    gdb tichu | tee debug_tichu.txt

and then try the following:

1. Run the program, and when it crashes, type one of the following
   three commands: `backtrace, bt, where`. They all do the same thing.

2. Now, set a catchpoint to stop when an exception is throw, like this:

    catch throw

   This tells the debugger to catch the thrown exception, rather than 
   letting the program crash. Run the program again, and show the backtrace again.

3. Now that we now where and when the program is crashing, lets set a 
   conditional breakpoint for the line

        cout << show_card(c) << "\n";


   like this:


        break tichu.cpp:59 if c==52

   Run the program again. The breakpoint should activate.

4. Show the key variables:

        print c
        print deck
        print hands

5. Now, lets follow execution into the `show_card` function using the step 
   into command:

        step

   Execution should be on line 26, the start of the function.

6. Go step-by-step through the function, using `next`, until the program crashes.
   We also want to monitor the value of `c`. So, we first 

        display c

   then type `n` repeatedly until the crash occurs. We should now understand the out of range problem.


Create a copy of `tichu.cpp` called `tichu_brackets.cpp` and replace each call to 
the `at` method to use brackets `[  ]`

Compile and run the program. Does it crash? What does it print out?



## Further Questions

Answer the following questions by editing the file `lab3_questions.txt`
and inserting your answers. Here is an example (with incorrect answers)

This is the contents of `lab3_questions.txt`:

```
INSTRUCTIONS

Please answer the following questions.
Replace the fake answers with the real ones.
Include the modified file in your submitted zip file.

Note: file line numbers begin at 1.

QUESTIONS

Q1. What is the one word that can be removed from `calclog.cpp` that 
fixes the program? What line is that word on?

cin
11

Q2. In sheep, what is the largest value that `i` achieves?

1000

Q3. The Fibonacci number sequence generated by `fibonnacci` is not correct
for positive input values. What line number contains the mistake?

6

Q4. In tichu, what is the name of the vector that is accessed out of its
range?

deck

Q5. What is the last line of output that both `tichu` and `tichu_brackets`
both print out before their behaviors diverge (i.e. one crashes, one continues)

J Pagoda

```



# Lab Submission

Create a zip file (name is arbitrary) with the following content

- debug_calclog.txt
- debug_sheep.txt
- debug_tichu.txt
- debug_fibonacci.txt
- lab3_questions.txt with the answers completed.



and then submit the zip file. Please test your content using

```
unzip -t mylab3.zip
```

before you submit to make sure those five files are included.



