def print_board(board):
    for row in board:
        print(" ".join(str(cell) if isinstance(cell, int) else "." for cell in row))

def is_valid(board, row, col, num):
    # Verificar si el número ya está en la fila
    for c in range(len(board[0])):
        if board[row][c] == num:
            return False
    
    # Verificar si el número ya está en la columna
    for r in range(len(board)):
        if board[r][col] == num:
            return False
    
    return True

def check_sums(board, row, col):
    # Verificar la suma de la fila
    current_sum = 0
    c = col
    while c >= 0 and not isinstance(board[row][c], tuple):
        if board[row][c] == 0:
            return True
        current_sum += board[row][c]
        c -= 1
    if c >= 0 and isinstance(board[row][c], tuple):
        expected_sum = board[row][c][0]
        if expected_sum != -1 and current_sum > expected_sum:
            return False

    # Verificar la suma de la columna
    current_sum = 0
    r = row
    while r >= 0 and not isinstance(board[r][col], tuple):
        if board[r][col] == 0:
            return True
        current_sum += board[r][col]
        r -= 1
    if r >= 0 and isinstance(board[r][col], tuple):
        expected_sum = board[r][col][1]
        if expected_sum != -1 and current_sum > expected_sum:
            return False

    return True

def solve_kakuro(board):
    for row in range(len(board)):
        for col in range(len(board[0])):
            if board[row][col] == 0:
                for num in range(1, 10):
                    if is_valid(board, row, col, num):
                        board[row][col] = num
                        if check_sums(board, row, col):
                            if solve_kakuro(board):
                                return True
                        board[row][col] = 0
                return False
    return True

# Tablero de Kakuro basado en la imagen proporcionada
# Cada celda es una tupla (suma_fila, suma_columna)
# -1 indica que no hay suma en esa dirección
# 0 en casillas blancas indica que deben ser llenadas

board = [
    [(-1, -1), (-1, -1), (-1, 39), (-1, 22), (-1, -1), (-1, -1), (-1, -1), (-1, 36), (-1, 3)],
    [(-1, -1), (4, -1), 0, 0, (-1, -1), (-1, -1), (4, -1), 0, 0],
    [(-1, -1), (12, -1), 0, 0, (-1, -1), (-1, -1), (6, 22), 0, 0],
    [(-1, -1), (5, 17), 0, 0, (-1, 4), (3, 9), 0, 0, (-1, 3)],
    [(43, -1), 0, 0, 0, 0, 0, 0, 0, 0],
    [(37, -1), 0, 0, 0, 0, 0, 0, 0, 0],
    [(-1, -1), (7, 12), 0, 0, (-1, -1), (4, -1), 0, 0, (-1, -1)],
    [(4, -1), 0, 0, (-1, -1), (-1, -1), (7, -1), 0, 0, (-1, -1)],
    [(16, -1), 0, 0, (-1, -1), (-1, -1), (15, -1), 0, 0, (-1, -1)]
]

if solve_kakuro(board):
    print_board(board)
else:
    print("No solution found")
