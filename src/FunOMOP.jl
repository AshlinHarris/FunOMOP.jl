module FunOMOP

export execute_query
export funsql_person
export funsql_care_site
export funsql_location
export funsql_provider
export funsql_concept

using Artifacts
using CSV
using DataFrames
using DuckDB
using FunSQL
using HTTP

"""
    execute_query(q)
Run the FunSQL query against a sample data set
"""
function execute_query(q)
    DATABASE = joinpath(artifact"synthea_omop_test", "synthea_omop_test.db",)
    conn = DBInterface.connect(FunSQL.DB{DuckDB.DB}, DATABASE)
    DBInterface.execute(conn, q) |> DataFrame
end

include("concept.jl")
include("care_site.jl")
include("location.jl")
include("person.jl")
include("provider.jl")

end # module FunOMOP
