import time
from functools import wraps


def timeit(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.monotonic()
        ret = func(*args, **kwargs)
        end = time.monotonic()
        print('{:10.4f}'.format(end - start), end='')
        return ret
    return wrapper
