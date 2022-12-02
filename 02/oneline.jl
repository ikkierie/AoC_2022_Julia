println("Part one: $(
(inp = split.(readlines(raw"input.txt"), r"\s+")) .|>
    (((x, y),) -> (x[1] - 'A', y[1] - 'X')) .|>
    (((x, y),) -> y + 1 + 3mod(y - x + 1, 3)) |>
    sum
)\nPart two: $(
inp .|>
    (((x, y),) -> (x[1] - 'A', abs('X' - y[1]))) .|>
    (((x, y),) -> 3y + mod(x + y - 1, 3) + 1) |>
    sum
)")