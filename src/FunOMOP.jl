module FunOMOP

using Artifacts
using CSV
using DataFrames
using DuckDB
using FunSQL
using HTTP
using TRDW

#function remote_test_csv(omop_table_name)
	#url = "https://raw.githubusercontent.com/AshlinHarris/OmopTestData/refs/heads/main/assets/omop-mimic-iv/1_omop_data_csv/$(omop_table_name).csv"
	#return HTTP.get(url).body |> CSV.File
#end

function main()
DATABASE = joinpath(artifact"synthea_omop_test", "synthea_omop_test.db",)
conn = DBInterface.connect(FunSQL.DB{DuckDB.DB}, DATABASE)

	query = @funsql begin
    from(person)
    filter(1930 <= year_of_birth <= 1940)
    #=
    join(
        from(location).filter(state == "IL").as(location),
        on = location_id == location.location_id)
	=#
    left_join(
        from(visit_occurrence).group(person_id).as(visit_group),
        on = person_id == visit_group.person_id)
    select(
        person_id,
        latest_visit_date => visit_group.max(visit_start_date))
end

DBInterface.execute(conn, query)
end

end # module FunOMOP
