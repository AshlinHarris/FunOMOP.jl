module FunOMOP

using CSV
using DataFrames
using DuckDB
using HTTP

function remote_test_csv(omop_table_name)
	url = "https://raw.githubusercontent.com/AshlinHarris/OmopTestData/refs/heads/main/assets/omop-mimic-iv/1_omop_data_csv/$(omop_table_name).csv"
	return HTTP.get(url).body |> CSV.File
end

end # module FunOMOP
