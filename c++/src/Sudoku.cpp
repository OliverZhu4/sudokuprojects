// File name: Sudoku.cpp
// Author: Qibang Zhu
// userid: zhuq2
// Email: qibang.zhu@vanderbilt.edu
// Description:  Complete for sudo solutions
// Honor statement: I have not given or receive any unauthorized help on this assignment.

#include "Sudoku.h"
#include <fstream>
#include <iostream>

/**
 * Default constructor that creates an empty map.
 */
Sudoku::Sudoku()
    : sudoMap()
{
}

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
void Sudoku::loadFromFile(std::string filename)
{
    std::ifstream infile;
    infile.open(filename.c_str());
    if (infile.fail()) {
        std::cout << "Error opening input data file" << std::endl;
        exit(1);
    }
    int value = 0;
    for (int i = 0; i < MAP_SIZE; i++) {
        for (int k = 0; k < MAP_SIZE; k++) {
            infile >> value;
            if (value > MAP_SIZE || value < 0) {
                throw std::out_of_range("Input value is not valid");
            }
            sudoMap[i][k] = value;
        }
    }
    infile.close();
}

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
bool Sudoku::solve()
{
    int row = 0;
    int column = 0;
    if (isFinished(row, column)) {
        return true;
    }
    for (int value = 1; value <= 9; value++) {
        if (!findContradiction(row, column, value)) {
            sudoMap[row][column] = value;
            if (solve()) {
                return true;
            }
            sudoMap[row][column] = 0;
        }
    }
    return false;
}

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
bool Sudoku::findContradiction(int row, int column, int value)
{
    // Check if the number already exists in the same row
    for (int i = 0; i < MAP_SIZE; i++) {
        if (sudoMap[i][column] == value) {
            return true;
        }
    }

    // Check if the number already exists in the same column
    for (int k = 0; k < MAP_SIZE; k++) {
        if (sudoMap[row][k] == value) {
            return true;
        }
    }

    // Check if the number already exists in the same 3x3 box
    for (int i = 0; i < 3; i++) {
        for (int k = 0; k < 3; k++) {
            if (sudoMap[i + row - row % 3][k + column - column % 3] == value) {
                return true;
            }
        }
    }
    return false;
}

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
bool Sudoku::isFinished(int& row, int& column)
{
    for (int i = 0; i < MAP_SIZE; i++) {
        for (int k = 0; k < MAP_SIZE; k++) {
            if (sudoMap[i][k] == 0) {
                row = i;
                column = k;
                return false;
            }
        }
    }
    return true;
}

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
bool Sudoku::equals(const Sudoku& other) const
{
    int flag = 1;
    for (int i = 0; i < MAP_SIZE; i++) {
        for (int k = 0; k < MAP_SIZE; k++) {
            if (sudoMap[i][k] != other.sudoMap[i][k]) {
                flag = 0;
            }
        }
    }
    return (flag == 1);
}

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
std::ostream& operator<<(std::ostream& out, const Sudoku& sudoku)
{
    for (int i = 0; i < MAP_SIZE; i++) {
        for (int k = 0; k < MAP_SIZE; k++) {
            if (sudoku.sudoMap[i][k] == 0) {
                out << "  ";
            } else {
                out << sudoku.sudoMap[i][k] << " ";
            }
            if (k == 2 || k == 5) {
                out << "| ";
            }
        }
        out << "\n";
        if (i == 2 || i == 5) {
            out << "------+-------+------\n";
        }
    }
    return out;
}