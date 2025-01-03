function funsql_isa(concept_id, concept_set)
    concept_set = convert(FunSQL.SQLNode, concept_set)
    concept_set = @funsql($concept_set.concept_descendants())
    return @funsql $concept_id in $concept_set.select(concept_id)
end

funsql_isa(concept_id, concept_set::AbstractVector) =
    @funsql isa($concept_id, append(args=$concept_set))

function funsql_isa_icd(concept_id, concept_set; with_icd9gem=false)
    concept_set = convert(FunSQL.SQLNode, concept_set)
    concept_set = @funsql($concept_set.concept_icd_descendants())
    if with_icd9gem
        concept_set = @funsql begin
            append(
                $concept_set,
                $concept_set.concept_relatives("ICD10CM - ICD9CM rev gem"))
       end
    end
    return @funsql $concept_id in $concept_set.select(concept_id)
end

funsql_isa_icd(concept_id, concept_set::AbstractVector; with_icd9gem=false) =
   @funsql isa_icd($concept_id, append(args=$concept_set); with_icd9gem=$with_icd9gem)

@funsql isa(concept_set; with_icd9gem=false) = begin
     isa(concept_id, $concept_set) ||
     if_defined_scalar(icd_concept,
        isa_icd(icd_concept.concept_id, $concept_set;
                with_icd9gem=$with_icd9gem),
        false)
end

# TODO: remove backward compatibility
funsql_concept_matches(cs; on = :concept_id) =
    funsql_isa(on, cs)

funsql_concept_matches(cs::Tuple{Any}; on = :concept_id) =
    funsql_concept_matches(cs[1], on = on)

funsql_concept_matches(cs::Vector; on = :concept_id) =
    funsql_concept_matches(FunSQL.Append(args = FunSQL.SQLNode[cs...]), on = on)

