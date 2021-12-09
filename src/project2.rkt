#lang racket

(provide get-board-from-file)
(provide print-board)
(provide get-value)
(provide set-value)
(provide test-checkpoint-code)
(provide solve-sudoku)

; Name: Qibang Zhu
; VUnetID: zhuq2
; Email: qibang.zhu@vanderbilt.edu
; Course: CS 3270 - Vanderbilt University
; Date: April 1, 2021
; Honor Stetement: I have not given or received any unauthorized help on this assignment.

; Description: Create a Sudoku solver in Racket language.


; Define some global constants.
(define BOARD-SIZE 9)       ; The size of the board.
(define ROWS 9)             ; The number of rows.
(define COLS 9)             ; The number of columns.
(define GRID-SIZE 3)        ; The size of a subgrid.


; Specify default file to load puzzle from.
(define default-file-location
  (build-path 'up "txt" "sudoku-test1.txt"))


; Entry point to the sudoku solver with textual output.
; Times the solution function.
;
; This function accepts zero or one parameter.
;
; Calling just (run-sodoku) will run the Sudoku solver on the 
; default puzzle in sudoku-test1.txt in the "txt" directory.
;
; To solve a different puzzle (in a different text file),
; pass the name of the file as a parameter (enclosed with
; double quotes). For example, (run-sudoku "sudoku-test2.txt")
; It is assumed that the file is in the "txt" directory.
;
; @param  args An optional parameter to specify text file to load.
(define (run-sudoku . args)
  (let ([board (if (= (length args) 1)
                   (get-board-from-file (build-path 'up "txt" (car args)))
                   (get-board-from-file default-file-location))])
    (if board
        (begin
          (displayln "")
          (displayln "Puzzle:")
          (displayln "")
          (print-board board)
          (displayln "")
          (let ([solution (time (solve-sudoku board))])
            (if (null? solution)
                (displayln "No solution")
                (begin
                  (displayln "")
                  (displayln "Solution:")
                  (displayln "")
                  (print-board solution)
                  (displayln "")))))
        (displayln "There is no board to process"))))


; Loads a board from the given file.
; It expects the board to be in the format of a single S-expression:
; a list of nine lists, each containing nine numbers.
;
; @param  file-location The location of file to load.
(define (get-board-from-file file-location)
  (let ([in (open-input-file file-location #:mode 'text)])
    (read in)))
    

; Prints a board.
;
; @param  board The board to print.
(define (print-board board)
  (begin
    (print-row (list-ref board 0))
    (print-row (list-ref board 1))
    (print-row (list-ref board 2))
    (printf "------+-------+------ ~n")
    (print-row (list-ref board 3))
    (print-row (list-ref board 4))
    (print-row (list-ref board 5))
    (printf "------+-------+------ ~n")
    (print-row (list-ref board 6))
    (print-row (list-ref board 7))
    (print-row (list-ref board 8))))


; Print a row of the board with dividing lines.
;
; @param  row The row of the board to print.
(define (print-row row)
  (printf "~a ~a ~a | ~a ~a ~a | ~a ~a ~a ~n"
          (list-ref row 0)
          (list-ref row 1)
          (list-ref row 2)
          (list-ref row 3)
          (list-ref row 4)
          (list-ref row 5)
          (list-ref row 6)
          (list-ref row 7)
          (list-ref row 8)))


; Returns the value on the board at a specified row and column.
;
; @param  board The board where the value is located.
; @param  row   The row of the value.
; @param  col   The column of the value.
; @return The value at row and col of board.
(define (get-value board row col)
  (list-ref (list-ref board row) col))

  
; Places a given value in the specified row and column and
; return the new board.
; Note: non-destructive! It returns a new board.
;
; @param  board The initial board that will be added value.
; @param  row   The row of the value.
; @param  col   The column of the value.
; @param  num   The number to set on the board.
; @return A new copy of the board where value is placed at row and col.
(define (set-value board row col num)
  (list-set board row (list-set (list-ref board row) col num)))


; Returns the result of checking if a value can be placed at
; a specific row and column on a board.
;
; It is your job to call your implemented "checker" functions
; from this function so it can be tested for the checkpoint
; requirements.
;
; DO NOT change the name/signature of this function, as our
; testing script depends upon it.
;
; @param  board The board to check.
; @param  row   The row where the value will be placed.
; @param  col   The column where the value will be placed.
; @param  num   The number to be placed.
; @return Whether value can be placed at row and col in board.
(define (test-checkpoint-code board row col num)
   (let ([row-trans (* GRID-SIZE (quotient row GRID-SIZE))]
         [col-trans (* GRID-SIZE (quotient col GRID-SIZE))])
    [and (and (check-row board row 0 num) (check-col board 0 col num))
         (check-box board (+ row-trans GRID-SIZE) (+ col-trans GRID-SIZE) row-trans col-trans num)
    ]
   )
)


; This function should call your recursive backtracking solver
; and, depending upon the result, either return the solved puzzle
; or return null if the puzzle has no solution.
;
; It is your job to write this and necessary helper functions.
;
; DO NOT change the name/signature of this function, as our
; testing script depends upon it.
; @param  board The board to solve.
;
(define (solve-sudoku board)
  ; This function is called in the solve-sudoku method to recursively
; traverse the board and try each number to solve the soduku
;
; @param  board  The board to be solved.
; @param  row    The row where the value is at.
; @param  col    The column where the value is at.
; @param  num    The value we try to put in the soduku.
; return The solved soduku is solvable or null if not solvatble
  (define (recursive-solver board row col num)
   (cond
    ((= col COLS) board)
    ((> num BOARD-SIZE) null)
    ((= row ROWS) (recursive-solver board 0 (+ 1 col) num))
    [(positive? (get-value board row col)) (recursive-solver board (+ 1 row) col num)]
    ((test-checkpoint-code board row col num)
      (let ([solved (recursive-solver (set-value board row col num) (+ 1 row) col 0)])
       (cond[(not (null? solved)) solved]
        [else (recursive-solver (set-value board row col 0) row col (+ 1 num))])))
      ((recursive-solver board row col (+ 1 num)))))
  (recursive-solver board 0 0 1)
) 

; This function checks whether the given num is in the given col
;
; @param  board The board to check.
; @param  row   The row where the value will be placed.
; @param  col   The column where the value will be placed.
; @param  num   The number to be placed.
; @return Whether the given num is in the given col
(define (check-col board row col num)
  [cond
    [(equal? row ROWS) #t]
    [(equal? num (get-value board row col)) #f]
    [else (check-col board (+ 1 row) col num)]])

; This function checks whether the given num is in the given row
;
; @param  board The board to check.
; @param  row   The row where the value will be placed.
; @param  col   The column where the value will be placed.
; @param  num   The number to be placed.
; @return Whether the given num is in the given row
(define (check-row board row col num)
  [cond
    [(equal? col COLS) #t]
    [(equal? num (get-value board row col)) #f]
    [else (check-row board row (+ 1 col) num)]])

; This function checks whether the given num is in the given box
;
; @param  board The board to check.
; @param  r1    The upper bound of the row of the box 
; @param  c1    The upper bound of the column of the box 
; @param  row   The row where the value will be placed.
; @param  col   The column where the value will be placed.
; @param  num   The number to be placed.
; @return Whether the given num is in the given box
(define (check-box board r1 c1 row col num)
  [cond
    [(= col c1) #t]
    [(= row r1) (check-box board r1 c1 (- row GRID-SIZE) (+ col 1) num)]
    [(= num (get-value board row col)) #f ]
    [(< row r1) (check-box board r1 c1 (+ row 1) col num)]])

; Add your other functions here.