"""
    makedataforplot2()

This function reads and processes data for creating plot 2. It reads data from the "OutputAggStdError.xlsx" file, performs necessary data manipulations and calculations. 

Specifically, the function does the following:
1. Reads the "OutputAggStdError.xlsx" file.
2. Creates a DataFrame with all combinations of unique Panels and Years.
3. Interpolates missing values within the DataFrame.
4. Joins the DataFrame with the `public` DataFrame.
5. Computes statistics across panels for each Year.

# Usage
```julia
panel_stats = makedataforplot2()

Returns

panel_stats: A DataFrame containing computed statistics for each Panel.
This function takes no arguments.
    
"""
function makedataforplot2()
    boot = DataFrame(XLSX.readtable("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAggStdError.xlsx", "STACKAGGADJ"))
    println(boot[1, :])
    
    # Get unique values from the columns
    unique_Panel = unique(boot[!, :Panel])
    unique_Year = collect(1982:2016)
    
    # Create the dataset with all combinations
    fullcombdf = DataFrame(Year = repeat(unique_Year, outer = length(unique_Panel)),
                    Panel = repeat(unique_Panel, inner = length(unique_Year)))
    
    # Sort the dataset by Year and IEDindPar
    sort!(fullcombdf, [:Year, :Panel])
    
    # Join the full combinations dataset with adj_ind
    boot = leftjoin(fullcombdf, boot, on = [:Year, :Panel])
       
    sort!(boot, [:Panel, :Year])
    
    boot = coalesce.(boot, missing)
    
    # Check the updated column type
    println(typeof(boot.Adjustment))
    # Interpolate missing values
    boot = Impute.interp(boot)
    println(boot)
    
    #compute statistics across panels for each Year
    merged_df = innerjoin(boot, public, on = (:Year => :year))
    
    merged_df.adjustment_deflated = merged_df.Adjustment ./ merged_df.gva_deflator.* -1
    
    # Display the updated merged data frame
    print(merged_df)
    
    # Group the merged data frame by Panel
    grouped_df = groupby(merged_df, :Year)
    
    # Calculate the statistics for each Panel
    panel_stats = combine(grouped_df) do df
        DataFrame(
            mean__adjustment = mean(df.adjustment_deflated),
            std__adjustment = std(df.adjustment_deflated),
            q25__adjustment = quantile(df.adjustment_deflated, 0.25),
            q75__adjustment = quantile(df.adjustment_deflated, 0.75)
        )
    end
    return panel_stats
end