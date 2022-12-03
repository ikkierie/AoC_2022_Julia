println("Part One: $(sum(
    findfirst(
        (line[1:(l=length(line)÷2)] ∩ line[l+1:end])[1], 
        (global p = String(['a':'z'; 'A':'Z';]))
    )
    for line ∈ (inp = readlines("input.txt")) 
))\nPart two: $(
    sum(findfirst(reduce(∩, inp[i:i+2])[1], p) for i ∈ 1:3:length(inp))
)")