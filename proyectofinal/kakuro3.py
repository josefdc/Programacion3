from pysat.solvers import Glucose3
from itertools import combinations

def create_variables(board):
    """
    Crea las variables para cada celda vacía en el tablero de Kakuro.

    Args:
        board (list of list of int/tuple): El tablero de Kakuro.

    Returns:
        dict: Diccionario con las variables del modelo.
    """
    variables = {}
    counter = 1
    for i in range(len(board)):
        for j in range(len(board[0])):
            if board[i][j] == 0:
                variables[(i, j)] = {}
                for k in range(1, 10):
                    variables[(i, j)][k] = counter
                    counter += 1
    return variables

def add_constraints(solver, board, variables):
    """
    Añade restricciones de unicidad y suma al solver SAT.

    Args:
        solver (Glucose3): El solver SAT.
        board (list of list of int/tuple): El tablero de Kakuro.
        variables (dict): Diccionario con las variables del modelo.
    """
    n = len(board)
    m = len(board[0])

    # Restricciones de unicidad: Cada celda debe tener un solo valor entre 1 y 9
    for (i, j), var_dict in variables.items():
        # Cada celda debe tener exactamente un valor entre 1 y 9
        solver.add_clause([var_dict[k] for k in range(1, 10)])
        for k in range(1, 10):
            for l in range(k + 1, 10):
                solver.add_clause([-var_dict[k], -var_dict[l]])

    # Restricciones de suma para filas y columnas
    for i in range(n):
        for j in range(m):
            if isinstance(board[i][j], tuple):
                row_sum, col_sum = board[i][j]

                if row_sum != -1:
                    row_literals = []
                    col = j + 1
                    while col < m and board[i][col] == 0:
                        for k in range(1, 10):
                            row_literals.append((variables[(i, col)][k], k))
                        col += 1
                    add_sum_constraints(solver, row_literals, row_sum)

                if col_sum != -1:
                    col_literals = []
                    row = i + 1
                    while row < n and board[row][j] == 0:
                        for k in range(1, 10):
                            col_literals.append((variables[(row, j)][k], k))
                        row += 1
                    add_sum_constraints(solver, col_literals, col_sum)

def add_sum_constraints(solver, literals, target_sum):
    """
    Añade restricciones de suma al solver SAT.

    Args:
        solver (Glucose3): El solver SAT.
        literals (list of tuple): Lista de literales y sus valores.
        target_sum (int): La suma objetivo para los literales.
    """
    vars = [lit[0] for lit in literals]
    vals = [lit[1] for lit in literals]

    # Añadir restricciones para que las sumas sean correctas
    for k in range(1, 10):
        for combo in combinations(literals, k):
            if sum([val for _, val in combo]) != target_sum:
                solver.add_clause([-var for var, _ in combo])

def solve_kakuro(board):
    """
    Resuelve el tablero de Kakuro usando SAT Solver.

    Args:
        board (list of list of int/tuple): El tablero de Kakuro.

    Returns:
        bool: True si se encontró una solución, False en caso contrario.
    """
    variables = create_variables(board)
    solver = Glucose3()
    add_constraints(solver, board, variables)

    if solver.solve():
        model = solver.get_model()
        for (i, j), var_dict in variables.items():
            for k in range(1, 10):
                if model[var_dict[k] - 1] > 0:
                    board[i][j] = k
        return True
    else:
        return False

def print_board(board):
    """
    Imprime el tablero de Kakuro en consola.

    Args:
        board (list of list of int/tuple): El tablero de Kakuro.
    """
    for row in board:
        print(" ".join(str(cell) if isinstance(cell, int) else "." if cell == 0 else "*" for cell in row))

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
