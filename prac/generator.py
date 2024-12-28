# -*- coding: utf-8 -*-


"""! @brief generator module for Ax=b generation."""



##
# @file generator.py
#
# @brief generator module for Ax=b generation
#
# @section libraries_sensors Libraries/Modules
# - random standard library (https://docs.python.org/3/library/random.html)
#   - Access to randint function.
# - argparse standard library (https://docs.python.org/3/library/argparse.html)
#   - Access to ArgumentParser class.
# @section notes_sensors Notes
# - Comments are Doxygen compatible.
#
# @section todo_sensors TODO
# - None.
#

# Imports
import argparse
import random

def generate_matrix_from_x(x):
    """!
    Generates a diagonally dominant matrix A based on vector x.

    @param x Input vector used to construct matrix A.
    @return A The generated matrix A.
    """
    n = len(x)
    A = []
    for i in range(n):
        row = [random.uniform(1, 10) for _ in range(n)]
        row[i] = sum(abs(row[j]) for j in range(n)) + random.uniform(10, 20)
        A.append(row)
    return A

def compute_b_from_A_and_x(A, x):
    """!
    Computes the vector b based on matrix A and vector x.

    @param A Input matrix A.
    @param x Input vector x.
    @return b The computed vector b.
    """
    b = [sum(A[i][j] * x[j] for j in range(len(x))) for i in range(len(A))]
    return b

def save_matrix_to_file(A, filename):
    """!
    Saves matrix A to a file.

    @param A Matrix to be saved.
    @param filename Name of the file to save the matrix to.
    """
    with open(filename, 'w') as f:
        for row in A:
            f.write(" ".join("{:.2f}".format(x) for x in row) + "\n")

def save_vector_to_file(b, filename):
    """!
    Saves a vector to a file.

    @param vector Vector to be saved.
    @param filename Name of the file to save the vector to.
    """
    with open(filename, 'w') as f:
        f.write(" ".join("{:.2f}".format(x) for x in b) + "\n")

def print_matrix(A):
    """!
    Prints matrix A to the console.

    @param A Matrix to be printed.
    """
    for row in A:
        print(" ".join("{:.2f}".format(x) for x in row))

def print_vector(b):
    """!
    Prints a vector to the console.

    @param vector Vector to be printed.
    """
    print(" ".join("{:.2f}".format(x) for x in b))

def main():
    """!
    Main entry point for the script.

    @details
    Parses command-line arguments, generates or reads a vector x, constructs the matrix A, 
    computes the vector b, and saves or prints the results as specified by the user.

    Command-line arguments:
    - `-n`: Dimension of the system (n).
    - `-m`: Method for generating vector x ("auto" or "manual").
    - `--x`: Comma-separated vector x (required for "manual" mode).
    - `-A`: File name to save matrix A (default: "A.dat").
    - `-b`: File name to save vector b (default: "b.dat").
    - `-p`: Flag to print the results to the console.
    """
    parser = argparse.ArgumentParser(description="Generation of matrix A and vector b for solving Ax = b by vector x")
    parser.add_argument("-n", type=int, required=True, help="System dimension (n)")
    parser.add_argument("-m", type=str, default="auto", choices=["auto", "manual"], help="Method of generating vector x (auto/manual)")
    parser.add_argument("--x", type=str, help="Vector x as a comma-separated list (only for manual)")
    parser.add_argument("-A", type=str, default="A.dat", help="Name of the file for matrix A (default A.bat)")
    parser.add_argument("-b", type=str, default="b.dat", help="Name of the file for vector b (default b.bat)")
    parser.add_argument("-p", action="store_true", help="Flag to print result to the screen")
    args = parser.parse_args()

    n = args.n
    x = []

    if args.m == "manual":
        if args.x:
            x = list(map(float, args.x.strip("[]").split(",")))
            if len(x) != n:
                print("Error: the size of vector x ({}) does not match the size of n ({})".format(len(x), n))
                return

        else:
            print("Error: for manual mode, you need to specify vector x using the --x argument")
            return
    else:
        x = [random.uniform(1, 10) for _ in range(n)]

    A = generate_matrix_from_x(x)
    b = compute_b_from_A_and_x(A, x)

    save_matrix_to_file(A, args.A)
    save_vector_to_file(b, args.b)
    save_vector_to_file(x, "x.dat")
    if args.p:
        print("Матрица A:")
        print_matrix(A)
        print("\nВектор b:")
        print_vector(b)
        print("\nВектор x:")
        print_vector(x)

if __name__ == "__main__":
    main()

