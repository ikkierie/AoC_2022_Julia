begin 
    local path  = raw"input.txt"
    local input = read(path, String)

    local cals = split.(split(input, r"(\r\n){2}"), r"\r\n") .|> 
            (x -> parse.(Int, x))

    println("$(cals .|> sum |> maximum) calories")
end