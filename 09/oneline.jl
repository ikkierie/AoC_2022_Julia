println("Part one: $(length([push!((!@isdefined(grid) ? (global grid = Set([global head = global tail = (0, 0)])) : grid), (tail .- (global head = head .+ (!@isdefined(dirs) ? (global dirs = Dict("U" => (0, 1), "D" => (0, -1), "R" => (1, 0), "L" => (-1, 0))) : dirs)[dir])) ∉ (!@isdefined(safe) ? (global safe = Set((x, y) for x ∈ -1:1, y ∈ -1:1)) : safe) ? (global tail = tail .+ (!any(tail .== head) ? copysign.((1, 1), (head .- tail)) : (head .- tail) .- sign.(head .- tail))) : (0, 0)) for (dir, mag) ∈ (global input = match.(r"(\S) (\d+)", readlines("input.txt"))) for _ ∈ 1:parse(Int, mag)][1]))\nPart two: $(length([push!((!@isdefined(grid2) ? (global grid2 = Set(global knots = [ (0, 0) for x ∈ 1:10 ])) : grid2), [k == 1 ? (knots[1] = knots[1] .+ dirs[dir]) : ((knots[k] .- knots[k-1]) ∉ safe ? (knots[k] = knots[k] .+ (!any(knots[k] .== knots[k-1]) ? copysign.((1, 1), (knots[k-1] .- knots[k])) : (knots[k-1] .- knots[k]) .- sign.(knots[k-1] .- knots[k]))) : knots[k]) for k ∈ 1:10][end]) for (dir, mag) ∈ input for _ ∈ 1:parse(Int, mag)][1]))")