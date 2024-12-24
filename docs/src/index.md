# FunOMOP.jl

```@meta
DocTestSetup = quote
    using DataFrames
    using DuckDB
    using FunOMOP
    using FunSQL
    conn = get_test_db()
end
```

```@autodocs
Modules = [FunOMOP,]
Order   = [:function, :type]
```

```jldoctest
julia> DBInterface.execute(conn, @funsql(person().limit(1))) |> DataFrame
1×11 DataFrame
 Row │ person_id  gender_concept_id  birth_datetime       death_datetime       ⋯
     │ Int64      Int64              Dates.DateTime       Dates.DateTime       ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │         7               8507  1938-02-22T00:00:00  2019-05-28T00:00:00  ⋯
                                                               7 columns omitted
```
