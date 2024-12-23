# FunOMOP.jl
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://ashlinharris.github.io/FunOMOP.jl/dev/)

## Example
```julia
julia> using DataFrames, DuckDB, FunOMOP, FunSQL

julia> conn = get_test_db();

julia> query = @funsql person().limit(1).select(year_of_birth);

julia> DBInterface.execute(conn, query) |> DataFrame
1×1 DataFrame
 Row │ year_of_birth 
     │ Int64         
─────┼───────────────
   1 │          1998

```

For more details, see the internal documentation (`help?> FunOMOP`).

