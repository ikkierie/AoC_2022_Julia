begin
    local path  = raw"input.txt"
    local input = read(path, String)
    
    local test(n, a, b) = ((x) -> (x % n == 0) ? a + 1 : b + 1)
    
    mutable struct Monkey
        items::Vector{Int}
        op::Function
        test::Function
        inspections::Int
    end

    local monkeys = Monkey[]
    for (monkey, data) ∈ eachmatch(r"Monkey (\d+):\r\n([\s\S]+?)\r\n\r\n", input)
        push!(monkeys, Monkey(
            parse.(Int, split(
                first(match(r"Starting items: (.+)", data)), 
                r",\s*"
            )),

            #= 
                I'm pretty sure I'm doing something wrong here
                with the metaprogramming here. Not sure how to
                fix it/properly do what I want yet, though.
            =#
            eval(Expr(:->, 
                :old, 
                match(r"Operation: new = (.+)", data) |> 
                    first                             |> 
                    Meta.parse
            )),

            test(parse.(Int, collect(match(
                r"divisible by (\d+)[\s\S]+?(\d+)[\s\S]+?(\d+)", 
                data
            )))...),

            0
        ))
    end

    for round ∈ 1:20, monkey ∈ monkeys
        while !isempty(monkey.items)
            local worry = popfirst!(monkey.items)
            worry = monkey.op(worry) ÷ 3
            push!(monkeys[monkey.test(worry)].items, worry)
            monkey.inspections += 1
        end
    end

    sort(getfield.(monkeys, :inspections))[end-1:end] |>
        prod                                          |>
        println
end