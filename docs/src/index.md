# FunOMOP.jl

```@docs
func(x)
```

```@docs
main()
```

```@docs
funsql_person()
```

```@docs
funsql_concept()
```

```@docs
execute_query(q)
```

```@meta
DocTestSetup = quote
	using DataFrames
	using FunOMOP
	using FunSQL
end
```

```jldoctest
julia> execute_query(@funsql person())
28×11 DataFrame
 Row │ person_id  gender_concept_id  birth_datetime       death_datetime       ⋯
     │ Int64      Int64              Dates.DateTime       Dates.DateTime?      ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │         7               8507  1938-02-22T00:00:00  2019-05-28T00:00:00  ⋯
   2 │        11               8532  1953-09-21T00:00:00  2009-09-14T00:00:00
   3 │        23               8507  1998-04-09T00:00:00  2001-07-13T00:00:00
   4 │         1               8507  1998-04-09T00:00:00  missing
   5 │         2               8532  2014-10-22T00:00:00  missing              ⋯
   6 │         3               8507  2011-06-10T00:00:00  missing
   7 │         4               8507  2000-08-14T00:00:00  missing
   8 │         5               8507  1988-09-22T00:00:00  missing
  ⋮  │     ⋮              ⋮                   ⋮                    ⋮           ⋱
  22 │        21               8532  1983-10-05T00:00:00  missing              ⋯
  23 │        22               8532  1968-10-09T00:00:00  missing
  24 │        24               8507  1980-06-04T00:00:00  missing
  25 │        25               8507  2003-12-18T00:00:00  missing
  26 │        26               8507  1938-02-22T00:00:00  missing              ⋯
  27 │        27               8507  2022-02-08T00:00:00  missing
  28 │        28               8532  1970-07-10T00:00:00  missing
                                                   7 columns and 13 rows omitted
```
