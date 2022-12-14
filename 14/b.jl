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

    local x_min = minimum(first.(keys(cave)))
    local x_max = maximum(first.(keys(cave)))

    local width = x_max - x_min + 1

    local highest = min(0, minimum(last.(keys(cave))))
    local lowest = maximum(last.(keys(cave))) + 2

    local height = lowest - highest + 1

    local shows = Dict(air => ' ', rock => '#', sand => 'o')

    local function do_show(pause::Bool = false)
        print("\x1b[H")
        display([ 
            shows[get(cave, (x, y), air)] 
            for y ∈ highest:lowest, 
                x ∈ x_min:x_max 
        ])
        pause && readline()
    end

    local spawn = (500, 0)

    local check_dirs = [ (0, 1), (-1, 1), (1, 1) ]

    local success = 0
    local cur_sand = nothing
    while spawn ∉ keys(cave)
        #do_show()
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