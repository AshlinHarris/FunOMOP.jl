FunOMOP_SQL_dialect = get(ENV, "FunOMOP_SQL_dialect", :duckdb)

#TODO: automatically read this from the database or the FunSQL command?
if !@isdefined(FunOMOP_SQL_dialect)
    @warn("`FunOMOP_SQL_dialect` is not set. Options are :spark or :duckdb (default)")
    const global FunOMOP_SQL_dialect = :duckdb
end

macro export_funsql_fun_or_agg(exs...)
    block = Expr(:block)
    for ex in exs
        is_agg = false
        if ex isa Union{Symbol, String}
            def = name = ex
        elseif FunSQL.@dissect(ex, Expr(:vect, def::Union{Symbol, String}))
            is_agg = true
            name = def
        elseif FunSQL.@dissect(ex, Expr(:(=), def::Union{Symbol, String}, name::Union{Symbol, String}))
        elseif FunSQL.@dissect(ex, Expr(:(=), Expr(:vect, def::Union{Symbol, String}), name::Union{Symbol, String}))
            is_agg = true
        else
            error("invalid @export_funsql_fun_or_agg notation")
        end
        fun = is_agg ? FunSQL.AggClosure : FunSQL.FunClosure
        name = QuoteNode(Symbol(name))
        push!(block.args, Expr(:export, esc(Symbol("funsql_$def"))))
        push!(block.args, :(const $(esc(Symbol("funsql_$def"))) = $fun($name)))
    end
    return block
end

@warn(":FunOMOP_SQL_dialect", FunOMOP_SQL_dialect)
if FunOMOP_SQL_dialect == :duckdb

    #TODO: why doesn't this work inside an if block?
    #using FunSQL: @dissect

    @export_funsql_fun_or_agg(
        format,
        strptime,
    )

    export get_test_db
    """
        get_test_db()
    Build a test database in memory and return the connection
    """
    function get_test_db()

        # New database in memory
        DATABASE = ":memory:"
        conn = DBInterface.connect(DuckDB.DB, DATABASE)

        # Parse the ddl into individual commands
        pattern = r"CREATE TABLE @cdmDatabaseSchema.([\w_]*) \(([\s\S]*?)[\n\)];"
        input_file_contents = read(joinpath(artifact"omop_ddl", "OMOPCDM_duckdb_5.4_ddl.sql"), String)
        for match in eachmatch(pattern, input_file_contents)

            # Create the table
            command = replace(match.match,
                "@cdmDatabaseSchema." => "",
                "integer" => "BIGINT",
            )
            DBInterface.execute(conn, command)

            # Write the data
            table_name = match.captures |> first |> String |> uppercase
            file_name = joinpath(artifact"synthea_omop_test", "Synthea27Nj_5.4", "$table_name.csv")
            DBInterface.execute(conn, "COPY $table_name FROM '$file_name';")
        end

        # Update the catalog for any new tables
        catalog = FunSQL.reflect(conn, dialect=:duckdb)
        updated_conn = FunSQL.DB(conn, catalog = catalog)

        return updated_conn

    end

    @funsql begin
        datetime_from_date_ints(year, month, day) =
        strptime(format(
            "{:04d}-{:02d}-{:02d}",
            $year, $month, $day,),
            "%Y-%m-%d")
    end

elseif FunOMOP_SQL_dialect == :spark

    @funsql begin
        datetime_from_date_ints(year, month, day) =
            timestamp(make_date($year, $month, $day,))
    end

end

#TODO: implement this function
@funsql begin
    date_to_datetime(date) = $date
end
