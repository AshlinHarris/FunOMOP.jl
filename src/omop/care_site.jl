@funsql begin
    """
        funsql_care_site()

        WRITE A DOCSTRING
    """
    care_site() = begin
        from(care_site)
        #TODO: Tufts-specific logic
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

