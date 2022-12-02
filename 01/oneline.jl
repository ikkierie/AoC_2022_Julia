println("Part one: $(
    (c = sort([ 
        parse.(Int, split(x, r"\r?\n")) |> sum 
        for x ∈ split(read("input.txt", String), r"(\r?\n){2}") 
    ]))[end]
)\nPart two: $(sum(c[end-2:end]))")