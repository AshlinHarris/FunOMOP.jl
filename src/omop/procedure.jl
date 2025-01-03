@funsql begin
    """
        funsql_procedure()

        WRITE A DOCSTRING
    """
    procedure() = begin
        from(procedure_occurrence)
        define(is_preepic => procedure_occurrence_id > 1500000000)
        left_join(
            procedure_source_concept => from(concept),
            procedure_source_concept_id == procedure_source_concept.concept_id,
            optional = true)
        as(omop)
        define(
            # event columns
            domain_id => "Procedure",
            occurrence_id => omop.procedure_occurrence_id,
            person_id => omop.person_id,
            concept_id => omop.procedure_concept_id,
            datetime => coalesce(omop.procedure_datetime,
                date_to_datetime(omop.procedure_date)),
            datetime_end => missing,
            type_concept_id => omop.procedure_type_concept_id,
            provider_id => omop.provider_id,
            visit_occurrence_id => omop.visit_occurrence_id,
            # domain specific columns
            omop.modifier_concept_id,
            omop.quantity)
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
            modifier_concept => concept(),
            modifier_concept_id == modifier_concept.concept_id,
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

    procedure(match...) =
        procedure().filter(concept_matches($match))

end
