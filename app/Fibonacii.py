import sys
import click

from random import randint
from time import sleep


def fibonacii(n: int) -> int:
    current_n, next_n = 0, 1
    seq = list()
    for i in range(n):
        seq.append(current_n)
        current_n, next_n = next_n, current_n + next_n
    return seq


def print_fib(max_random: int, sleep_time: int) -> None:
    while True:
        print(fibonacii(randint(1, max_random)), flush=True)
        sleep(sleep_time)


@click.command()
@click.option(
    "-l",
    "--seq_len",
    default=10,
    show_default=True,
    type=int,
    help="The maximal length of the Fibonacci sequence.",
)
@click.option(
    "-s",
    "--sleep",
    default=60,
    show_default=True,
    type=int,
    help="The sleep time between printing next sequence.",
)
def main(seq_len: int, sleep: int) -> None:
    print_fib(seq_len, sleep)


if __name__ == "__main__":
    main()