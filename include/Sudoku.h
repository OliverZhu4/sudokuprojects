// Delete this line and write your Sudoku.h file here

#include <iostream>

#ifndef SUDOKU_H
#define SUDOKU_H

const int MAP_SIZE = 9; // Squares per row or column.

class Sudoku {
public:
    /**
     * Default constructor that creates an empty map.
     */
    Sudoku();

    /**
     * Load file using filename.
     *
     * Precondition: The filename exists.
     *
     * Postcondtion: If the file is found and the input value are valid,
     * load the values in the value into the 2D array.
     *
     * @param  filename The name of the file.
     */
    void loadFromFile(std::string filename);

    /**
     * Solve the sudoku
     *
     * Precondition: The sudoku exits and passed
     *
     * Postcondtion: The sudoku is solved and printed into out
     * Whether the sudoku can be solved is returned
     *
     * @return Whether the sudoku can be solved is returned
     */
    bool solve();

    /**
     * Find out whether the number already exists in the
     * row/ column or in the 3x3 box
     *
     * Precondition: The value passed is valid
     *
     * Postcondtion: The boolean is returned
     *
     * @param  row The row of the number.
     * @param  column The column of the number.
     * @param  value The value of the number.
     * @return Whether the number already exists in the
     * row/ column or in the 3x3 box
     */
    bool findContradiction(int row, int column, int value);

    /**
     * Find out whether the sudoku is finished solving
     *
     * Precondition: Row and column are passed
     *
     * Postcondtion: The row and column value in the original
     * method is changed. Whether the sudoku is finished solving is returned
     *
     * @param  row The row of the number.
     * @param  column The column of the number.
     * @return Whether the sudoku is finished solving
     * row/ column or in the 3x3 box
     */
    bool isFinished(int& row, int& column);

    /**
     * Check if the two sudoku maps have the same values.
     *
     * Precondition: Another sudo map is passed.
     *
     * Postcondtion: If the two sudoku maps have the same values, return true.
     *
     * @param  other The sudoku map to be compared.
     * @return Whether the two sudoku maps are the same.
     */
    bool equals(const Sudoku& other) const;

    /**
     * Overwrite operator<< to output the values into out.
     *
     * Precondition: A sudoku map is passed into the function.
     *
     * Postcondtion: The values in sudoku was passed into out.
     *
     * @param  out The output ostream.
     * @param  sudoku The sudoku provided.
     * @return A ostream containing all the inputs.
     */
    friend std::ostream& operator<<(std::ostream& out, const Sudoku& sudoku);

private:
    int sudoMap[MAP_SIZE][MAP_SIZE] = { { 0 } }; // Sudo Map.
};

#endif