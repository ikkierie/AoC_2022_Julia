begin
    local path  = raw"input.txt"
    local input = filter(x -> !all(isspace, x), readlines(path)) .|> 
            Meta.parse                                           .|> 
            eval
    
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

    local ps = [[[2]], [[6]]]
    append!(input, ps)
    sort!(input, lt = compare)

    findfirst.(.==(ps), Ref(input)) |> prod |> println
end