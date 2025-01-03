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
julia> DBInterface.execute(conn, @funsql(condition().limit(1))) |> DataFrame
1×11 DataFrame
 Row │ domain_id  occurrence_id  person_id  concept_id  datetime             d ⋯
     │ String     Int64          Int64      Int64       DateTime             D ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ Condition              1          1      372328  2002-10-15T00:00:00  2 ⋯
                                                               6 columns omitted
```

```jldoctest
julia> DBInterface.execute(conn, @funsql(device().limit(1))) |> DataFrame
1×13 DataFrame
 Row │ domain_id  occurrence_id  person_id  concept_id  datetime             d ⋯
     │ String     Int64          Int64      Int64       DateTime             D ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ Device                 1         16     4217646  2009-01-11T00:00:00  m ⋯
                                                               8 columns omitted
```

```jldoctest
julia> DBInterface.execute(conn, @funsql(drug().limit(1))) |> DataFrame
1×17 DataFrame
 Row │ domain_id  occurrence_id  person_id  concept_id  datetime             d ⋯
     │ String     Int64          Int64      Int64       DateTime             D ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ Drug                   1          1    19073183  2014-04-22T00:00:00  2 ⋯
                                                              12 columns omitted
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
julia> DBInterface.execute(conn, @funsql(measurement().limit(1))) |> DataFrame
1×15 DataFrame
 Row │ domain_id    occurrence_id  person_id  concept_id  datetime             ⋯
     │ String       Int64          Int64      Int64       DateTime             ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ Measurement              1          1     3025315  2013-05-17T00:00:00  ⋯
                                                              10 columns omitted
```

```jldoctest
julia> DBInterface.execute(conn, @funsql(note().limit(1))) |> DataFrame
0×11 DataFrame
 Row │ domain_id  occurrence_id  person_id  concept_id  datetime  datetime_end ⋯
     │ String     Int64          Int64      Int64       DateTime  Int32        ⋯
─────┴──────────────────────────────────────────────────────────────────────────
                                                               5 columns omitted
```

```jldoctest
julia> DBInterface.execute(conn, @funsql(observation().limit(1))) |> DataFrame
1×14 DataFrame
 Row │ domain_id    occurrence_id  person_id  concept_id  datetime             ⋯
     │ String       Int64          Int64      Int64       DateTime             ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ Observation              1          1    40770471  2022-07-08T00:00:00  ⋯
                                                               9 columns omitted
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

```jldoctest
julia> DBInterface.execute(conn, @funsql(specimen().limit(1))) |> DataFrame
0×12 DataFrame
 Row │ domain_id  occurrence_id  person_id  concept_id  datetime  datetime_end ⋯
     │ String     Int64          Int64      Int64       DateTime  Int32        ⋯
─────┴──────────────────────────────────────────────────────────────────────────
                                                               6 columns omitted
```

```jldoctest
julia> DBInterface.execute(conn, @funsql(visit().limit(1))) |> DataFrame
1×12 DataFrame
 Row │ domain_id  occurrence_id  person_id  concept_id  datetime             d ⋯
     │ String     Int64          Int64      Int64       DateTime             D ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ Visit                 21          1        9202  2000-12-27T00:00:00  2 ⋯
                                                               7 columns omitted
```

```jldoctest
julia> DBInterface.execute(conn, @funsql(visit_detail().limit(1))) |> DataFrame
1×14 DataFrame
 Row │ domain_id    occurrence_id  person_id  concept_id  datetime             ⋯
     │ String       Int64          Int64      Int64       DateTime             ⋯
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ VisitDetail        1000021          1        9202  2000-12-27T00:00:00  ⋯
                                                               9 columns omitted
```

