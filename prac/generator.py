# -*- coding: utf-8 -*-


import argparse
import random

# Функция для генерации матрицы A, чтобы метод Якоби сходился (диагональное преобладание)
def generate_matrix_from_x(x):
    n = len(x)
    A = []
    for i in range(n):
        row = [random.uniform(1, 10) for _ in range(n)]
        row[i] = sum(abs(row[j]) for j in range(n)) + random.uniform(10, 20)  # Диагональный элемент больше суммы других элементов
        A.append(row)
    return A

# Функция для вычисления вектора b = A * x
def compute_b_from_A_and_x(A, x):
    b = [sum(A[i][j] * x[j] for j in range(len(x))) for i in range(len(A))]
    return b

# Функция для записи матрицы в файл
def save_matrix_to_file(A, filename):
    with open(filename, 'w') as f:
        for row in A:
            f.write(" ".join("{:.2f}".format(x) for x in row) + "\n")

# Функция для записи вектора в файл
def save_vector_to_file(b, filename):
    with open(filename, 'w') as f:
        f.write(" ".join("{:.2f}".format(x) for x in b) + "\n")

# Функция для вывода матрицы A
def print_matrix(A):
    for row in A:
        print(" ".join("{:.2f}".format(x) for x in row))

# Функция для вывода вектора b
def print_vector(b):
    print(" ".join("{:.2f}".format(x) for x in b))

def main():
    # Настройка парсинга аргументов командной строки
    parser = argparse.ArgumentParser(description="Генерация матрицы A и вектора b для решения системы Ax = b по вектору x")
    parser.add_argument("-n", type=int, required=True, help="Размерность системы (n)")
    parser.add_argument("-m", type=str, default="auto", choices=["auto", "manual"], help="Метод генерации вектора x (auto/manual)")
    parser.add_argument("--x", type=str, help="Вектор x в виде списка через запятую (только для manual)")
    parser.add_argument("-A", type=str, default="A.bat", help="Название файла для матрицы A (по умолчанию A.bat)")
    parser.add_argument("-b", type=str, default="b.bat", help="Название файла для вектора b (по умолчанию b.bat)")
    parser.add_argument("-p", action="store_true", help="Флаг для вывода результата на экран")
    args = parser.parse_args()

    n = args.n
    x = []

    if args.m == "manual":
        if args.x:
            # Преобразуем строку с вектором x в список чисел
            x = list(map(float, args.x.strip("[]").split(",")))
            if len(x) != n:
                print("Ошибка: размер вектора x ({}) не совпадает с размером n ({})".format(len(x), n))
                return
        else:
            print("Ошибка: для режима manual нужно указать вектор x через аргумент --x")
            return
    else:
        # Генерация случайного вектора x
        x = [random.uniform(1, 10) for _ in range(n)]

    # Генерация матрицы A для заданного x
    A = generate_matrix_from_x(x)

    # Вычисление вектора b
    b = compute_b_from_A_and_x(A, x)

    # Сохранение в файлы
    save_matrix_to_file(A, args.A)
    save_vector_to_file(b, args.b)
    save_vector_to_file(x, "x.bat")
    if args.p:
         # Вывод матрицы и вектора (по желанию)
        print("Матрица A:")
        print_matrix(A)
        print("\nВектор b:")
        print_vector(b)
        print("\nВектор x:")
        print_vector(x)

if __name__ == "__main__":
    main()

