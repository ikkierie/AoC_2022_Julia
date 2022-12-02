begin
    local beats         = Dict(:P  => :R, :R  => :S, :S  => :P)
    local loses         = Dict((v, k) for (k, v) ∈ beats)
    local scores        = Dict(:R  =>  1, :P  =>  2, :S  =>  3)
    local moves         = Dict("A" => :R, "B" => :P, "C" => :S)
    local result_scores = Dict("X" =>  0, "Y" =>  3, "Z" =>  6)

    local path  = raw"input.txt"
    local input = split.(readlines(path), r"\s+")

    local move(opponent, player) =
        (player == "X") ? beats[opponent] :
        (player == "Z") ? loses[opponent] : opponent
    
    input .|> 
        (((x, y),) -> scores[move(moves[x], y)] + result_scores[y]) |> 
        sum |> 
        println
end