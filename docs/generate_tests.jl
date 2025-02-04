using Documenter
using FunOMOP

@info("Generating index.md (this isn't a typical step for building documentation)")

fh = open("src/index.md", "w")

write(fh, "\n")
write(fh, """[//]: # "DON'T EDIT THIS FILE! IT WAS GENERATED BY generate_doctests.jl" """)
write(fh, "\n")
write(fh, """
# FunOMOP.jl

[Example](@ref)

```@contents
```

```@index
```


```@meta
DocTestSetup = quote
    using DataFrames
    using DuckDB
    using FunOMOP
    using FunSQL

    global FunOMOP_SQL_dialect = :duckdb
    conn = get_test_db()
end
```

```@autodocs
Modules = [FunOMOP,]
Order   = [:function, :type]
```

""")

#TODO: automatically separate out DuckDB functions
for function_name in string.(names(FunOMOP))
    if startswith(function_name, "funsql_") && function_name ∉ ["funsql_format", "funsql_strptime"]
        stripped_name = replace(function_name, r"^funsql_"=>"")
write(fh,"
```jldoctest
julia> DBInterface.execute(conn, @funsql($(stripped_name)().limit(1))) |> DataFrame
```
"
)
end
end

close(fh)

makedocs(
    sitename = "FunOMOP",
    format = Documenter.HTML(),
    modules = [FunOMOP],
    doctest = :fix,
    #warnonly = true,
)

