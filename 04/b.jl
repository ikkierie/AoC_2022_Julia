begin
    local path    = raw"input.txt"
    local pattern = r"^(\d+)\-(\d+),(\d+)\-(\d+)$"
    local input   = collect.(match.(pattern, readlines(path))) .|> 
        x -> parse.(Int, x)

    println(count(((a, b, c, d),) -> length(∩(a:b, c:d)) > 0, input))
end