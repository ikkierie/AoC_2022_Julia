begin
    local path  = raw"input.txt"
    local input = readlines(path)
    
    local function compare(ls, rs, n = 1)
        local (gt_l, gt_r) = n .> length.((ls, rs))
        (gt_l || gt_r) && (return (gt_l && gt_r) ? nothing : gt_l)

        local l, r = ls[n], rs[n]
        if (l isa Int) && (r isa Int)
            return (l != r) ? (l < r) : compare(ls, rs, n + 1)
        else
            !(l isa Vector) && (l = [l])
            !(r isa Vector) && (r = [r])
            local result = compare(l, r)
            return isnothing(result) ? 
                compare(ls, rs, n + 1) :
                result
        end
    end

    local in_order_count = 0
    for (index, i) ∈ enumerate(1:3:length(input))
        local l = input[i + 0] |> Meta.parse |> eval
        local r = input[i + 1] |> Meta.parse |> eval
        compare(l, r) && (in_order_count += index)
    end

    println(in_order_count)
end