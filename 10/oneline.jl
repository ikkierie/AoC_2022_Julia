println("Part one: $((
    global output = reduce(
        (state, (instr, payload)) -> instr == "addx" ? 
            (!@isdefined(tick) ? 
                (global tick = ((crt, clock, score, x), (instr, payload)) -> (
                    ((clock % 40) ∈ (x-1:x+1)) ? push!(crt, clock % 2400) : crt,
                    clock += 1,
                    ((clock - 20) % 40 == 0) ? (score + clock * x) : score,
                    instr == "addx" ? x + parse(Int, payload) : x
                )) : 
                tick
            )(tick(state, (nothing, nothing)), (instr, payload)) : 
            tick(state, (nothing, nothing)),
        match.(r"^(\S+)\s*(\S*)", eachline("input.txt"));
        init = (Set{Int}(), 0, 0, 1)
    )
)[3])\nPart two:\n$(
    join(
        [ String([ (40i + j) ∈ output[1] ? '█' : ' ' for j ∈ 0:39 ]) for i ∈ 0:5 ],
        '\n'
    )
)")