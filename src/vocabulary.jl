# TODO: remove backward compatibility
funsql_concept_matches(cs; on = :concept_id) =
    funsql_isa(on, cs)

funsql_concept_matches(cs::Tuple{Any}; on = :concept_id) =
    funsql_concept_matches(cs[1], on = on)

funsql_concept_matches(cs::Vector; on = :concept_id) =
    funsql_concept_matches(FunSQL.Append(args = FunSQL.SQLNode[cs...]), on = on)
