"""
This function replicates table 1. The Table is saved in the folder "ReplicationFiles/tables" as a markdown file.

    # Usage
```julia
table1()

No arguments are needed for this function
"""
function table1()
    # The list of countries to filter the final table
    ctys = ["All Countries Total", "Canada", "Ireland", "Luxembourg", "Netherlands", "Switzerland",
            "Barbados", "Bermuda", "United Kingdom Islands, Caribbean", "Hong Kong", "Singapore"]

    # Read the data
    emp = CSV.read("ReplicationFiles/data/usdia-employees-2012.csv", DataFrame)
    ast = CSV.read("ReplicationFiles/data/usdia-total-assets-2012.csv", DataFrame)
    comp = CSV.read("ReplicationFiles/data/usdia-comp-2012.csv", DataFrame)
    ppe = CSV.read("ReplicationFiles/data/usdia-ppe-2012.csv", DataFrame)

    # Merge the dataframes
    t1 = innerjoin(emp, ast, on = :country, makeunique = true)
    t1 = innerjoin(t1, comp, on = :country, makeunique = true)
    t1 = innerjoin(t1, ppe, on = :country, makeunique = true)

    t1.country = strip.(t1.country)

    # Filter by country
    t1 = filter(row -> row.country ∈ ctys, t1)
    rename!(t1, ["Country", "emp", "assets", "comp", "ppe"])

    # replace missing values with "0"
    t1[!, :emp] = coalesce.(t1[!, :emp], "0")
    t1[!, :assets] = coalesce.(t1[!, :assets], "0")
    t1[!, :comp] = coalesce.(t1[!, :comp], "0")
    t1[!, :ppe] = coalesce.(t1[!, :ppe], "0")
    # convert the column to Float64
    t1[!, :emp] = Base.parse.(Float64, t1[!, :emp])
    t1[!, :assets] = Base.parse.(Float64, t1[!, :assets])
    #t1[!, :comp] = Base.parse.(Float64, t1[!, :comp])
    t1[!, :ppe] = Base.parse.(Float64, t1[!, :ppe])


    # Add new columns
    t1.Employment = (t1.assets ./ t1.emp) ./ 1000
    t1.Compensation = t1.assets ./ t1.comp
    t1.PPE = t1.assets ./ t1.ppe

    # Select the relevant columns
    t1 = t1[:, ["Country", "PPE", "Compensation", "Employment"]]

    # Rename some country names
    t1.Country = replace(t1.Country, "All Countries Total" => "World")
    t1.Country = replace(t1.Country, "United Kingdom Islands, Caribbean" => "U.K.I., Caribbean")
    t1

    # Open the file in write mode
    file = open("ReplicationFiles/tables/Table1.md", "w")

    # Write the table header to the file
    write(file, "| Country | PPE | Compensation | Employment (mil. USD) |\n")
    write(file, "| --- | --- | --- | --- |\n")

    # Write the table rows to the file
    for i in 1:size(t1, 1)
        country = t1[i, :Country]
        ppe = round(t1[i, :PPE], digits=1)
        compensation = round(t1[i, :Compensation], digits=1)
        employment = round(t1[i, :Employment], digits=1)
        
        write(file, "| $country | $ppe | $compensation | $employment |\n")
    end

    # Close the file
    close(file)

end
