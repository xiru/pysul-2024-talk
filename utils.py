import time
from functools import wraps


def timeit(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.process_time()
        ret = func(*args, **kwargs)
        end = time.process_time()
        print('{:10.4f}'.format(end - start), end='')
        return ret
    return wrapper
