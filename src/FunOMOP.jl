module FunOMOP

export get_test_db
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

include("concept.jl")
include("care_site.jl")
include("location.jl")
include("person.jl")
include("provider.jl")

"""
    get_test_db()
Build a test database in memory and return the connection
"""
function get_test_db()

    # New database in memory
    DATABASE = ":memory:"
    conn = DBInterface.connect(DuckDB.DB, DATABASE)

    # Parse the ddl into individual commands
    pattern = r"CREATE TABLE @cdmDatabaseSchema.([\w_]*) \(([\s\S]*?)[\n\)];"
    input_file_contents = read(joinpath(artifact"omop_ddl", "OMOPCDM_duckdb_5.4_ddl.sql"), String)
    for match in eachmatch(pattern, input_file_contents)

        # Create the table
        command = replace(match.match,
            "@cdmDatabaseSchema." => "",
            "integer" => "BIGINT",
        )
        DBInterface.execute(conn, command)

        # Write the data
        table_name = match.captures |> first |> String |> uppercase
        file_name = joinpath(artifact"synthea_omop_test", "Synthea27Nj_5.4", "$table_name.csv")
        DBInterface.execute(conn, "COPY $table_name FROM '$file_name';")
    end

    # Update the catalog for any new tables
    catalog = FunSQL.reflect(conn, dialect=:duckdb)
    updated_conn = FunSQL.DB(conn, catalog = catalog)

    return updated_conn

end

end # module FunOMOP
