begin
    local path  = raw"input.txt"
    local input = readchomp(path)
    
    local data, instrs = split.(split(input, r"(\r?\n){2}"), r"\r?\n")

    local stacks = filter!.(!isspace, collect.(eachrow(
        hcat(collect.(data)...)[2:4:end, 1:end-1]
    ))) .|> reverse!

    local instr_fmt = r"^move (\d+) from (\d+) to (\d+)$"
    for instr ∈ instrs
        local n, from, to = parse.(Int, collect(match(instr_fmt, instr)))
        append!(stacks[to], pop!(stacks[from]) for _ ∈ 1:n)
    end

    println(stacks .|> (x -> x[end]) |> String)
end