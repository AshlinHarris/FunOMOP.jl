module FunOMOP

export funsql_concept
export funsql_care_site
export funsql_device
export funsql_location
export funsql_note
export funsql_observation
export funsql_person
export funsql_provider
export funsql_specimen
export funsql_visit
export funsql_visit_detail

using Artifacts
using CSV
using DataFrames
using DuckDB
using FunSQL

include("omop/concept.jl")
include("omop/care_site.jl")
include("omop/device.jl")
include("omop/location.jl")
include("omop/note.jl")
include("omop/observation.jl")
include("omop/person.jl")
include("omop/provider.jl")
include("omop/specimen.jl")
include("omop/visit.jl")
include("omop/visit_detail.jl")

#TODO: automatically read this from the database or the FunSQL command?
if !@isdefined(FunOMOP_SQL_dialect)
    @warn("`FunOMOP_SQL_dialect` is not set. Options are :spark or :duckdb (default)")
    global FunOMOP_SQL_dialect = :duckdb
end
include("duckdb.jl")

end # module FunOMOP
