#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>
#include <math.h>

/**
 * Reads the local portion of a matrix and a vector from files.
 * @param matrix Pointer to the matrix to fill.
 * @param vector Pointer to the vector to fill.
 * @param size Total size of the matrix and vector.
 * @param matrix_file Name of the file containing the matrix.
 * @param vector_file Name of the file containing the vector.
 * @param rank Rank of the current MPI process.
 * @param num_procs Total number of MPI processes.
 */
void read_local_matrix_and_vector(double **matrix, double *vector, int size, const char *matrix_file, const char *vector_file, int rank, int num_procs) {
    FILE *fileA = fopen(matrix_file, "r");
    if (!fileA) {
        fprintf(stderr, "Error opening file %s\n", matrix_file);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    int row_start = rank * (size / num_procs);
    int local_rows = (rank == num_procs - 1) ? size - row_start : size / num_procs;

    // Skip rows in the matrix until the local portion is reached
    for (int i = 0; i < row_start; i++) {
        for (int j = 0; j < size; j++) {
            fscanf(fileA, "%lf", &matrix[0][0]);
        }
    }

    // Read the local portion of the matrix
    for (int i = 0; i < local_rows; i++) {
        for (int j = 0; j < size; j++) {
            fscanf(fileA, "%lf", &matrix[i][j]);
        }
    }

    fclose(fileA);

    FILE *fileB = fopen(vector_file, "r");
    if (!fileB) {
        fprintf(stderr, "Error opening file %s\n", vector_file);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    // Skip values in the vector until the local portion is reached
    for (int i = 0; i < row_start; i++) {
        fscanf(fileB, "%lf", &vector[0]);
    }

    // Read the local portion of the vector
    for (int i = 0; i < local_rows; i++) {
        fscanf(fileB, "%lf", &vector[i]);
    }

    fclose(fileB);
}

/**
 * Performs the Jacobi iterative method to solve a system of linear equations.
 * @param matrix Local portion of the matrix.
 * @param vector Local portion of the vector.
 * @param result Result vector.
 * @param size Total size of the system.
 * @param tolerance Tolerance for convergence.
 * @param rank Rank of the current MPI process.
 * @param num_procs Total number of MPI processes.
 */
void jacobi_method(double **matrix, double *vector, double *result, int size, double tolerance, int rank, int num_procs) {
    int row_start = rank * (size / num_procs);
    int local_rows = (rank == num_procs - 1) ? size - row_start : size / num_procs;
    double *new_result = (double *)malloc(local_rows * sizeof(double));
    double max_difference;

    do {
        max_difference = 0.0;

        // Calculate new values for the result vector
        for (int i = 0; i < local_rows; i++) {
            double sum = 0.0;
            for (int j = 0; j < size; j++) {
                if (j != row_start + i) {
                    sum += matrix[i][j] * result[j];
                }
            }
            new_result[i] = (vector[i] - sum) / matrix[i][row_start + i];
        }

        // Prepare for gathering results from all processes
        int *recv_counts = (int *)malloc(num_procs * sizeof(int));
        int *displacements = (int *)malloc(num_procs * sizeof(int));
        for (int i = 0; i < num_procs; i++) {
            recv_counts[i] = size / num_procs + (i == num_procs - 1 ? size % num_procs : 0);
            displacements[i] = i * (size / num_procs);
        }

        // Calculate the maximum difference for convergence
        for (int i = 0; i < local_rows; i++) {
            double diff = fabs(new_result[i] - result[row_start + i]);
            if (diff > max_difference) max_difference = diff;
        }

        // Gather results from all processes and update the result vector
        MPI_Allgatherv(new_result, local_rows, MPI_DOUBLE, result, recv_counts, displacements, MPI_DOUBLE, MPI_COMM_WORLD);
        MPI_Allreduce(MPI_IN_PLACE, &max_difference, 1, MPI_DOUBLE, MPI_MAX, MPI_COMM_WORLD);

        free(recv_counts);
        free(displacements);

    } while (max_difference > tolerance);

    free(new_result);
}

/**
 * Main entry point of the program.
 * Initializes MPI, reads the matrix and vector, performs the Jacobi method,
 * and writes results to files.
 */
int main(int argc, char **argv) {
    int rank, num_procs, size;
    double tolerance;
    char matrix_file[256], vector_file[256];

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

    // Initialize parameters on process 0
    if (rank == 0) {
        if (argc != 5) {
            fprintf(stderr, "Usage: %s N=100 eps=0.001 A=A.dat b=b.dat\n", argv[0]);
            MPI_Abort(MPI_COMM_WORLD, 1);
        }

        sscanf(argv[1], "N=%d", &size);
        sscanf(argv[2], "eps=%lf", &tolerance);
        sscanf(argv[3], "A=%255s", matrix_file);
        sscanf(argv[4], "b=%255s", vector_file);

        if (size < 5) {
            fprintf(stderr, "Matrix size must be at least 5\n");
            MPI_Abort(MPI_COMM_WORLD, 1);
        }
    }

    // Broadcast parameters to all processes
    MPI_Bcast(&size, 1, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(&tolerance, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_Bcast(matrix_file, 256, MPI_CHAR, 0, MPI_COMM_WORLD);
    MPI_Bcast(vector_file, 256, MPI_CHAR, 0, MPI_COMM_WORLD);

    int local_rows = size / num_procs + (rank == num_procs - 1 ? size % num_procs : 0);
    double **matrix = (double **)malloc(local_rows * sizeof(double *));
    for (int i = 0; i < local_rows; i++) {
        matrix[i] = (double *)malloc(size * sizeof(double));
    }
    double *vector = (double *)malloc(local_rows * sizeof(double));
    double *result = (double *)malloc(size * sizeof(double));

    // Initialize the result vector with zeros
    for (int i = 0; i < size; i++) {
        result[i] = 0.0;
    }

    // Read local parts of the matrix and vector
    read_local_matrix_and_vector(matrix, vector, size, matrix_file, vector_file, rank, num_procs);

    double start_time = MPI_Wtime();
    jacobi_method(matrix, vector, result, size, tolerance, rank, num_procs);
    double end_time = MPI_Wtime();

    // Write results and timing information from process 0
    if (rank == 0) {
        FILE *time_file = fopen("times.txt", "a");
        if (time_file) {
            fprintf(time_file, "%lf %d %d %lf %s %s\n", end_time - start_time, num_procs, size, tolerance, matrix_file, vector_file);
            fclose(time_file);
        }

        FILE *result_file = fopen("result.bat", "w");
        if (result_file) {
            for (int i = 0; i < size; i++) {
                fprintf(result_file, "x[%d] = %lf\n", i, result[i]);
            }
            fclose(result_file);
        }
    }

    // Clean up allocated memory
    for (int i = 0; i < local_rows; i++) {
        free(matrix[i]);
    }
    free(matrix);
    free(vector);
    free(result);

    MPI_Finalize();
    return 0;
}

