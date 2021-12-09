> **The Academic Honor Policy (see Brightspace) is applicable to all work you do in CS 3270/5270.**

# CS 3270: Programming Languages
## Project 2

## Goal

Gain further experience with Racket and functional programming.

## GitHub notes

Please see [GitHub notes](github-notes.md) for more information on cloning, committing, and pushing repositories.

## Assignment

Create a **Sudoku** solver (same as Project 1, only in Racket this time).

Sudoku is a popular puzzle where you fill in numbers on a grid, trying to keep certain conditions true. To learn more about how Sudoku works, check out <http://en.wikipedia.org/wiki/Sudoku>. You'll find a sample puzzle and an explanation of the rules.

Write a Racket program that reads a file containing an unfinished Sudoku puzzle, then solves the puzzle using a recursive backtracking algorithm. Unlike Project 1, you are being provided with the code to initialize a Sudoku board from a text file, to print the board, to get elements from the board, and set values on the board. ***Hence, you are only tasked with writing the solver***.

The input file will simply contain an *S-expression*, with each row of data in a separate list, where zeroes are used to indicate unknowns. For example, the example puzzle below (from <http://commons.wikimedia.org/wiki/Image:Sudoku-by-L2G-20050714.gif>) would be represented in an input as:

```
((5 3 0 0 7 0 0 0 0)
 (6 0 0 1 9 5 0 0 0)
 (0 9 8 0 0 0 0 6 0)
 (8 0 0 0 6 0 0 0 3)
 (4 0 0 8 0 3 0 0 1)
 (7 0 0 0 2 0 0 0 6)
 (0 6 0 0 0 0 2 8 0)
 (0 0 0 4 1 9 0 0 5)
 (0 0 0 0 8 0 0 7 9))
```

To run a working program, type `(run-sudoku)` in the REPL.

```
> (run-sudoku)

Puzzle:

0 4 3 | 0 8 0 | 2 5 0
6 0 0 | 0 0 0 | 0 0 0
0 0 0 | 0 0 1 | 0 9 4
------+-------+------
9 0 0 | 0 0 4 | 0 7 0
0 0 0 | 6 0 8 | 0 0 0
0 1 0 | 2 0 0 | 0 0 3
------+-------+------
8 2 0 | 5 0 0 | 0 0 0
0 0 0 | 0 0 0 | 0 0 5
0 3 4 | 0 9 0 | 7 1 0

cpu time: 46 real time: 35 gc time: 0

Solution:

1 4 3 | 9 8 6 | 2 5 7
6 7 9 | 4 2 5 | 3 8 1
2 8 5 | 7 3 1 | 6 9 4
------+-------+------
9 6 2 | 3 5 4 | 1 7 8
3 5 7 | 6 1 8 | 9 4 2
4 1 8 | 2 7 9 | 5 6 3
------+-------+------
8 2 1 | 5 6 7 | 4 3 9
7 9 6 | 1 4 3 | 8 2 5
5 3 4 | 8 9 2 | 7 1 6
```

The time values that are displayed are in milliseconds.

## Functional specifications

You have been provided with four Racket files:

* `src/project2.rkt`: the file where you will write your functions.
* `src/project2-test.rkt`: this file contains test cases that will test your solution.

To make your life a little easier, the `project2.rkt` file contains functions to read the input board and print a board out in the specified format, along with some other useful utilities. A list of implemented functions that are part of the starter code in `project2.rkt` are given as follows:

* `run-sudoku`: runs the sudoku solver on a puzzle. Calling just `(run-sodoku)` will run the Sudoku solver on the default puzzle in `sudoku-test1.txt` in the `txt` directory.
  To solve a different puzzle (from a different text file), pass the name of the file as a parameter (enclosed with double quotes). For example, `(run-sudoku "sudoku-test2.txt")`. The program assumes that the `sudoku-test2.txt` file is in the `txt` directory.
* `get-board-from-file`: retrieves the puzzle data from a text file and returns a board representing the puzzle as a list of lists.
* `print-row`: helper function used by `print-board`.
* `print-board`: prints the board in a nice layout. You can use this function in your code (for debugging purposes only).
* `get-value`: gets a number on the board. You can use this function in your code. For example, to get the number on the board in row two and column three, call `(get-value board 1 2)`, assuming `board` is the list of lists representing the Sudoku board. Row and column values start at zero.
* `set-value`: sets a number on the board. You can use this function in your code. For example, to set the number on the board in row five and column one, call `(set-value board 4 0 9)`, assuming `board` is the list of lists representing the Sudoku board. Row and column values start at zero. The function will return a new board where the fifth row of the first column contains the value nine.  Note that this function returns a new board that includes where the specified number has been set on the board.

Two other functions are declared that you must complete:

* `test-checkpoint-code`: This is called by some test cases to check your checkpoint code submission. You should call your implemented function or functions that determine whether it is valid to place a number at a specific position on the board from `test-checkpoint-code`.
* `solve-sudoku`: This function should call your recursive backtracking solver and, depending upon the result, either return the solved puzzle (or board) or return `null` if the puzzle has no solution. Your solution must be written in a purely functional style – the use of `set!` or similar mutation functions, is forbidden. In addition, you are prohibited from using any of the `for` or `do` constructs.

Running the program by calling `run-sudoku` allows you to run the solver on a single puzzle. This is useful if you are still working on the solver. The test cases will test all three puzzles that were provided (`sudoku-test1.txt`, `sudoku-test2.txt`, and `sudoku-impossible.txt`). Once you are ready to test all three puzzles, open `project2-test.rkt` and press the run button. As noted above, several test cases are also included to test the checkpoint portion of your submission.

## Style guidelines

* **Names:** Use proper style for names. The naming convention in Racket is to separate multi-word names with dashes. For example, a function that returns a value from a board could be called `get-board-value` and a name that is bound to a list of months could be called `month-list`. Also, use meaningful identifier names. For example, a variable that stores a speed value should be called `speed` instead of just `s`.

* **Line lengths:** No lines should exceed 100 columns.

* **Indentation:** Use proper and consistent indentation. DrRacket can help you with indentation, select **Racket | Reindent All** to reindent the entire file, or **Racket | Reindent** to reindent the selected lines of code.

* **Whitespace:** Functions should be separated by at least one empty line.

* **Global variables:** Prohibited.

* **Comments:** Use Javadoc-style comments to document all functions. For your reference, below is an example of Javadoc-style comments for a function.

   ```
  ; Returns an Image object that can then be painted on the screen.
  ;
  ; @param  url  An absolute URL giving the base location of the image.
  ; @param  name The location of the image, relative to the url argument.
  ; @return The image at the specified URL.
  ```

## Note on commenting

***Do not*** use the commenting option on DrRacket called **Comment Out with a Box** (under **Racket**). If you use this type of commenting, your source .rkt file will not be a simple text file anymore. It will not display correctly on GitHub and the Travis build will likely fail. If you need to comment out multiple lines, use multiple single line `;` comments or the **Comment Out with Semicolons** option instead.

## Grading

For comparison purposes, your solution program will be timed. We want this information so that we can compare a solution in Racket against solutions written in other programming languages. How fast your program finds a solution will ***not*** be a part of your grade – unless your solution is grossly inefficient. We define "grossly inefficient" as being 10x slower than our simple-minded solver; such a solution will be penalized 10%. Note that we will test your submission on several more puzzles in addition to the three puzzles provided for you.

Most Racket programs are interpreted. This means they run slower than most compiled code. Racket does provide a compilation option which produces much faster code. If you want to compile your code for timing purposes (you probably don't want to bother with this while developing and testing), do the following: In DrRacket, select **Racket | Create Executable...**.  Select the type to be **Distribution** and the base to be **Racket**, and press the **Create** button. This will create a ZIP file – find that file and extract its contents. In the extracted folder you will find an executable that will run 2-3 times faster than your interpreted program. Open a command prompt and navigate the directory where the executable is located. Then run the executable. [These instructions were created using DrRacket running on my Windows machine.]

A Windows executable version of our solution is available on Brightspace under **Content | Assignments** in the `sudoku-exe.zip` file. The output of the program includes the time it took to solve a puzzle. You can use this to compare with your solution. Note that the program will ask for the name of the text file containing the puzzle that you want it to solve. If you need a Windows computer, you can go to the computer lab in FGH 201 or FGH 203.

## Deliverables

To make sure everyone is making sufficient progress on this project, we will have two deadlines like Project 1. The required deliverables for each deadline is given below.

* **Checkpoint deadline**: Submission of code to date on GitHub. Your checkpoint submission should pass the eight test cases that is part of the `test-checkpoint` test suite (lines 11-57 in `project2-test.rkt`). The `test-solve` test suite (lines 59-75 in `project2-test.rkt`) includes three test cases. Hence, the total number of tests is 11 tests. For the checkpoint submission deadline, your submission should pass the first eight of those tests.

  It is expected that you have completed at least the code to determine if it is safe to place a number in a given position on the board, or alternatively that the board is still valid after having a new number placed in it. You will need include call(s) in the `test-checkpoint-code` function. The call(s) should be to functions that you implemented that test the placement of a number on the board. Note that the `test-checkpoint-code` function is passed three parameters: 1) `board`, a board 2) `row`, a row value, 3) `col`, a column value, and 4) `num`, a number value. The `test-checkpoint-code` function is expected to return either `#t` or `#f`: `#t` if `num` can be placed in row `row` and column `col` in `board`, and `#f` if it can't. Failure to have made progress to this point will cost you 10% of your final grade on the project.
* **Final deadline**: Final project submission.

## Academic honesty

As stated in class, there are many solutions to Sudoku in many different programming languages available on the Internet. Do not look at the code you may find there. Using code that you find on the Internet is unethical, and of course you would miss the learning opportunity that you get by developing this yourselves. This instructor will report any violations to the university's Honor Council.

## Additional information

The following Racket functions may be useful to you in this programming exercise.

| Function | Description |
| -------- | ----------- |
| `let` `let*` `letrec` | These functions let us create new bindings to which we can later refer. This allows us to save a computed result and refer to that result multiple times, rather than computing that result each time it is needed. See the function `run-sudoku` in the supplied starter code for an example. |
| `null?` | Tests for the `null` value or an empty list. |
| `zero?` | Test for a value being zero. |
| `equal?` | Test if its two parameters are equal. |
| `begin` | This function will evaluate its arguments in order and then return the value of the last argument as its value. This allows us to specify a sequence of expressions we wish to evaluate, one after the other. See the function `run-sudoku` in the supplied starter code for an example. Syntax: `(begin s-expr-1 s-expr-2 s-expr-3 ... s-expr-n)` |
| `quotient` | This function returns the result of integer division. Example: `(quotient row 3)` will return the integer result of `row / 3`. |
| `modulo` | This function returns the remainder after integer division, similar to Java's and C++ `%` operator. |
| `add1` `sub1` | These return the result of adding/subtracting one from their argument. For example, `(add1 5)` returns `6`. |

Decomposing your solution into several functions will allow you to test each feature independently. For example, suppose you write a function that checks whether a row already contains a number. It is not necessary to run the whole program just to test that this function works. Simply call the function in the REPL and pass test values to see what is returned by the function.

## Reminders

* Ensure that your name, VUnetID, email address, and the honor code statement appear in the header comments at the top of `project2.rkt`.

* We will run your submission on additional hidden test cases during grading.

* Do not alter any files in the project other than `project2.rkt`!

* All files necessary to run your program must reside in the GitHub.com repository.

* For full credit, your program must pass the build on GitHub. You will have to push to GitHub in order to trigger a build.
