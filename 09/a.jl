begin
    local path  = raw"input.txt"
    local input = match.(r"(\S) (\d+)", readlines(path))
    
    local head = (0, 0)
    local tail = (0, 0)
    
    local grid = Set([tail])

    local dirs = Dict(
        "U" => ( 0,  1),
        "D" => ( 0, -1),
        "R" => ( 1,  0),
        "L" => (-1,  0),
    )

    local safe = Set((x, y) for x ∈ -1:1, y ∈ -1:1)

    for (dir, mag) ∈ input
        for _ ∈ 1:parse(Int, mag)
            head = head .+ dirs[dir]
            if (tail .- head) ∉ safe
                tail = !any(tail .== head) ?
                    tail .+ copysign.((1, 1), (head .- tail)) :
                    tail .+ (head .- tail) .- sign.(head .- tail)
            end
            push!(grid, tail)
        end
    end

    println(length(grid))
end