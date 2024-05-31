from constraint import Problem, AllDifferentConstraint

def leer_tablero(nombre_archivo):
    with open(nombre_archivo, 'r') as file:
        lines = file.readlines()

    vars = {}
    constraints = {'SumaHorizontal': {}, 'SumaVertical': {}}

    for i in range(9):
        cells = lines[i].strip().split(',')
        for j in range(9):
            cell = cells[j].strip()

            if cell == '/':
                vars[(i, j)] = '#'
            elif '/' in cell:
                partes = cell.split('/')
                suma_vertical = int(partes[0]) if partes[0] else None
                suma_horizontal = int(partes[1]) if len(partes) > 1 and partes[1] else None
                if suma_horizontal:
                    constraints['SumaHorizontal'][(i, j)] = suma_horizontal
                if suma_vertical:
                    constraints['SumaVertical'][(i, j)] = suma_vertical
                vars[(i, j)] = []
            else:
                vars[(i, j)] = [int(d) for d in cell]

    return vars, constraints

def kakuro_constraints(problem, vars, constraints):
    for (i, j), suma in constraints['SumaHorizontal'].items():
        cells = []
        jj = j + 1
        while (jj < 9) and (i, jj) in vars and isinstance(vars[(i, jj)], list):
            cells.append((i, jj))
            jj += 1
        if cells:
            problem.addConstraint(AllDifferentConstraint(), cells)
            problem.addConstraint(lambda *values, suma=suma: sum(values) == suma, cells)

    for (i, j), suma in constraints['SumaVertical'].items():
        cells = []
        ii = i + 1
        while (ii < 9) and (ii, j) in vars and isinstance(vars[(ii, j)], list):
            cells.append((ii, j))
            ii += 1
        if cells:
            problem.addConstraint(AllDifferentConstraint(), cells)
            problem.addConstraint(lambda *values, suma=suma: sum(values) == suma, cells)

def resolver_kakuro(vars, constraints):
    problem = Problem()

    for pos, domain in vars.items():
        if domain != '#':
            problem.addVariable(pos, domain if domain else list(range(1, 10)))

    kakuro_constraints(problem, vars, constraints)

    solutions = problem.getSolutions()
    return solutions[0] if solutions else None

def imprimir_solucion(solution):
    for i in range(9):
        for j in range(9):
            if (i, j) in solution:
                print(solution[(i, j)], end=" ")
            else:
                print("#", end=" ")
        print()

# Leer el tablero desde el archivo
vars, constraints = leer_tablero("tableroK.txt")

# Resolver el Kakuro
solucion = resolver_kakuro(vars, constraints)
if solucion:
    print("-----------------------")
    print("| EL KAKURO RESUELTO ES |")
    print("-----------------------")
    imprimir_solucion(solucion)
else:
    print("No se pudo encontrar una solución.")
