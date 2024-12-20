module FunOMOP

export person
export main

using Artifacts
using CSV
using DataFrames
using DuckDB
using FunSQL
using HTTP

export func

"""
    func(x)

Return double the number `x` plus `1`.
"""
func(x) = 2x + 1

#function remote_test_csv(omop_table_name)
	#url = "https://raw.githubusercontent.com/AshlinHarris/OmopTestData/refs/heads/main/assets/omop-mimic-iv/1_omop_data_csv/$(omop_table_name).csv"
	#return HTTP.get(url).body |> CSV.File
#end
#
#person() = begin
#

"""
    person()
hello
"""
function person()
	@funsql begin
    from(person)
    left_join(
        death => from(death),
        person_id == death.person_id,
        optional = true)
    as(omop)
    define(
        person_id => omop.person_id,
        gender_concept_id => omop.gender_concept_id,
        birth_datetime => coalesce(omop.birth_datetime,
                              timestamp(
                                  make_date(omop.year_of_birth,
                                  coalesce(omop.month_of_birth, 1),
                                  coalesce(omop.day_of_birth, 1)))),
        death_datetime => coalesce(omop.death.death_datetime,
                              timestamp(omop.death.death_date)),
        death_concept_id =>
            case(is_not_null(omop.death.person_id),
                 coalesce(omop.death.cause_concept_id, 0)),
        death_type_concept_id => omop.death.death_type_concept_id,
        race_concept_id => omop.race_concept_id,
        ethnicity_concept_id => omop.ethnicity_concept_id,
        location_id => omop.location_id,
        provider_id => omop.provider_id,
        care_site_id => omop.care_site_id)
    join(
        gender_concept => concept(),
        gender_concept_id == gender_concept.concept_id,
        optional = true)
    left_join(
        death_concept => concept(),
        death_concept_id == death_concept.concept_id,
        optional = true)
    left_join(
        race_concept => concept(),
        race_concept_id == race_concept.concept_id,
        optional = true)
    left_join(
        ethnicity_concept => concept(),
        ethnicity_concept_id == ethnicity_concept.concept_id,
        optional = true)
    left_join(
        location => location(),
        location_id == location.location_id,
        optional = true)
    left_join(
        provider => provider(),
        provider_id == provider.provider_id,
        optional = true)
    left_join(
        care_site => care_site(),
        care_site_id == care_site.care_site_id,
        optional = true)
end
end

"""
    main()
hello
"""
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
