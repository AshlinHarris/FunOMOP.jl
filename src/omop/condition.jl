@funsql begin
    """
        funsql_condition()
    """
    condition() = begin
        from(condition_occurrence)
        left_join(
            condition_source_concept => from(concept),
            condition_source_concept_id == condition_source_concept.concept_id,
            optional = true)
        #TODO:
        define(is_preepic => condition_occurrence_id > 1000000000)
        as(omop)
        define(
            # event columns
            domain_id => "Condition",
            occurrence_id => omop.condition_occurrence_id,
            person_id => omop.person_id,
            concept_id => omop.condition_concept_id,
            datetime => coalesce(omop.condition_start_datetime,
                date_to_datetime(omop.condition_start_date)),
            datetime_end => coalesce(omop.condition_end_datetime,
                date_to_datetime(omop.condition_end_date)),
            type_concept_id => omop.condition_type_concept_id,
            provider_id => omop.provider_id,
            visit_occurrence_id => omop.visit_occurrence_id,
            # domain specific columns
            status_concept_id => omop.condition_status_concept_id,
            omop.stop_reason)
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
            status_concept => concept(),
            status_concept_id == status_concept.concept_id,
            optional = true)
        left_join(
            provider => provider(),
            provider_id == provider.provider_id,
            optional = true)
        left_join(
            visit => visit(),
            visit_occurrence_id == visit.occurrence_id,
            optional = true)
        left_join(
            icd_concept => concept().filter(in(vocabulary_id, "ICD9CM", "ICD10CM")),
            icd_concept.concept_id == omop.condition_source_concept_id,
            optional = true)
    end

    condition(cs; with_icd9gem=false) =
    condition().filter(isa($cs; with_icd9gem=$with_icd9gem))

end

