var documenterSearchIndex = {"docs":
[{"location":"#FunOMOP.jl","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"","category":"section"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"Example","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"DocTestSetup = quote\n    using DataFrames\n    using DuckDB\n    using FunOMOP\n    using FunSQL\n\n    global FunOMOP_SQL_dialect = :duckdb\n    conn = get_test_db()\nend","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"Modules = [FunOMOP,]\nOrder   = [:function, :type]","category":"page"},{"location":"#FunOMOP.funsql_care_site-Tuple{}","page":"FunOMOP.jl","title":"FunOMOP.funsql_care_site","text":"funsql_care_site()\n\n\n\n\n\n","category":"method"},{"location":"#FunOMOP.funsql_concept-Tuple{}","page":"FunOMOP.jl","title":"FunOMOP.funsql_concept","text":"funsql_concept()\n\n\n\n\n\n","category":"method"},{"location":"#FunOMOP.funsql_condition-Tuple{}","page":"FunOMOP.jl","title":"FunOMOP.funsql_condition","text":"funsql_condition()\n\n\n\n\n\n","category":"method"},{"location":"#FunOMOP.funsql_drug-Tuple{}","page":"FunOMOP.jl","title":"FunOMOP.funsql_drug","text":"funsql_drug()\n\n\n\n\n\n","category":"method"},{"location":"#FunOMOP.funsql_location-Tuple{}","page":"FunOMOP.jl","title":"FunOMOP.funsql_location","text":"funsql_location()\n\n\n\n\n\n","category":"method"},{"location":"#FunOMOP.funsql_measurement-Tuple{}","page":"FunOMOP.jl","title":"FunOMOP.funsql_measurement","text":"funsql_measurement()\n\n\n\n\n\n","category":"method"},{"location":"#FunOMOP.funsql_person-Tuple{}","page":"FunOMOP.jl","title":"FunOMOP.funsql_person","text":"funsql_person()\n\n\n\n\n\n","category":"method"},{"location":"#FunOMOP.funsql_provider-Tuple{}","page":"FunOMOP.jl","title":"FunOMOP.funsql_provider","text":"funsql_provider()\n\n\n\n\n\n","category":"method"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(care_site().limit(1))) |> DataFrame\n0×4 DataFrame\n Row │ care_site_id  care_site_name  concept_id  location_id\n     │ Int64         String          Int64       Int64\n─────┴───────────────────────────────────────────────────────","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(concept().limit(1))) |> DataFrame\n1×8 DataFrame\n Row │ concept_id  concept_name  domain_id  vocabulary_id  concept_class_id  s ⋯\n     │ Int64       String        String     String         String            S ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │   40316773  Prediabetes   Condition  SNOMED         Clinical Finding  m ⋯\n                                                               3 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(condition().limit(1))) |> DataFrame\n1×11 DataFrame\n Row │ domain_id  occurrence_id  person_id  concept_id  datetime             d ⋯\n     │ String     Int64          Int64      Int64       DateTime             D ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │ Condition              1          1      372328  2002-10-15T00:00:00  2 ⋯\n                                                               6 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(device().limit(1))) |> DataFrame\n1×13 DataFrame\n Row │ domain_id  occurrence_id  person_id  concept_id  datetime             d ⋯\n     │ String     Int64          Int64      Int64       DateTime             D ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │ Device                 1         16     4217646  2009-01-11T00:00:00  m ⋯\n                                                               8 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(drug().limit(1))) |> DataFrame\n1×17 DataFrame\n Row │ domain_id  occurrence_id  person_id  concept_id  datetime             d ⋯\n     │ String     Int64          Int64      Int64       DateTime             D ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │ Drug                   1          1    19073183  2014-04-22T00:00:00  2 ⋯\n                                                              12 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(location().limit(1))) |> DataFrame\n0×10 DataFrame\n Row │ location_id  address_1  address_2  city    state   zip     county  coun ⋯\n     │ Int64        String     String     String  String  String  String  Int6 ⋯\n─────┴──────────────────────────────────────────────────────────────────────────\n                                                               3 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(measurement().limit(1))) |> DataFrame\n1×15 DataFrame\n Row │ domain_id    occurrence_id  person_id  concept_id  datetime             ⋯\n     │ String       Int64          Int64      Int64       DateTime             ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │ Measurement              1          1     3025315  2013-05-17T00:00:00  ⋯\n                                                              10 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(note().limit(1))) |> DataFrame\n0×11 DataFrame\n Row │ domain_id  occurrence_id  person_id  concept_id  datetime  datetime_end ⋯\n     │ String     Int64          Int64      Int64       DateTime  Int32        ⋯\n─────┴──────────────────────────────────────────────────────────────────────────\n                                                               5 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(observation().limit(1))) |> DataFrame\n1×14 DataFrame\n Row │ domain_id    occurrence_id  person_id  concept_id  datetime             ⋯\n     │ String       Int64          Int64      Int64       DateTime             ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │ Observation              1          1    40770471  2022-07-08T00:00:00  ⋯\n                                                               9 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(person().limit(1))) |> DataFrame\n1×11 DataFrame\n Row │ person_id  gender_concept_id  birth_datetime       death_datetime       ⋯\n     │ Int64      Int64              Dates.DateTime       Dates.DateTime       ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │         7               8507  1938-02-22T00:00:00  2019-05-28T00:00:00  ⋯\n                                                               7 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(provider().limit(1))) |> DataFrame\n1×8 DataFrame\n Row │ provider_id  provider_name              npi      dea      concept_id  c ⋯\n     │ Int64        String                     String?  String?  Int64       I ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │           1  María Elena653 Rodarte647  missing  missing    38004446    ⋯\n                                                               3 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(specimen().limit(1))) |> DataFrame\n0×12 DataFrame\n Row │ domain_id  occurrence_id  person_id  concept_id  datetime  datetime_end ⋯\n     │ String     Int64          Int64      Int64       DateTime  Int32        ⋯\n─────┴──────────────────────────────────────────────────────────────────────────\n                                                               6 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(visit().limit(1))) |> DataFrame\n1×12 DataFrame\n Row │ domain_id  occurrence_id  person_id  concept_id  datetime             d ⋯\n     │ String     Int64          Int64      Int64       DateTime             D ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │ Visit                 21          1        9202  2000-12-27T00:00:00  2 ⋯\n                                                               7 columns omitted","category":"page"},{"location":"","page":"FunOMOP.jl","title":"FunOMOP.jl","text":"julia> DBInterface.execute(conn, @funsql(visit_detail().limit(1))) |> DataFrame\n1×14 DataFrame\n Row │ domain_id    occurrence_id  person_id  concept_id  datetime             ⋯\n     │ String       Int64          Int64      Int64       DateTime             ⋯\n─────┼──────────────────────────────────────────────────────────────────────────\n   1 │ VisitDetail        1000021          1        9202  2000-12-27T00:00:00  ⋯\n                                                               9 columns omitted","category":"page"},{"location":"example/#Example","page":"Example","title":"Example","text":"","category":"section"}]
}