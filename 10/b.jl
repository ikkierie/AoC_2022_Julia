begin
    local path = raw"input.txt"
    
    local crt   = Set{Int}()
    local x     = 1
    local clock = 0

    local function draw()
        ((clock % 40) ∈ (x-1:x+1)) && push!(crt, clock % 2400)
    end

    local function tick()
        draw()
        clock += 1
    end

    for line ∈ eachline(path)
        local instr, payload = match(r"^(\S+)\s*(\S*)", line)
        tick()
        if instr == "addx"
            tick()
            x += parse(Int, payload)
        end
    end

    println.(
        String([ (40i + j) ∈ crt ? '█' : ' ' for j ∈ 0:39 ])
        for i ∈ 0:5
    )
end