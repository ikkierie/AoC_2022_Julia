begin
    local start, goal
    local nodes = Dict{Tuple{Int, Int}, Int}(
        (x, y) => Int(
            if     node == 'S'; start = (x, y); 'a'
            elseif node == 'E'; goal  = (x, y); 'z'
            else;               node
            end - 0x61
        )
        for (y, line) ∈ enumerate(eachline(raw"input.txt"))
        for (x, node) ∈ enumerate(line)
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

        (cur_node == goal) && break

        for dir ∈ dirs
            local new_node = cur_node .+ dir
            if      new_node ∈ keys(nodes)      && 
                    new_node ∉ keys(visited)    && 
                    nodes[new_node] <= nodes[cur_node] + 1

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

    print(visited[goal])
end