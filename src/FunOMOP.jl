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

include("concept.jl")
include("care_site.jl")
include("location.jl")
include("person.jl")
include("provider.jl")

"""
    execute_query(q)
Run the FunSQL query against a sample data set
"""
function execute_query(q)

    con = DBInterface.connect(FunSQL.DB{DuckDB.DB}, ":memory:")

    #TODO: maybe name the schema?
	# Parse the ddl into individual commands
	pattern = r"CREATE TABLE @cdmDatabaseSchema.([\w_]*) \(([\s\S]*?)[\n\)];"
	input_file_contents = read(joinpath(artifact"omop_ddl", "OMOPCDM_duckdb_5.4_ddl.sql"), String)
	for match in eachmatch(pattern, input_file_contents)

		# Create the table
		command = replace(match.match,
			"@cdmDatabaseSchema." => "",
			"integer" => "BIGINT",
		)
		DBInterface.execute(con, command)

		# Write the data
		table_name = match.captures |> first |> String |> uppercase
		file_name = joinpath(artifact"synthea_omop_test", "Synthea27Nj_5.4", "$table_name.csv")
		DBInterface.execute(con, "COPY $table_name FROM '$file_name';")
	end

    #DBInterface.execute(con, "SHOW TABLES;") |> DataFrame |> x->x.name
    #TODO: temporarily disabled
    #DBInterface.execute(con, q) |> DataFrame
    DBInterface.execute(con, "select * from person limit 1;") |> DataFrame
end

end # module FunOMOP
