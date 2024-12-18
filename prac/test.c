#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>
#include <math.h>


void read_local_matrix_and_vector(double **A, double *b, int n, const char *fileA_name, const char *fileB_name, int rank, int size) {
    FILE *fileA = fopen(fileA_name, "r");
    if (!fileA) {
        fprintf(stderr, "Error opening file %s\n", fileA_name);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    int row_start = rank * (n / size);
    int local_rows = (rank == size - 1) ? n - row_start : n / size;

    // Пропускаем строки до нужной части матрицы A
    for (int i = 0; i < row_start; i++) {
        for (int j = 0; j < n; j++) {
            fscanf(fileA, "%lf", &A[0][0]);  // Просто пропускаем данные
        }
    }

    // Чтение локальной части матрицы A
    for (int i = 0; i < local_rows; i++) {
        for (int j = 0; j < n; j++) {
            fscanf(fileA, "%lf", &A[i][j]);  // Читаем нужные данные
        }
    }

    fclose(fileA);

    // Печать локальной части матрицы A
    // printf("Rank: %d local_A\n", rank);
    // for (int i = 0; i < local_rows; i++) {
    //     for (int j = 0; j < n; j++) {
    //         printf("%4.2f ", A[i][j]);
    //     }
    //     printf("\n");
    // }
    // printf("\n");

    // Чтение локальной части вектора b
    FILE *fileB = fopen(fileB_name, "r");
    if (!fileB) {
        fprintf(stderr, "Error opening file %s\n", fileB_name);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    // Пропускаем строки до нужной части вектора b
    for (int i = 0; i < row_start; i++) {
        fscanf(fileB, "%lf", &b[0]);  // Просто пропускаем данные
    }

    // Чтение локальной части вектора b
    for (int i = 0; i < local_rows; i++) {
        fscanf(fileB, "%lf", &b[i]);  // Читаем нужные данные
    }

    fclose(fileB);

    // Печать локальной части вектора b
    // printf("Rank: %d local_b\n", rank);
    // for (int i = 0; i < local_rows; i++) {
    //     printf("%4.2f ", b[i]);
    // }
    // printf("\n\n");
}



// Метод Якоби для решения системы Ax = b
void jacobi_method(double **A, double *b, double *x, int n, double eps, int rank, int size) {
    int i, j;
    int row_start = rank * (n / size);  // Индекс начала строки для текущего процесса
    int local_rows = (rank == size - 1) ? n - row_start : n / size;  // Количество строк для текущего процесса
    double *new_x = (double *)malloc(local_rows * sizeof(double));  // Массив для нового вектора x
    double max_diff;
    // printf("Rank: %d\n", rank);
    // Печать локальной части матрицы A
    // printf("Rank: %d local_A\n", rank);
    // for (i = 0; i < local_rows; i++) {
    //     for (j = 0; j < n; j++) {
    //         printf("%4.2f ", A[i][j]);
    //     }
    //     printf("\n");
    // }
    // printf("\n");

    // Печать локальной части вектора b
    // printf("Rank: %d local_b\n", rank);
    // for (i = 0; i < local_rows; i++) {
    //     printf("%4.2f ", b[i]);
    // }
    // printf("\n\n");

    do {
        max_diff = 0.0;
        
        // Вычисление нового значения для каждой строки, принадлежащей процессу
        for (i = 0; i < local_rows; i++) {
            double sum = 0.0;
            for (j = 0; j < n; j++) {
                if (j != row_start + i) {  // Не учитываем диагональный элемент
                    sum += A[i][j] * x[j];  // Суммируем произведение
                }
            }
            new_x[i] = (b[i] - sum) / A[i][row_start + i];  // Обновляем новое значение x для текущей строки
            // printf("rank: %d, i: %d, new_x[i]: %f, b[i]: %f, sum: %f, A[i][row_start + i]: %f\n", rank, i, new_x[i], b[i], sum, A[i][row_start + i]);
        }

        // Сбор новых значений вектора x с помощью MPI_Allgatherv
        int *recvcounts = (int *)malloc(size * sizeof(int));  // Количество элементов для каждого процесса
        int *displs = (int *)malloc(size * sizeof(int));      // Смещения для каждого процесса
        for (i = 0; i < size; i++) {
            recvcounts[i] = n / size + (i == size - 1 ? n % size : 0);  // Количество строк для процесса
            displs[i] = i * (n / size);  // Смещение для каждого процесса
        }


        // Обновление максимальной разницы между старым и новым значением x
        for (i = 0; i < local_rows; i++) {
            double diff = fabs(new_x[i] - x[row_start + i]);
            if (diff > max_diff) max_diff = diff;
        }

        // Собираем новые значения вектора x с всех процессов
        MPI_Allgatherv(new_x, local_rows, MPI_DOUBLE, x, recvcounts, displs, MPI_DOUBLE, MPI_COMM_WORLD);

        // Получаем максимальную разницу между всеми процессами
        MPI_Allreduce(MPI_IN_PLACE, &max_diff, 1, MPI_DOUBLE, MPI_MAX, MPI_COMM_WORLD);

        printf("max_diff: %f\n", max_diff);

        free(recvcounts);
        free(displs);

    } while (max_diff > eps);  // Условие завершения итераций
    free(new_x);  // Освобождение памяти для new_x
}


int main(int argc, char **argv) {
    int rank, size, n;
    double eps;
    char fileA_name[256], fileB_name[256];

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Инициализация параметров с процессом 0
    if (rank == 0) {
        if (argc != 5) {
            fprintf(stderr, "Usage: %s N=100 eps=0.001 A=A.dat b=b.dat\n", argv[0]);
            MPI_Abort(MPI_COMM_WORLD, 1);
        }

        sscanf(argv[1], "N=%d", &n);
        sscanf(argv[2], "eps=%lf", &eps);
        sscanf(argv[3], "A=%255s", fileA_name);
        sscanf(argv[4], "b=%255s", fileB_name);

        if (n < 5) {
            fprintf(stderr, "Matrix size must be at least 5\n");
            MPI_Abort(MPI_COMM_WORLD, 1);
        }
    }

    MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(&eps, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_Bcast(fileA_name, 256, MPI_CHAR, 0, MPI_COMM_WORLD);
    MPI_Bcast(fileB_name, 256, MPI_CHAR, 0, MPI_COMM_WORLD);

    int local_rows = n / size + (rank == size - 1 ? n % size : 0);
    double **A = (double **)malloc(local_rows * sizeof(double *));
    for (int i = 0; i < local_rows; i++) {
        A[i] = (double *)malloc(n * sizeof(double));
    }
    double *b = (double *)malloc(local_rows * sizeof(double));
    double *x = (double *)malloc(n * sizeof(double));

    // Инициализация вектора x нулями
    for (int i = 0; i < n; i++) {
        x[i] = 0.0;
    }

    // Чтение локальных частей матрицы и вектора
    read_local_matrix_and_vector(A, b, n, fileA_name, fileB_name, rank, size);

    double start_time = MPI_Wtime();
    jacobi_method(A, b, x, n, eps, rank, size);
    double end_time = MPI_Wtime();

    if (rank == 0) {
        FILE *file_time = fopen("times.txt", "a");
        if (file_time) {
            fprintf(file_time, "%lf %d\n", end_time - start_time, size);
            fclose(file_time);
        }

        FILE *file_result = fopen("result.bat", "a");
        if (file_result) {
            for (int i = 0; i < n; i++) {
                fprintf(file_result, "x[%d] = %lf\n", i, x[i]);
            }
            fclose(file_result);
        }
    }

    // Освобождение памяти
    for (int i = 0; i < local_rows; i++) {
        free(A[i]);
    }
    free(A);
    free(b);
    free(x);

    MPI_Finalize();
    return 0;
}
