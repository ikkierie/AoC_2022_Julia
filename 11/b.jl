mutable struct Monkey
    items::Vector{Int}
    op::Function
    test::Function
    inspections::Int
end

test(n, a, b) = ((x) -> (x % n == 0) ? a + 1 : b + 1)

function main()
    local path  = raw"input.txt"
    local input = read(path, String)

    local divisors = Int[]
    local monkeys = Monkey[]
    for (monkey, data) ∈ eachmatch(r"Monkey (\d+):\r\n([\s\S]+?)\r\n\r\n", input)
        push!(monkeys, Monkey(
            parse.(Int, split(
                first(match(r"Starting items: (.+)", data)), 
                r",\s*"
            )),

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
        push!(
            divisors, 
            parse(Int, first(match(r"divisible by (\d+)", data)))
        )
    end

    local common_div = lcm(prod(divisors))

    for round ∈ 1:10000, monkey ∈ monkeys
        while !isempty(monkey.items)
            local worry = popfirst!(monkey.items)
            worry = Base.invokelatest(monkey.op, worry) % common_div
            push!(monkeys[monkey.test(worry)].items, worry)
            monkey.inspections += 1
        end
    end

    sort(getfield.(monkeys, :inspections))[end-1:end] |>
        prod                                          |>
        println
end

main()