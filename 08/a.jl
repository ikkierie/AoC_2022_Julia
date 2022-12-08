begin
    local path = raw"input.txt"
    local input = reduce(hcat, 
        parse.(Int, collect(x)) for x ∈ readlines(path)
    )

    local visible = ones(Bool, size(input))
    for y ∈ 2:size(input, 1)-1, x ∈ 2:size(input, 2)-1
        local xs = @views [
            input[begin:y-1, x        ],
            input[y+1:end,   x        ],
            input[y,         begin:x-1],
            input[y,         x+1:end  ],
        ]
        visible[y, x] = any(all.(<(input[y, x]), xs))
    end

    println(count(visible))
end