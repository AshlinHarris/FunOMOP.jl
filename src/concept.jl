@funsql begin
    """
        funsql_concept()
    """
    concept() = begin
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

