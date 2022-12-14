using Base.Iterators: cycle, drop

@enum Cave air rock sand

function main()
    local path = raw"input.txt"
    local input = readlines(path)
    
    local cave = Dict{Tuple{Int, Int}, Cave}()

    for rocks ∈ input
        local rockpath = [ 
            parse.(Int, (x, y)) 
            for (x, y) ∈ eachmatch(r"(\d+),(\d+)", rocks) 
        ]

        for ((x1, y1), (x2, y2)) ∈ zip(rockpath, drop(rockpath, 1))
            local rx = min(x1, x2):max(x1, x2)
            local ry = min(y1, y2):max(y1, y2)
            local r  = (length(rx) > length(ry)) ? 
                    zip(rx, cycle(ry))           : 
                    zip(cycle(rx), ry)
            push!.(Ref(cave), r .=> rock)
        end
    end

    local lowest = maximum(last.(keys(cave))) + 2

    local spawn = (500, 0)
    local check_dirs = [ (0, 1), (-1, 1), (1, 1) ]

    local success = 0
    local cur_sand = nothing
    while spawn ∉ keys(cave)
        if isnothing(cur_sand)
            cave[spawn] = sand
            cur_sand = spawn
        end
        local moved = false
        for dir ∈ check_dirs
            local new_pos = cur_sand .+ dir
            if last(new_pos) < lowest && new_pos ∉ keys(cave)
                pop!(cave, cur_sand)
                cave[new_pos] = sand
                cur_sand = new_pos
                moved = true
                break
            end
        end
        if !moved
            cur_sand = nothing
            success += 1
        end
    end

    println(success)
end

main()