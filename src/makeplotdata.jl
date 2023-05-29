import Pkg; Pkg.add("Plots")
import Pkg; Pkg.add("Seaborn")
import Pkg; Pkg.add("Statistics")
import Pkg; Pkg.add("CSV")
import Pkg; Pkg.add("DataFrames")
import Pkg; Pkg.add("XLSX")
import Pkg; Pkg.add("Impute")
import Pkg; Pkg.add("Missings")
import Pkg; Pkg.add("Interpolations")

using DataFrames, Plots, Seaborn, Statistics, CSV, DataFrames, XLSX, Missings, Interpolations
using Impute

function makeplotdata()

    public = CSV.read("ReplicationFiles/3-intermediate-files/aggregate.csv", DataFrame)
    println(public, 1)
    
    # Read Excel file
    adj_agg = DataFrame(XLSX.readtable("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNet.xlsx", "ADJNETSCALE"))
    
    println(adj_agg[1, :])
    
    # make "Year" the index column for adj_agg
    adj_agg.rowindex = adj_agg[:, :Year]
    adj_agg = adj_agg[(adj_agg.Year .>= 1982) .& (adj_agg.Year .<= 2017), :]
    
    full_years = DataFrame(Year = collect(1982:2016))
    
    adj_agg = leftjoin(full_years, adj_agg, on = :Year)
    adj_agg = sort(adj_agg, :Year)
    
    # Convert missing values to missing type
    adj_agg = coalesce.(adj_agg, missing)
    names(adj_agg)
    
    # Interpolate missing values in adj_agg DataFrame
    adj_agg = Impute.interp(adj_agg)
    
    # Access the interpolated DataFrame
    println(adj_agg)
    
    adj_agg[!, :adjearn3s_cca] = adj_agg[!, :adjwt3s] .* public[!, :income_adj_factor]
    adj_agg[!, :adjearncomps_cca] = adj_agg[!, :adjcomps] .* public[!, :income_adj_factor]
    adj_agg[!, :adjearnppes_cca] = adj_agg[!, :adjppes] .* public[!, :income_adj_factor]
    adj_agg[!, :adjearnrdstks_cca] = adj_agg[!, :adjrdstks] .* public[!, :income_adj_factor]
    println(adj_agg[1, :])
    
    adj_ind = DataFrame(XLSX.readtable("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetIndustry.xlsx", "ADJINDSCALE"))
    
    # Get unique values from the columns
    unique_IEDindPar = unique(adj_ind[!, :IEDindPar])
    unique_Year = collect(1982:2016)
    
    # Create the dataset with all combinations
    fullcombdf = DataFrame(Year = repeat(unique_Year, outer = length(unique_IEDindPar)),
                            IEDindPar = repeat(unique_IEDindPar, inner = length(unique_Year)))
    
    # Sort the dataset by Year and IEDindPar
    sort!(fullcombdf, [:Year, :IEDindPar])
    
    # Join the full combinations dataset with adj_ind
    adj_ind = leftjoin(fullcombdf, adj_ind, on = [:Year, :IEDindPar])
    # Drop observations where IEDindPar is equal to 3230 or 5415
    adj_ind = filter(row -> !(row.IEDindPar in (3230, 5415)), adj_ind)
    
    sort!(adj_ind, [:IEDindPar, :Year])
    
    # Convert missing values to missing type
    adj_ind = coalesce.(adj_ind, missing)
    names(adj_ind)
    
    # Interpolate missing values in adj_agg DataFrame
    adj_ind = Impute.interp(adj_ind)
    
    
    adj_tax = DataFrame(XLSX.readtable("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetHaven.xlsx", "ADJHVNSCALE"))
    #Get unique values from the columns
    unique_HVN = unique(adj_tax[!, :Haven])
    unique_Year = collect(1982:2016)
    
    # Create the dataset with all combinations
    fullcombdf = DataFrame(Year = repeat(unique_Year, outer = length(unique_HVN)),
            Haven = repeat(unique_HVN, inner = length(unique_Year)))
    
    # Sort the dataset by Year and Haven
    sort!(fullcombdf, [:Year, :Haven])
    
    # Join the full combinations dataset with adj_tax
    adj_tax = leftjoin(fullcombdf, adj_tax, on = [:Year, :Haven])
    # Drop observations where Haven is equal to 3230 or 5415
    adj_tax = filter(row -> !(row.Haven in (3230, 5415)), adj_tax)
    
    sort!(adj_tax, [:Haven, :Year])
    
    # Convert missing values to missing type
    adj_tax = coalesce.(adj_tax, missing)
    names(adj_tax)
    
    # Interpolate missing values in adj_agg DataFrame
    adj_tax = Impute.interp(adj_tax)

    #return all the dataframes needed for the plots:
    return public, adj_agg, adj_ind, adj_tax

end
    
