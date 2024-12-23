# FunOMOP.jl

```@meta
DocTestSetup = quote
    using DataFrames
    using DuckDB
    using FunOMOP
    using FunSQL
    con = get_test_db_connection()
end
```

```@autodocs
Modules = [FunOMOP,]
Order   = [:function, :type]
```

```jldoctest
julia> DBInterface.execute(con, "SELECT * FROM person LIMIT 1;") |> DataFrame
1×18 DataFrame
 Row │ person_id  gender_concept_id  year_of_birth  month_of_birth  day_of_bir ⋯
     │ Int64      Int64              Int64          Int64           Int64      ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │         1               8507           1998               4             ⋯
                                                              14 columns omitted
```

```jldoctest
julia> DBInterface.execute(con, @funsql person()) |> DataFrame
1×18 DataFrame
 Row │ person_id  gender_concept_id  year_of_birth  month_of_birth  day_of_bir ⋯
     │ Int64      Int64              Int64          Int64           Int64      ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │         1               8507           1998               4             ⋯
                                                              14 columns omitted
```
