mutable struct Monkey
    items::Vector{Int}
    op::Function
    test::Function
    inspections::Int
end

test(n, a, b) = ((x) -> (x % n == 0) ? a + 1 : b + 1)

function main()
    local path  = raw"input.txt"
    local input = replace(read(path, String), "\r\n" => "\n")

    local divisors = Int[]
    local monkeys = Monkey[]
    for (monkey, data) ∈ eachmatch(r"Monkey (\d+):\n(.+?)\n\n"s, input)
        push!(monkeys, Monkey(
            # items list
            parse.(Int, split(
                first(match(r"Starting items: (.+)", data)), 
                r",\s*"
            )),

            # operation function
            "old -> $(first(match(r"Operation: new = (.+)", data)))" |> 
                    Meta.parse |> eval,

            # test function
            test(parse.(Int, collect(match(
                r"divisible by (\d+).+?(\d+).+?(\d+)"s, 
                data
            )))...),

            # № inspections
            0
        ))
        push!(divisors, parse(Int, first(match(r"divisible by (\d+)", data))))
    end

    local common_div = lcm(divisors)

    for round ∈ 1:10000, monkey ∈ monkeys
        local items = monkey.items
        while !isempty(items)
            local worry = popfirst!(items)
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