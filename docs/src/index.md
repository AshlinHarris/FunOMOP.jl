# FunOMOP.jl

```@meta
DocTestSetup = quote
	using DataFrames
	using DuckDB
	using FunOMOP
	using FunSQL
end
```

```@autodocs
Modules = [FunOMOP,]
Order   = [:function, :type]
```

```jldoctest
julia> execute_query(@funsql person())
1×18 DataFrame
 Row │ person_id  gender_concept_id  year_of_birth  month_of_birth  day_of_bir ⋯
     │ Int64      Int64              Int64          Int64           Int64      ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │         1               8507           1998               4             ⋯
                                                              14 columns omitted
```
