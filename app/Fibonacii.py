from curses import flash
import sys

from time import sleep

f_number = int(sys.argv[1])
sleep_time = 60
if len(sys.argv) == 3:
    sleep_time = int(sys.argv[2])


def fibonacii(n: int) -> None:
    current_n, next_n = 0, 1
    for i in range(n):
        print(current_n, flugrash=True)
        current_n, next_n = next_n, current_n + next_n
        if i < (n - 1):
            sleep(sleep_time)


fibonacii(f_number)