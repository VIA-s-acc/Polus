# -*- coding: utf-8 -*-

import argparse
import random

def generate_matrix_from_x(x):
    n = len(x)
    A = []
    for i in range(n):
        row = [random.uniform(1, 10) for _ in range(n)]
        row[i] = sum(abs(row[j]) for j in range(n)) + random.uniform(10, 20)
        A.append(row)
    return A

def compute_b_from_A_and_x(A, x):
    b = [sum(A[i][j] * x[j] for j in range(len(x))) for i in range(len(A))]
    return b

def save_matrix_to_file(A, filename):
    with open(filename, 'w') as f:
        for row in A:
            f.write(" ".join("{:.2f}".format(x) for x in row) + "\n")

def save_vector_to_file(b, filename):
    with open(filename, 'w') as f:
        f.write(" ".join("{:.2f}".format(x) for x in b) + "\n")

def print_matrix(A):
    for row in A:
        print(" ".join("{:.2f}".format(x) for x in row))

def print_vector(b):
    print(" ".join("{:.2f}".format(x) for x in b))

def main():
    parser = argparse.ArgumentParser(description="Generation of matrix A and vector b for solving Ax = b by vector x")
    parser.add_argument("-n", type=int, required=True, help="System dimension (n)")
    parser.add_argument("-m", type=str, default="auto", choices=["auto", "manual"], help="Method of generating vector x (auto/manual)")
    parser.add_argument("--x", type=str, help="Vector x as a comma-separated list (only for manual)")
    parser.add_argument("-A", type=str, default="A.bat", help="Name of the file for matrix A (default A.bat)")
    parser.add_argument("-b", type=str, default="b.bat", help="Name of the file for vector b (default b.bat)")
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
    save_vector_to_file(x, "x.bat")
    if args.p:
        print("Матрица A:")
        print_matrix(A)
        print("\nВектор b:")
        print_vector(b)
        print("\nВектор x:")
        print_vector(x)

if __name__ == "__main__":
    main()

