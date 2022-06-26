import unittest
import time
from datetime import datetime, timedelta

import Fibonacii as fib


class TestFib(unittest.TestCase):
    def test_seq(self):
        f_out = {
            5: [0, 1, 1, 2, 3],
            10: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34],
            15: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377],
        }
        for n, r in f_out.items():
            # print(n, r)
            self.assertEqual(fib.fibonacii(n), r, f"Should be {n}")

    # def test_runtime(self):
    #     start_time = time.monotonic()
    #     n = 5
    #     t = 2
    #     fib.print_fib_seq(fib.fibonacii(n), t)

    #     self.assertEqual(timedelta(seconds=time.monotonic() - start_time), n * t)


start_time = datetime.now()

if __name__ == "__main__":
    unittest.main()