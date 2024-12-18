#!/bin/bash

check_param() {
    if [ -z "$1" ]; then
        echo "Ошибка: параметр $2 не задан."
        exit 1
    fi
}

./clear.sh

# Разбор аргументов
while [ "$1" != "" ]; do
    case $1 in
        -p )    shift
                num_proc=$1
                ;;
        -N )    shift
                N=$1
                ;;
        -eps )  shift
                eps=$1
                ;;
        -A )    shift
                A=$1
                ;;
        -b )    shift
                b=$1
                ;;
        -source ) shift
                source=$1
                ;;
        -program ) shift
                program=$1
                ;;
        * )     echo "Неверный параметр: $1"
                exit 1
    esac
    shift
done

# Проверка наличия всех обязательных параметров
check_param "$num_proc" "-p num_proc"
check_param "$N" "-N"
check_param "$eps" "-eps"
check_param "$A" "-A"
check_param "$b" "-b"
check_param "$source" "-source"
check_param "$program" "-program"

# Компиляция исходного кода
mpixlc -o "$program" "$source"

# Запуск программы с указанными параметрами и извлечение job_id
job_info=$(mpisubmit.pl -p "$num_proc" ./"$program" -- N="$N" eps="$eps" A="$A" b="$b")
job_id=$(echo "$job_info" | awk '{print $2}')
queue=$(echo "$job_info" | awk '{print $6}')  # Получаем имя очереди

# Печать информации о начале ожидания
echo "Задание с ID $job_id отправлено в очередь $queue."

