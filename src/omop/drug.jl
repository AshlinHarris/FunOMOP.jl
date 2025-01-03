@funsql begin
    """
        funsql_drug()
    """
    drug() = begin
        from(drug_exposure)
        define(is_preepic => drug_exposure_id > 1500000000)
        as(omop)
        define(
            # event columns
            domain_id => "Drug",
            occurrence_id => omop.drug_exposure_id,
            person_id => omop.person_id,
            concept_id => omop.drug_concept_id,
            datetime => coalesce(omop.drug_exposure_start_datetime,
                                 timestamp(omop.drug_exposure_start_date)),
            datetime_end => coalesce(omop.drug_exposure_end_datetime,
                                     timestamp(omop.drug_exposure_end_date)),
            type_concept_id => omop.drug_type_concept_id,
            provider_id => omop.provider_id,
            visit_occurrence_id => omop.visit_occurrence_id,
            # domain specific columns
            omop.verbatim_end_date,
            omop.stop_reason,
            omop.refills,
            omop.quantity,
            omop.days_supply,
            omop.sig,
            omop.route_concept_id,
            omop.lot_number)
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
            route_concept => concept(),
            route_concept_id == route_concept.concept_id,
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

    drug(match...) =
        drug().filter(concept_matches($match))
end
