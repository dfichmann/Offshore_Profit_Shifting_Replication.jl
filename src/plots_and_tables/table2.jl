"""
This function replicates table 2. The Table is saved in the folder "ReplicationFiles/tables" as a markdown file.
    ```julia
    table2()
    
    No arguments are needed for this function
    """

function table2()
    usdia_inc = DataFrame(XLSX.readtable("ReplicationFiles/data/usdiainc_country.xlsx", "Sheet0"))

    usdia_inc.Country = strip.(usdia_inc.Country)

    ctys = ["Netherlands", "Bermuda", "Ireland", "Luxembourg", "United Kingdom Islands, Caribbean[2]", "Switzerland", "Singapore","Japan","Germany","United Kingdom","France","China","Italy","Canada"]

    usdia_inc = filter(row -> row.Country ∈ ctys, usdia_inc)
    usdia_inc = usdia_inc[:, ["Country","2016"]]

    agg_data = CSV.read("ReplicationFiles/data/aggregate.csv", DataFrame)
    iaf16 = agg_data[!, "income_adj_factor"][agg_data[!, "year"] .== 2016]

    cty_adj = DataFrame(XLSX.readtable("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetCountry2016.xlsx", "ADJCTRYSCALE"))


    # country names as a vector
    country_names = cty_adj.CountryName

    # Replace the names
    country_names = replace(country_names, "UK Islands - Caribbean" => "United Kingdom Islands, Caribbean[2]")
    country_names = replace(country_names, "UK" => "United Kingdom")

    # Update the DataFrame
    cty_adj.CountryName = country_names

    temp = innerjoin(cty_adj, usdia_inc, on = :CountryName => :Country, makeunique = true)

    temp.total_adjustment_earn = temp.adjwt3s .* iaf16

    total_adj_earn = sum(cty_adj[!, "adjwt3s"]) * iaf16

    temp[!, "share adj earn"] = temp[!, "total_adjustment_earn"] ./ total_adj_earn .* 100
    temp[!, "share income"] = ((temp[!, "adjwt3s"] .- temp[!, "nips"]) ./ temp[!, "2016"]) .* 100 .* 1000

    # Select the relevant columns
    t2 = temp[:, ["CountryName", "share adj earn", "share income"]]

    # Open the file in write mode
    file = open("ReplicationFiles/tables/Table2.md", "w")

    # Write the table header to the file
    write(file, "| CountryName | share adj earn | share income |\n")
    write(file, "| --- | --- | --- |\n")

    # Write the table rows to the file
    for i in 1:size(t2, 1)
        CountryName = t2[i, :CountryName]
        share_adj_earn = round(t2[i, :"share adj earn"], digits=3)
        share_income = round(t2[i, :"share income"], digits=3)
        
        write(file, "| $CountryName | $share_adj_earn | $share_income |\n")
    end

    # Close the file
    close(file)

end
