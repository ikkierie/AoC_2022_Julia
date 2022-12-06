begin
    local path  = raw"input.txt"
    local input = readchomp(path)
    
    local n = 14
    println(findfirst(
        i -> length(∩(@view input[i-n+1:i])) == n, 
        n:length(input)
    ) + n - 1)
end
