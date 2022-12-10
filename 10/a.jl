begin
    local path = raw"input.txt"
    
    local x     = 1
    local clock = 0
    local score = 0

    local function tick()
        clock += 1
        ((clock - 20) % 40 == 0) && (score += clock * x)
    end

    for line ∈ eachline(path)
        local instr, payload = match(r"^(\S+)\s*(\S*)", line)
        tick()
        if instr == "addx"
            tick()
            x += parse(Int, payload)
        end
    end

    println(score)
end