using XLSX, Impute, DataFramesMeta, DataFrames, CSV

function logg(x::Vector)
    log.(x[2:end] ./ x[1:end-1])
end

function rename_and_process!(df, file)
    rename!(df, ["year", "indgroup", "adjcomps", "adjsales", "adjrdstks", "adjppes", "adjwt3s"])
    unique_indgroup = unique(df[!, :indgroup])
    unique_year = collect(1982:2016)
    # Create the dataset with all combinations
    fullcombdf = DataFrame(year = repeat(unique_year, outer = length(unique_indgroup)),
                           indgroup = repeat(unique_indgroup, inner = length(unique_year)))
    # Sort the dataset by Year and IEDindPar
    sort!(fullcombdf, [:indgroup, :year])
    # Convert missing values to missing type
    df = coalesce.(df, missing)
    df = leftjoin(fullcombdf, df, on = [:year, :indgroup])
    sort!(df, [:indgroup, :year])
    # Interpolate missing values in DataFrame
    df = Impute.interp(df)
    # Select desired columns
    df = df[:, [:year, :indgroup, :adjwt3s]]
    # Unstack DataFrame
    df = unstack(df, :indgroup, :adjwt3s)
    # Rename columns based on the filename
    if occursin("ITP", file)
        rename!(df, Dict(Symbol("1") => :itp, Symbol("0") => :nitp))
    elseif occursin("ITU", file)
        rename!(df, Dict(Symbol("1") => :itu, Symbol("0") => :nitu))
    elseif occursin("RD", file)
        rename!(df, Dict(Symbol("1") => :rd, Symbol("0") => :nrd))
    end
    return df
end

function process_files(filenames)
    file_dfs = Dict()
    for (file, sheet) in filenames
        df = DataFrame(XLSX.readtable(file, sheet))
        df = rename_and_process!(df, file)
        file_dfs[split(file, "/")[end]] = df  # Use the last part of the file path as the key
    end
    return file_dfs
end

function makedataforplot8()
    # Call the function with the list of files and their corresponding sheet names
    files_and_sheets = [("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetITP.xlsx", "ADJITPSCALE"),
                        ("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetITU.xlsx", "ADJITUSCALE"),
                        ("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetRD.xlsx", "ADJRDSCALE")]

    dfs = process_files(files_and_sheets)

    inds = CSV.read("ReplicationFiles/3-intermediate-files/industry.csv", DataFrame, header=[1,2])

    rename!(inds, :Column1_Column1 => :year)

    # assuming dfs is a dictionary containing our dataframes and inds
    ITP = dfs["OutputAdjNetITP.xlsx"]
    ITU = dfs["OutputAdjNetITU.xlsx"]
    RD = dfs["OutputAdjNetRD.xlsx"]

    inds = leftjoin(inds, ITP, on = :year)
    inds = leftjoin(inds, ITU, on = :year)
    inds = leftjoin(inds, RD, on = :year)

    sort!(inds, [:year])

    indgroups = ["rd", "nrd", "itu", "nitu", "itp", "nitp"]

    for indgroup in indgroups
        inds[!, Symbol(indgroup * "_adj_nva_gr")] = [missing; logg(inds[!, Symbol(indgroup * "_nva")] .+ (-1) .* inds[!, Symbol(indgroup)])]
        inds[!, Symbol(indgroup * "_adj_rva_gr")] = inds[!, Symbol(indgroup * "_adj_nva_gr")] .- inds[!, Symbol(indgroup * "_p_gr")]
        inds[!, Symbol(indgroup * "_prod_adj_gr")] = inds[!, Symbol(indgroup * "_adj_rva_gr")] .- inds[!, Symbol(indgroup * "_emp_gr")]

        inds[!, Symbol(indgroup * "_prod_adj_cgr")] = cumsum(coalesce.(inds[!, Symbol(indgroup * "_prod_adj_gr")], 0.0))
        inds[!, Symbol(indgroup * "_prod_adj_cgr_dif")] = inds[!, Symbol(indgroup * "_prod_adj_cgr")] .- inds[!, Symbol(indgroup * "_prod_unadj_cgr")]

        inds[inds[!, :year] .== 1982, Symbol(indgroup * "_prod_adj_cgr")] .= 0
    end

    return inds

end

