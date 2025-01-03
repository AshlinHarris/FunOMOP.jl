@funsql begin
    """
        funsql_measurement()
    """
    measurement() = begin
        from(measurement)
        define(is_preepic => measurement_id > 1500000000)
        as(omop)
        define(
            # event columns
            domain_id => "Measurement",
            occurrence_id => omop.measurement_id,
            person_id => omop.person_id,
            concept_id => omop.measurement_concept_id,
            datetime => coalesce(omop.measurement_datetime,
                date_to_datetime(omop.measurement_date)),
            datetime_end => missing,
            type_concept_id => omop.measurement_type_concept_id,
            provider_id => omop.provider_id,
            visit_occurrence_id => omop.visit_occurrence_id,
            # domain specific columns
            omop.operator_concept_id,
            omop.value_as_number,
            omop.value_as_concept_id,
            omop.unit_concept_id,
            omop.range_low,
            omop.range_high)
        join(
            person => person(),
            person_id == person.person_id,
            optional = true)
        join(
            concept => concept(),
            concept_id == concept.concept_id,
            optional = true)
        left_join(
            type_concept => concept(),
            type_concept_id == type_concept.concept_id,
            optional = true)
        left_join(
            operator_concept => concept(),
            operator_concept_id == operator_concept.concept_id,
            optional = true)
        left_join(
            value_as_concept => concept(),
            value_as_concept_id == value_as_concept.concept_id,
            optional = true)
        left_join(
            unit_concept => concept(),
            unit_concept_id == unit_concept.concept_id,
            optional = true)
        left_join(
            provider => provider(),
            provider_id == provider.provider_id,
            optional = true)
        left_join(
            visit => visit(),
            visit_occurrence_id == visit.occurrence_id,
            optional = true)
    end

    measurement(match...) =
    measurement().filter(concept_matches($match))
end
