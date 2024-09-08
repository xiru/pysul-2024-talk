from utils import timeit

N_QUEENS_SIZE = 12


class NQueens:
    def solve(self, n):
        col = set()
        posDiag = set()
        negDiag = set()

        res = []
        board = [["."] * n for i in range(n)]

        def backtrack(r=0):
            if r == n:
                res.append("\n".join(["".join(row) for row in board]))
                return

            for c in range(n):
                if c in col or (r + c) in posDiag or (r - c) in negDiag:
                    continue

                col.add(c)
                posDiag.add(r + c)
                negDiag.add(r - c)
                board[r][c] = "Q"

                backtrack(r + 1)

                col.remove(c)
                posDiag.remove(r + c)
                negDiag.remove(r - c)
                board[r][c] = "."

        backtrack()
        return res

def solve():
    NQueens().solve(N_QUEENS_SIZE)

@timeit
def run():
    for _ in range(10):
        solve()

@timeit
def run_threads():
    from concurrent.futures.thread import ThreadPoolExecutor
    with ThreadPoolExecutor(max_workers=10) as executor:
        for _ in range(10):
            executor.submit(solve)

run()
print(',', end='')
run_threads()
print('')
