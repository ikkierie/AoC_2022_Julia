println("Part one: $(count(
    (x ∈ 2:size(input, 2)-1 && y ∈ 2:size(input, 1)-1) ?
        any(all.(<(input[y, x]), [
            input[begin:y-1, x], 
            input[y+1:end, x], 
            input[y, begin:x-1], 
            input[y, x+1:end]
        ])) : true
    for (x, y) ∈ Tuple.(CartesianIndices(
        global input = reduce(hcat, 
            parse.(Int, collect(x)) 
            for x ∈ readlines("input.txt")
        )
    ))
))\nPart two: $(maximum(
    (x ∈ 2:size(input, 2)-1 && y ∈ 2:size(input, 1)-1) ?
        prod(@something findfirst(>=(input[y, x]), z) length(z) for z ∈ [
            input[y-1:-1:begin, x], 
            input[y+1:end, x], 
            input[y, x-1:-1:begin], 
            input[y, x+1:end]
        ]) : 0
    for (x, y) ∈ Tuple.(CartesianIndices(input))
))")