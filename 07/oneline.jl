println("Part one: $(
    replace(
        replace(
            readchomp("input.txt"), 
            "\$ cd /"         => ((_) -> global cd = ["/"]), 
            r"\$ cd [^\.\s]+" => ((m) -> push!(get!(
                () -> [0, String[]],
                !@isdefined(dirs) ? 
                    (global dirs = Dict()) : 
                    dirs,
                join(push!(cd, match(r"cd (\S+)", m)[1])[1:end-1], '/')
            )[2], join(cd, '/'))), 
            "\$ cd .."        => ((_) -> pop!(cd)), 
            r"\d+"            => ((n) -> get!(
                () -> [0, String[]],
                !@isdefined(dirs) ? (global dirs = Dict()) : dirs,
                join(cd, '/')
            )[1] += parse(Int, n)),
        ),
        r"(.|\n|\r)+" => ((_) -> sum(filter(
            <(100000), 
            (get_size(x) = dirs[x][1] + sum(get_size.(dirs[x][2]); init = 0)).(keys(dirs))
        ))),
    )
)\nPart two: $(
    minimum(filter(>((get_size(x) = dirs[x][1] + sum(get_size.(dirs[x][2]); init = 0))("/") - 40000000), get_size.(keys(dirs))))
)")

