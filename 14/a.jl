using Base.Iterators: cycle, drop

@enum Cave air rock sand

function main()
    local path = raw"input.txt"
    local input = readlines(path)
    
    local cave = Dict{Tuple{Int, Int}, Cave}()

    local spawn = (500, 0)

    for rocks ∈ input
        local rockpath = (
            parse.(Int, (x, y)) 
            for (x, y) ∈ eachmatch(r"(\d+),(\d+)", rocks) 
        )

        for ((x₁, y₁), (x₂, y₂)) ∈ zip(rockpath, drop(rockpath, 1))
            local rx = min(x₁, x₂):max(x₁, x₂)
            local ry = min(y₁, y₂):max(y₁, y₂)
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

    do_show() = [ 
            shows[get(cave, (x, y), air)] 
            for y ∈ highest:lowest, 
                x ∈ x_min:x_max 
        ] |> display

    #do_show()

    local check_dirs = [ (0, 1), (-1, 1), (1, 1) ]

    local success = 0
    local cur_sand = nothing
    for round ∈ 1:typemax(Int)
        #=
        println("\x1b[2J\x1b[H$round")
        do_show()
        readline()
        =#
        if isnothing(cur_sand)
            cave[spawn] = sand
            cur_sand = spawn
        elseif cur_sand[2] > lowest
            println(success)
            break
        else
            local moved = false
            for dir ∈ check_dirs
                local new_pos = cur_sand .+ dir
                if new_pos ∉ keys(cave)
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
    end

    println("Done.")
end

main()