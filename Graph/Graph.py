import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d

# Загрузка данных из файла
file_path = 'data.txt'  # укажите путь к вашему файлу
data = np.loadtxt(file_path)

# Извлечение времени и номеров процессов
time = data[:, 0]
process_num = data[:, 1]

# Порядок сортировки данных по номерам процессов
sorted_indices = np.argsort(process_num)
time_sorted = time[sorted_indices]
process_num_sorted = process_num[sorted_indices]

# Вычисление ускорения S(P) = T(1) / T(P)
T_1 = time_sorted[process_num_sorted == 1][0]  # время для одного процесса
S_P = T_1 / time_sorted  # ускорение

# Удваиваем максимальное количество процессов для интерполяции
max_process_num = max(process_num_sorted)
process_num_extended = np.linspace(min(process_num_sorted), max_process_num * 1, 200)

# Интерполяция с разными точностями
interp_linear = interp1d(process_num_sorted, S_P, kind='linear', fill_value='extrapolate')
interp_cubic = interp1d(process_num_sorted, S_P, kind='cubic', fill_value='extrapolate')
interp_quadratic = interp1d(process_num_sorted, S_P, kind='quadratic', fill_value='extrapolate')

# Получаем интерполированные значения для расширенного диапазона
S_P_linear = interp_linear(process_num_extended)
S_P_cubic = interp_cubic(process_num_extended)
S_P_quadratic = interp_quadratic(process_num_extended)

# Создание одного окна с несколькими графиками
plt.figure(figsize=(15, 12))

# Первый график: Линейная интерполяция
plt.subplot(3, 2, 1)  # (3 строки, 2 колонки, график 1)
plt.plot(process_num_sorted, S_P, 'o', label='Исходные данные', color='b')
plt.plot(process_num_extended, S_P_linear, '-', label='Линейная интерполяция', color='r')
plt.xlabel('Число процессов P')
plt.ylabel('Ускорение S(P)')
plt.title('Линейная интерполяция')
plt.grid(True)
plt.legend()

# Второй график: Кубическая интерполяция
plt.subplot(3, 2, 2)  # (3 строки, 2 колонки, график 2)
plt.plot(process_num_sorted, S_P, 'o', label='Исходные данные', color='b')
plt.plot(process_num_extended, S_P_cubic, '--', label='Кубическая интерполяция', color='g')
plt.xlabel('Число процессов P')
plt.ylabel('Ускорение S(P)')
plt.title('Кубическая интерполяция')
plt.grid(True)
plt.legend()

# Третий график: Квадратичная интерполяция
plt.subplot(3, 2, 3)  # (3 строки, 2 колонки, график 3)
plt.plot(process_num_sorted, S_P, 'o', label='Исходные данные', color='b')
plt.plot(process_num_extended, S_P_quadratic, ':', label='Квадратичная интерполяция', color='orange')
plt.xlabel('Число процессов P')
plt.ylabel('Ускорение S(P)')
plt.title('Квадратичная интерполяция')
plt.grid(True)
plt.legend()

# Четвертый график: Сравнение всех интерполяций
plt.subplot(3, 2, 4)  # (3 строки, 2 колонки, график 4)
plt.plot(process_num_sorted, S_P, 'o', label='Исходные данные', color='b')
plt.plot(process_num_extended, S_P_linear, '-', label='Линейная интерполяция', color='r')
plt.plot(process_num_extended, S_P_cubic, '--', label='Кубическая интерполяция', color='g')
plt.plot(process_num_extended, S_P_quadratic, ':', label='Квадратичная интерполяция', color='orange')
plt.xlabel('Число процессов P')
plt.ylabel('Ускорение S(P)')
plt.title('Сравнение интерполяций')
plt.grid(True)
plt.legend()

# Пятый график: Исходные данные без интерполяции
plt.subplot(3, 1, 3)  # (3 строки, 2 колонки, график 5)
plt.plot(process_num_sorted, S_P, label='Ускорение S(P)', marker='o', color='b')
plt.xlabel('Число процессов P')
plt.ylabel('Ускорение S(P)')
plt.title('Исходные данные без интерполяции')
plt.grid(True)
plt.legend()

# Показываем все графики
plt.tight_layout()
plt.show()
