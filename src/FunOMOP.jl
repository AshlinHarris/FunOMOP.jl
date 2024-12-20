module FunOMOP

export funsql_person
export funsql_care_site
export funsql_location
export funsql_provider
export funsql_concept
export execute_query

using Artifacts
using CSV
using DataFrames
using DuckDB
using FunSQL
using HTTP

export func

"""
    execute_query(q)
Run the FunSQL query against a sample data set
"""
function execute_query(q)
    DATABASE = joinpath(artifact"synthea_omop_test", "synthea_omop_test.db",)
    conn = DBInterface.connect(FunSQL.DB{DuckDB.DB}, DATABASE)
    DBInterface.execute(conn, q) |> DataFrame
end

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
    funsql_person()
"""
function funsql_person()
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
                          #=timestamp(
                          make_date(omop.year_of_birth,
                          coalesce(omop.month_of_birth, 1),
                          coalesce(omop.day_of_birth, 1)))=#),
               death_datetime => coalesce(omop.death.death_datetime,
                          #=timestamp(omop.death.death_date)=#),
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
    funsql_care_site()
"""
function funsql_care_site()
    @funsql begin

        from(care_site)
        define(is_preepic => care_site_id > 1000000000)
        as(omop)
        define(
               care_site_id => omop.care_site_id,
               care_site_name => omop.care_site_name,
               concept_id => coalesce(omop.place_of_service_concept_id, 0),
               location_id => omop.location_id)
        left_join(
              concept => concept(),
              concept_id == concept.concept_id,
              optional = true)
        left_join(
             location => location(),
             location_id == location.location_id,
             optional = true)
    end
end

"""
    funsql_concept()
"""
function funsql_concept()
    @funsql begin
        from(concept)
        as(omop)
        define(
               omop.concept_id,
               omop.concept_name,
               omop.domain_id,
               omop.vocabulary_id,
               omop.concept_class_id,
               omop.standard_concept,
               omop.concept_code,
               omop.invalid_reason)
    end
end

"""
    funsql_provider()
"""
function funsql_provider()
    @funsql begin
        from(provider)
        define(is_preepic => provider_id > 1000000000)
        as(omop)
        define(
               provider_id => omop.provider_id,
               provider_name => omop.provider_name,
               npi => omop.npi,
               dea => omop.dea,
               concept_id => coalesce(omop.specialty_concept_id, 0),
               care_site_id => omop.care_site_id,
               year_of_birth => omop.year_of_birth,
               gender_concept_id => coalesce(omop.gender_concept_id, 0))
        left_join(
              concept => concept(),
              concept_id == concept.concept_id,
              optional = true)
        left_join(
              care_site => care_site(),
              care_site_id == care_site.care_site_id,
              optional = true)
        left_join(
              gender_concept => concept(),
              concept_id == gender_concept.concept_id,
              optional = true)
    end
end

"""
    funsql_location()
"""
function funsql_location()
    @funsql begin

        from(location)
        as(omop)
        define(
               omop.location_id,
               omop.address_1,
               omop.address_2,
               omop.city,
               omop.state,
               omop.zip,
               omop.county,
               omop.country_concept_id,
               omop.latitude,
              omop.longitude)
        left_join(
              country_concept => concept(),
              country_concept_id == country_concept.concept_id,
              optional = true)
    end
end

end # module FunOMOP
