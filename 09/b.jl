begin
    local path  = raw"input.txt"
    local input = match.(r"(\S) (\d+)", readlines(path))

    local n     = 10
    local knots = [ (0, 0) for x ∈ 1:n ]

    local grid = Set(knots)

    local dirs = Dict(
        "U" => ( 0,  1),
        "D" => ( 0, -1),
        "R" => ( 1,  0),
        "L" => (-1,  0),
    )

    local safe = Set((x, y) for x ∈ -1:1, y ∈ -1:1)

    for (dir, mag) ∈ input
        for _ ∈ 1:parse(Int, mag)
            knots[1] = knots[1] .+ dirs[dir]
            for k ∈ 2:n
                local head = knots[k-1]
                local tail = knots[k]
                if (tail .- head) ∉ safe
                    knots[k] = !any(tail .== head) ?
                        tail .+ copysign.((1, 1), (head .- tail)) :
                        tail .+ (head .- tail) .- sign.(head .- tail)
                end
            end
            push!(grid, knots[end])
        end
    end

    println(length(grid))
end