import sys

from time import sleep


def fibonacii(n: int) -> int:
    current_n, next_n = 0, 1
    seq = list()
    for i in range(n):
        seq.append(current_n)
        current_n, next_n = next_n, current_n + next_n
    return seq


def print_fib_seq(fib_seq: list, sleep_time: int) -> None:
    while fib_seq:
        print(fib_seq.pop(0), flush=True)
        if fib_seq:
            sleep(sleep_time)


if __name__ == "__main__":
    f_number = int(sys.argv[1])
    sleep_time = 60
    if len(sys.argv) == 3:
        sleep_time = int(sys.argv[2])

    print_fib_seq(fibonacii(f_number), sleep_time)