begin
    local path = raw"input.txt"
    local input = reduce(hcat,
        parse.(Int, collect(x)) for x ∈ readlines(path)
    )

    local scores = zeros(Int, size(input))
    for y ∈ 2:size(input, 1)-1, x ∈ 2:size(input, 2)-1
        local zs = @views [
            input[y-1:-1:begin, x           ],
            input[y+1:end,      x           ],
            input[y,            x-1:-1:begin],
            input[y,            x+1:end     ],
        ]
        scores[y, x] = prod(@something findfirst(>=(input[y, x]), z) length(z) for z ∈ zs)
    end

    println(maximum(scores))
    println("Done.")
end