begin
    local path  = raw"input.txt"
    local input = readlines(path)
    
    local priorities = Dict((v, k) for (k, v) ∈ pairs(['a':'z'; 'A':'Z';]))

    local sum = 0
    for line ∈ input
        local len = length(line)
        sum += @views priorities[(line[begin:len÷2] ∩ line[len÷2+1:end])[1]]
    end

    println(sum)
end