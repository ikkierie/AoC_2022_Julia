println("Part one: $(count(
    ((a, b, c, d),) -> a:b ⊆ c:d || a:b ⊇ c:d,
    global elves = readlines("input.txt") .|> 
        x -> parse.(Int, collect(match(r"(\d+)\-(\d+),(\d+)-(\d+)", x)))
))\nPart two: $(
    count(((a, b, c, d),) -> length(∩(a:b, c:d)) > 0, elves)
)")