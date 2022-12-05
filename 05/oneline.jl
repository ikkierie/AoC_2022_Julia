println("Part one: $(
    reduce(
        ((_, s), (n, src, dst)) -> (append!(s[dst], pop!(s[src]) for _ ∈ 1:n), s), 
        (global instrs = 
            (global data, instrs = split.(split(readchomp(raw"input.txt"), r"(\r?\n){2}"), r"\r?\n"))[2] .|> 
                x -> parse.(Int, collect(match(r"move (\d+) from (\d+) to (\d+)", x)))
        ), 
        init = (
            nothing, 
            deepcopy(global stacks = filter!.(!isspace, collect.(eachrow(hcat(collect.(data)...)[2:4:end, 1:end-1]))) .|> reverse!)
        )
    )[2] .|> (x -> x[end]) |> String
)\nPart two: $(
    reduce(
        ((_, s), (n, src, dst)) -> (append!(stacks[dst], [pop!(stacks[src]) for _ ∈ 1:n] |> reverse!), s), 
        instrs, 
        init = (nothing, stacks)
    )[2] .|> (x -> x[end]) |> String
)")