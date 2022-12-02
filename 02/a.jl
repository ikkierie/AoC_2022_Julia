begin
    local beats  = Dict(:P => :R, :R => :S, :S => :P)
    local scores = Dict(:R => 1, :P => 2, :S => 3)
    local moves  = Dict(
        "A" => :R, "B" => :P, "C" => :S,
        "X" => :R, "Y" => :P, "Z" => :S,
    )

    local path  = raw"input.txt"
    local input = split.(readlines(path), r"\s+") .|> 
        x -> getindex.(Ref(moves), x)

    local comp(opponent, player) =
        (beats[player] == opponent) ? 6 :
        (player        == opponent) ? 3 : 0
    
    input .|> (((x, y),) -> comp(x, y) + scores[y]) |> sum |> println
end