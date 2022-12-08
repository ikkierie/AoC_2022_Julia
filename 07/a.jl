begin
    local path  = raw"input.txt"
    local input = readlines(path)

    local cd_pattern = r"(?x)^
        (\$\s+cd\s+(?P<new_dir>\S+)) |
        (\$\s+ls)                    |
        (dir\s+(?P<name>\S+))        |
        ((?P<size>\d+)\s+\S+)
    $"

    mutable struct Dir
        size::Int
        subdirs::Vector{String}
        Dir() = new(0, String[])
    end

    local cd   = ["/"]
    local dirs = Dict{String, Dir}()

    for line ∈ input
        local m  = match(cd_pattern, line)
        local wd = join(cd, '/')
        if !isnothing(local dir = m[:new_dir])
            if     dir == "/";  push!(empty!(cd), "/")
            elseif dir == ".."; pop!(cd)
            else;               push!(cd, dir)
            end
        elseif !isnothing(local name = m[:name])
            push!(get!(Dir, dirs, wd).subdirs, "$wd/$name")
        elseif !isnothing(m[:size])
            get!(Dir, dirs, wd).size += parse.(Int, m[:size])
        end
    end
    
    get_size(x) = let dir = dirs[x]
        dir.size + sum(get_size.(dir.subdirs), init = 0)
    end

    println(sum(filter(<(100000), get_size.(keys(dirs)))))
end