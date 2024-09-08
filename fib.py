from utils import timeit


# https://discuss.python.org/t/about-free-threading-performance/54604/1
def fib(n):
    if n < 3:
        return n
    return fib(n-1) + fib(n-2)

@timeit
def run():
    for _ in range(10):
        fib(35)

@timeit
def run_threads():
    from concurrent.futures.thread import ThreadPoolExecutor
    with ThreadPoolExecutor(max_workers=10) as executor:
        for _ in range(10):
            executor.submit(fib, 35)

run()
print(',', end='')
run_threads()
print('')
