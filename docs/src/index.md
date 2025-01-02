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

```jldoctest
julia> DBInterface.execute(conn, @funsql(care_site().limit(1))) |> DataFrame
0×4 DataFrame
 Row │ care_site_id  care_site_name  concept_id  location_id
     │ Int64         String          Int64       Int64
─────┴───────────────────────────────────────────────────────
```

```jldoctest
julia> DBInterface.execute(conn, @funsql(concept().limit(1))) |> DataFrame
1×8 DataFrame
 Row │ concept_id  concept_name  domain_id  vocabulary_id  concept_class_id  s ⋯
     │ Int64       String        String     String         String            S ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │   40316773  Prediabetes   Condition  SNOMED         Clinical Finding  m ⋯
                                                               3 columns omitted
```

```jldoctest
julia> DBInterface.execute(conn, @funsql(location().limit(1))) |> DataFrame
0×10 DataFrame
 Row │ location_id  address_1  address_2  city    state   zip     county  coun ⋯
     │ Int64        String     String     String  String  String  String  Int6 ⋯
─────┴──────────────────────────────────────────────────────────────────────────
                                                               3 columns omitted
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

```jldoctest
julia> DBInterface.execute(conn, @funsql(provider().limit(1))) |> DataFrame
1×8 DataFrame
 Row │ provider_id  provider_name              npi      dea      concept_id  c ⋯
     │ Int64        String                     String?  String?  Int64       I ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │           1  María Elena653 Rodarte647  missing  missing    38004446    ⋯
                                                               3 columns omitted
```

