begin
    local path  = raw"input.txt"
    local input = readlines(path)
    
    local priorities = Dict((v, k) for (k, v) ∈ pairs(['a':'z'; 'A':'Z';]))

    local sum = 0
    for i ∈ 1:3:length(input)
        local lines = @view(input[i:i+2])
        sum += priorities[reduce(∩, lines)[1]]
    end

    println(sum)
end