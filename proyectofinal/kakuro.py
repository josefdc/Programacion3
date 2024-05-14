from ortools.sat.python import cp_model

def create_kakuro_variables(board, model):
    """
    Crea las variables para cada celda del tablero de Kakuro.

    Args:
        board (list of list of int/tuple): El tablero de Kakuro.
        model (cp_model.CpModel): El modelo de OR-Tools.

    Returns:
        dict: Diccionario con las variables del modelo.
    """
    variables = {}
    for i in range(len(board)):
        for j in range(len(board[0])):
            # Crear una variable para cada celda vacía o pista de suma
            if isinstance(board[i][j], int) and board[i][j] == 0 or isinstance(board[i][j], tuple):
                variables[(i, j)] = model.NewIntVar(1, 9, f'cell_{i}_{j}')
    return variables

def add_unique_constraints(model, variables, board):
    """
    Añade restricciones al modelo para que los números no se repitan en filas y columnas.

    Args:
        model (cp_model.CpModel): El modelo de OR-Tools.
        variables (dict): Diccionario con las variables del modelo.
        board (list of list of int/tuple): El tablero de Kakuro.
    """
    for i in range(len(board)):
        for j in range(len(board[0])):
            if isinstance(board[i][j], tuple):
                row_sum, col_sum = board[i][j]

                # Añadir restricciones para las sumas de filas
                if row_sum != -1:
                    row_cells = []
                    col = j + 1
                    while col < len(board[0]) and (board[i][col] == 0 or isinstance(board[i][col], int)):
                        row_cells.append(variables[(i, col)])
                        col += 1
                    model.AddAllDifferent(row_cells)
                    model.Add(sum(row_cells) == row_sum)

                # Añadir restricciones para las sumas de columnas
                if col_sum != -1:
                    col_cells = []
                    row = i + 1
                    while row < len(board) and (board[row][j] == 0 or isinstance(board[row][j], int)):
                        col_cells.append(variables[(row, j)])
                        row += 1
                    model.AddAllDifferent(col_cells)
                    model.Add(sum(col_cells) == col_sum)

def solve_kakuro(board):
    """
    Resuelve el tablero de Kakuro usando programación por restricciones.

    Args:
        board (list of list of int/tuple): El tablero de Kakuro.

    Returns:
        bool: True si se encontró una solución, False en caso contrario.
    """
    model = cp_model.CpModel()
    
    # Crear las variables del modelo
    variables = create_kakuro_variables(board, model)

    # Añadir restricciones de unicidad y sumas
    add_unique_constraints(model, variables, board)

    solver = cp_model.CpSolver()
    status = solver.Solve(model)

    if status == cp_model.FEASIBLE or status == cp_model.OPTIMAL:
        # Actualizar el tablero con los valores encontrados
        for (i, j), var in variables.items():
            board[i][j] = solver.Value(var)
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
