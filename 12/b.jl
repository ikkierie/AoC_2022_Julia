begin
    local start
    local goals = Tuple{Int, Int}[]
    local nodes = Dict{Tuple{Int, Int}, Int}(
        (x, y) => Int(
            if     node == 'E'; start = (x, y);       'z'
            elseif node == 'a'; push!(goals, (x, y)); 'a'
            else;               node
            end - 0x61
        )
        for (y, line) ∈ enumerate(eachline(raw"input.txt"))
        for (x, node) ∈ enumerate(replace(line, 'S' => 'a'))
    )

    local dirs = [
        ( 1,  0),
        (-1,  0),
        ( 0,  1),
        ( 0, -1),
    ]

    local visited = Dict{Tuple{Int, Int}, Int}()
    local seen    = Dict(start => 0)
    local queue   = [start]
    while !isempty(queue)
        local cur_node    = popfirst!(queue)
        local len         = seen[cur_node]
        visited[cur_node] = len

        for dir ∈ dirs
            local new_node = cur_node .+ dir
            if      new_node ∈ keys(nodes)      && 
                    new_node ∉ keys(visited)    && 
                    nodes[cur_node] <= nodes[new_node] + 1

                if new_node ∉ keys(seen)
                    push!(queue, new_node)
                end
                seen[new_node] = min(
                    get(seen, new_node, Inf),
                    len + 1
                )
            end
        end
    end

    get.(Ref(visited), goals, Inf) |> minimum |> Int |> println
end