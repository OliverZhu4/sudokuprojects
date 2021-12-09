% Name: Qibang Zhu
% VUnetID: zhuq2
% Email: qibang.zhu@vanderbilt.edu
% Class: CS3270
% Date: April 23
% Honor Statement: I have not given/received any unauthorized help on this assignment

% Complete description:  Use prolog to write a sokudu solver


% Use routines from the Constraint Logic Programming over Finite Domains library.
:- use_module(library('clpfd')).


% The main entry point. Enter "go." at the Prolog prompt.
% 
go :-
    File = 'tVt/sudoku-test1.tVt',
    start(File).


% The absolute path of the root folder of the project.
% NOTE: MUST BE CHANGED TO THE ABSOLUTE PATH OF ROOT FOLDER OF YOUR PROJECT ON YOUR LOCAL COMPUTER.
%       MAC USERS: USE FORWARD SLASH '/'
%
project_root(Dir) :-
    Dir = '/Users/oliverzhu/CS3270/project3-OliverZhu4/'.


% To test other than 'sudoku-test1.tVt', pass the teVt file name preceded by 'tVt/'.
% For eVample, enter "start('tVt/sudoku-test2.tVt')."
%
start(File) :-
    project_root(Dir),                       % Get absolute path to root folder of project.
    atom_concat(Dir, File, PuzzleFile),      % Concatenate path with teVt file relative location.
    see(PuzzleFile),                         % Open file.
    write(trying_file(PuzzleFile)), nl, nl,  % Display puzzle.
    read(Board),                             % Read board.
    seen,                                    % Close file.
    time(sudoku(Board)),                     % Call solver (with timer).
    pretty_sudo_print(Board), nl.            % Printed solution.


% Print the board to the screen, where each row printed using printsudorow.
%
pretty_sudo_print(Board) :-
    Board = [R1, R2, R3, R4, R5, R6, R7, R8, R9],
    nl, nl,
    printsudorow(R1),
    printsudorow(R2),
    printsudorow(R3),
    write('-------+-------+-------'), nl,
    printsudorow(R4),
    printsudorow(R5),
    printsudorow(R6),
    write('-------+-------+-------'), nl,
    printsudorow(R7),
    printsudorow(R8),
    printsudorow(R9).


% Print row by printing each column.
%
printsudorow(Row) :-
    Row = [C1,C2,C3,C4,C5,C6,C7,C8,C9],
    write(' '),
    write(C1), write(' '),
    write(C2), write(' '),
    write(C3), write(' '), write('|'), write(' '),
    write(C4), write(' '),
    write(C5), write(' '),
    write(C6), write(' '), write('|'), write(' '),
    write(C7), write(' '),
    write(C8), write(' '),
    write(C9), write(' '), nl.


% Main solver containing the rules to solve Sudoku.
%
sudoku(Board) :-

    % Step one:
    Board = [[V11, V12, V13, V14, V15, V16, V17, V18, V19],
             [V21, V22, V23, V24, V25, V26, V27, V28, V29],
             [V31, V32, V33, V34, V35, V36, V37, V38, V39],
             [V41, V42, V43, V44, V45, V46, V47, V48, V49],
             [V51, V52, V53, V54, V55, V56, V57, V58, V59],
             [V61, V62, V63, V64, V65, V66, V67, V68, V69],
             [V71, V72, V73, V74, V75, V76, V77, V78, V79],
             [V81, V82, V83, V84, V85, V86, V87, V88, V89],
             [V91, V92, V93, V94, V95, V96, V97, V98, V99]],
    
    % Step two:
    Board = [R1, R2, R3, R4, R5, R6, R7, R8, R9],

    % Step three:
    all_different(R1),
    all_different(R2),
    all_different(R3),
    all_different(R4),
    all_different(R5),
    all_different(R6),
    all_different(R7),
    all_different(R8),
    all_different(R9),

    % Step four
    all_different([V11, V21, V31, V41, V51, V61, V71, V81, V91]),
    all_different([V12, V22, V32, V42, V52, V62, V72, V82, V92]),
    all_different([V13, V23, V33, V43, V53, V63, V73, V83, V93]),
    all_different([V14, V24, V34, V44, V54, V64, V74, V84, V94]),
    all_different([V15, V25, V35, V45, V55, V65, V75, V85, V95]),
    all_different([V16, V26, V36, V46, V56, V66, V76, V86, V96]),
    all_different([V17, V27, V37, V47, V57, V67, V77, V87, V97]),
    all_different([V18, V28, V38, V48, V58, V68, V78, V88, V98]),
    all_different([V19, V29, V39, V49, V59, V69, V79, V89, V99]),

    % Step five
    all_different([V11, V12, V13, V21, V22, V23, V31, V32, V33]),
    all_different([V41, V42, V43, V51, V52, V53, V61, V62, V63]),
    all_different([V71, V72, V73, V81, V82, V83, V91, V92, V93]),
    all_different([V14, V15, V16, V24, V25, V26, V34, V35, V36]),
    all_different([V44, V45, V46, V54, V55, V56, V64, V65, V66]),
    all_different([V74, V75, V76, V84, V85, V86, V94, V95, V96]),
    all_different([V17, V18, V19, V27, V28, V29, V37, V38, V39]),
    all_different([V47, V48, V49, V57, V58, V59, V67, V68, V69]),
    all_different([V77, V78, V79, V87, V88, V89, V97, V98, V99]),

    % Step six
    flatten(Board, Element),

    % Step seven
    Element ins 1..9,

    % Step eight
    label(Element).
