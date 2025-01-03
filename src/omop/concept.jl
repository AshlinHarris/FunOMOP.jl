@funsql begin
    """
        funsql_concept()

        WRITE A DOCSTRING
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

    concept(concept_id::Integer...) =
        concept().filter(in(concept_id, $concept_id...))

    concept(p) = concept().filter($p)
end

