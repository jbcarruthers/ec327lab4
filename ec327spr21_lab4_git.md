% Lab 4
% Version Control with git
% EC327 Spring 2021


# Introduction

The laboratory goals are help you learn about version control and `git`


This laboratory is due Friday Mar 26th, 2021  at 23:59 (i.e. 11:59pm), 
with a late  window of $H=24$ hours 

If the *natural grade* on the lab is $g$, the number of hours late is $h$,
and the number of hours in the late window is $H$, the 
new grade will be

    (h > H) ? 0 : g * (1- h/(2*H))

If the same lab is submitted ontime *and* late, the grade for that component will
be the maximum of the ontime submission grade and the scaled late submission grade.


This lab must be submitted by all students individually.


This lab is worth 2 points.


You can submit here: [Lab4 submit link](https://curl.bu.edu:32721/submit_assignment/lab4)

# Background

This lab will focus on the use of `git` as a system for
collaboration and version control.

Among the thigs that `git` can do:

- documentthe progress of a project
- allow for team members to contribute to a project in parallel
- allow for "going back" to earlier versions of the project

This is the wikipedia definition:

    Git is software for tracking changes
    in any set of files (directorial, textual or even binary),
    usually used for coordinating work among programmers
    collaboratively developing source code during software development

## `xkcd` on `git`

The more you use `git`, the funnier these comics become.

![xkcd: The beauty of git](https://imgs.xkcd.com/comics/git.png)

![xkcd: Learning to commit](https://imgs.xkcd.com/comics/git_commit.png)

## Learning about `git`

### The basics

The core concept of `git` is that of a repository. You can think of a repository
or a *repo* as a project. It is actually a collection of 
files together with history information that can be replicated and managed via clones.

The key operations in git are

- creating and/or copying a repo
- making changes to the repo
- merging those changes into the main branch.

### Web resources

- [Official Doc page at git-scm](https://git-scm.com/doc)
- [Git cheat sheet from github](https://training.github.com/downloads/github-git-cheat-sheet.pdf)
- [Git User Manual](https://git-scm.com/docs/user-manual.html)
- [Git Quick Reference](https://git-scm.com/docs/user-manual.html#git-quick-start)

Obviously, there is a ton of content on youtube. If you find something 
you really find helpful, please post it to piazza for all to enjoy.


### Built in help from `git` program

Here are examples of accessing the `git` help system from the terminal.

```
git help
```

```
git help commit
```

```
man gittutorial
```

```
man giteveryday
```


# The Assignment

In this assignment, you will

- install git and/or git desktop
- build your own project
- make a clone of a github repo
- make a clone of your own local repo


## Getting Started

### Install `git`

```
sudo apt install git
```

If you are interested, you can also try one of the Git Desktop applications
for Mac  / Windows or Linux, linked to from here:

[GUI clients for git](https://git-scm.com/downloads/guis)


### Renaming the branch to `main`

As of Oct 2020, the `git` community decided to change the default branch name from
`master` to `main`. This is now the default for all projects hosted on `github.com`.
Unfortunately, much of the documentation still uses the old terminology. 


In particular, this change is not completed yet for the version of `git` we are
downloading, so please follow these steps to make the change yourself

```
mkdir ~/.git-template
git config --global init.templateDir ~/.git-template
subl ~/.git-template/HEAD
```

The content of the file `~/.git-template/HEAD` should be one line, as follows:


```
ref: refs/heads/main
```

The word `main` is conventional but arbitrary. Some people use `dev` or `beta` or `production`
and so forth.

## Identify yourself

At some point, `git` is going to insist that you identify yourself. This is to enable
multi-user projects, but it is also useful to you as an author to help with copyright
issues for your own work.

Type the following commands:

```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

changing the last field to match your own information.

Please use your BU email address for the `user.email` field.


## Build your own repository

We will now build a *repo* called `mylab4project`, and then populate it
with several files.

### Build the repo

```
git init mylab4project
cd mylab4project
```

### Add files 

Now, we need to add files to the project.

a. Create a C++ program (using your normal editor or IDE) that prints 
"Hello World" to the terminal, called "hello.cpp" and put it into `~/mylab4project`

b. Create a text file called `README.md` and put it into `~/mylab4project`

This file can contain anything, but it should have at least one line like
this

```
# About myproject
```

Compile and run `hello.cpp`. This will create an executable file that is
in the directory `~/mylab4project` but won't be added to the repo.


The final step is to tell `git` that these files should be part of 
the repo:

```
git add hello.cpp README.md
```

Try 
```
git status
```

and you will see that these changes are pending (need to be committed).

### Commit the changes

The commit command makes your changes "official".

In terminal (make sure the working directory is `~/mylab4project`)

```
git commit -m"hello world program"
```

Now try
```
git status
git log
```

to see what has happened with your repo.

## Cloning from `github.com`

You can make a local copy (called a clone) of public projects hosted by [github.com](github.com), 
and you can also register and use github as a collaboration space or as a portfolio.

For now, just make a clone of `https://github.com/jbcarruthers/ec327lab4.git` using

```
cd ~/
git clone https://github.com/jbcarruthers/ec327lab4.git
```

To prove you have done this successfully, do the following:
```
cd ~/ec327lab4
git log > ~/mylab4project/logfile.txt
cd ~/mylab4project
git add logfile.txt
git commit -m"add the logfile"
```

This sequence of commands saves the log of the `ec327lab4` project clone, and saves it
as a text file in the `mylab4project` repo.

## Cloning locally

You can back up your `git` repos using the clone command. In this example, the repo
contained in `~/mylab4project` is cloned (copied) into `~/clonedlab4`


```
cd
git clone mylab4project clonedlab4
```

## So much more

There is way too much to cover in a single lab, but if you are interested, please
learn in particular about these git operations

- push and pull
- revert
- branch, checkout, and merge
- tag

# Lab Submission

To gather your files, do the following

```
zip -r mylab4.zip mylab4project clonedlab4 ec327lab4
```

which packs all three repos into one zip file called `mylab4.zip`

Submit this `zip` file when you are finished.
