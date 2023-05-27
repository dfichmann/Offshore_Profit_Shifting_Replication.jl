using Plots
using Statistics


savefolder = "ReplicationFiles/4-figures"

function plots1()
# Set the GR backend
gr()

# Creating a layout with 1 row and 2 columns
layout = @layout([a b])

# Creating a new plot with the specified layout
p = Plots.plot(layout=layout, size=(1000, 400), margins = 10Plots.mm)

# Plotting the first figure in the left subplot
Plots.plot!(p[1], public[!, :year], 100 * public[!, :usdiaincn] ./ public[!, :gvabusn], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(p[1], public[!, :year], -100 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gvabusn], color=:blue, label="Weighted", linewidth=3)
xlims!(p[1], 1980, 2018)
ylims!(p[1], 0, 4.0)
annotate!(p[1], 2000, 3, "USDIA Income", fontfamily="Arial", annotationfontsize=8)
annotate!(p[1], 2008, 1.9, "Weighted\nAdjustment", fontfamily="Arial", annotationfontsize=8)
xlabel!(p[1], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[1], "Share of business-sector value added (percent)", fontfamily="Arial", fontsize=12)
title!(p[1], "Replicated Figure 1A", fontfamily="Arial", fontsize=14, fontweight="bold")

# Plotting the second figure in the right subplot
Plots.plot!(p[2], public[!, :year], public[!, :usdiaincn] ./ public[!, :gva_deflator], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(p[2], public[!, :year], -1 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gva_deflator], color=:blue, label="Weighted", linewidth=3)
xlims!(p[2], 1980, 2018)
annotate!(p[2], 2001, 375, "USDIA Income", fontfamily="Arial", annotationfontsize=8)
annotate!(p[2], 2010, 230, "Weighted\nAdjustment", fontfamily="Arial", annotationfontsize=8)
xlabel!(p[2], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[2], "Billions of dollars", fontfamily="Arial", fontsize=12)
title!(p[2], "Replicated Figure 1B", fontfamily="Arial", fontsize=14, fontweight="bold")

# Saving the panel figure with higher resolution
Plots.savefig(p, "ReplicationFiles/4-figures/Figure1.pdf")
end
plots1()




























function plots1()
# Set the GR backend or use pyplot() for the PyPlot backend if available
gr()

# Plotting the data with customized aesthetics
Plots.plot(public[!, :year], 100 * public[!, :usdiaincn] ./ public[!, :gvabusn], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(public[!, :year], -100 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gvabusn], color=:blue, label="Weighted", linewidth=3)

# Setting x-axis and y-axis limits
xlims!(1980, 2018)
ylims!(0, 4.0)

# Adding text annotations
annotate!(2002.5, 3.75, "USDIA Income", fontfamily="Arial", fontsize=12)
annotate!(2008, 1.9, "Weighted\nAdjustment", fontfamily="Arial", fontsize=12)

# Setting axis labels and title
xlabel!("Year", fontfamily="Arial", fontsize=12)
ylabel!("Share of business-sector value added (percent)", fontfamily="Arial", fontsize=12)
title!("Replicated Figure 1A", fontfamily="Arial", fontsize=14, fontweight="bold")

# Saving the figure with higher resolution
Plots.savefig("ReplicationFiles/4-figures/agg_adj_share.pdf")
#################################
gr()

# Plotting the data with customized aesthetics
Plots.plot(public[!, :year],public[!, :usdiaincn] ./ public[!, :gva_deflator], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(public[!, :year], -1 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gva_deflator], color=:blue, label="Weighted", linewidth=3)

# Setting x-axis and y-axis limits
xlims!(1980, 2018)

# Adding text annotations
annotate!(2001, 375, "USDIA Income", fontfamily="Arial", fontsize=10)
annotate!(2010, 230, "Weighted\nAdjustment", fontfamily="Arial", fontsize=10)

# Setting axis labels and title
xlabel!("Year", fontfamily="Arial", fontsize=12)
ylabel!("Billions of dollars", fontfamily="Arial", fontsize=12)
title!("Replicated Figure 1B", fontfamily="Arial", fontsize=14, fontweight="bold")

# Saving the figure with higher resolution
Plots.savefig("ReplicationFiles/4-figures/agg_adj_l.pdf")
end

plots1()

###################################----------------------------
using Impute 
function plots2()
gr()
# Plotting the data with customized aesthetics
Plots.plot(public[!, :year],public[!, :usdiaincn] ./ public[!, :gva_deflator], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(public[!, :year], -1 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gva_deflator], color=:blue, label="Weighted", linewidth=3)
Plots.plot!(public[!, :year], -1 * adj_agg[!, :adjearncomps_cca] ./ public[!, :gva_deflator], color=:red, linestyle=:dash, label="Compensation", linewidth=3)
Plots.plot!(public[!, :year], -1 * adj_agg[!, :adjearnppes_cca] ./ public[!, :gva_deflator], color=:black, linestyle=:dashdotdot, label="PPE", linewidth=3)
Plots.plot!(public[!, :year], -1 * adj_agg[!, :adjearnrdstks_cca] ./ public[!, :gva_deflator], color=:green, linestyle=:dot, label="R&D", linewidth=3)

# Setting x-axis and y-axis limits
xlims!(1980, 2018)

# Adding text annotations
annotate!(2001, 375, "USDIA Income", fontfamily="Arial", fontsize=10)

# Setting axis labels and title
xlabel!("Year", fontfamily="Arial", fontsize=12)
ylabel!("Billions of dollars", fontfamily="Arial", fontsize=12)
title!("Replicated Figure 2A", fontfamily="Arial", fontsize=14, fontweight="bold")

# Saving the figure with higher resolution
Plots.savefig("ReplicationFiles/4-figures/agg_adj_weights.pdf")

###################################

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

print(panel_stats)


gr()
# Plotting the data with customized aesthetics
Plots.plot(public.year, public.usdiaincn ./ public.gva_deflator,
    color = :black, label = "USDIA Income", legend = :topleft, linewidth = 3)

# Plotting boot data with +/- 2 standard deviations
Plots.plot!(panel_stats.Year, panel_stats.mean__adjustment .- panel_stats.std__adjustment .* 2,
    fillrange = panel_stats.mean__adjustment .+ panel_stats.std__adjustment .* 2,
    fillcolor = :lightblue, alpha = 0.3, linecolor = :white, label = "+/-2 s.d.") #remove line 

Plots.plot!(public.year, -1*adj_agg.adjearn3s_cca ./public.gva_deflator,
    color = :blue, label = "Weighted", linewidth = 3)

Plots.plot!(public.year, panel_stats.q25__adjustment, color= :black, linestyle = :dash, alpha = 0.3, label = "25/75 percentiles") #label "25/75 percentiles"
Plots.plot!(public.year, panel_stats.q75__adjustment, color= :black, linestyle = :dash, alpha = 0.3, label = :false)


# Setting x-axis and y-axis limits
xlims!(1980, 2018)

# Adding text annotations
annotate!(2001, 375, "USDIA Income", fontfamily="Arial", fontsize=10)

# Setting axis labels and title
xlabel!("Year", fontfamily="Arial", fontsize=12)
ylabel!("Billions of dollars (2009 base year)", fontfamily="Arial", fontsize=12)
title!("Replicated Figure 2A", fontfamily="Arial", fontsize=14, fontweight="bold")

# Saving the figure with higher resolution
Plots.savefig("ReplicationFiles/4-figures/robust.pdf")
end 

plots2()

###################################----------------------------
function plot3()
gr()
Plots.plot(public.year, public.poil, color= :black, linewidth=2.25, label = :none)
xlabel!("Year", fontfamily="Arial", fontsize=12)
ylabel!("dollars per barrel", fontfamily="Arial", fontsize=12)
xlims!(1980, 2018)
title!("Replicated Figure 3A", fontfamily="Arial", fontsize=14, fontweight="bold")

Plots.savefig("ReplicationFiles/4-figures/oil_prices.pdf")
#### 3B
gr()
Plots.plot(public.year, -100*adj_agg.adjearn3s_cca ./ public.gvabusn,
    color = :blue, label = "Weighted", legend = :topleft, linewidth = 3)
adjwt3s_3240 = adj_ind[adj_ind.IEDindPar .== 3240, "adjwt3s"]
# Calculate the numerator
numerator = (adj_agg.adjearn3s_cca .* (-1) .- adjwt3s_3240 .* (-1) .* public.income_adj_factor)
# Calculate the denominator
denominator = public.gvabusn
# Calculate the final expression
expression = numerator ./ denominator .* 100
# Plotting the expression
Plots.plot!(public.year, expression,
    color = :red, linestyle = :dash)

# Setting x-axis and y-axis limits
xlims!(1980, 2018)

# Adding text annotations
annotate!(1995, 1.50, "Adjustment all industries", fontfamily="Arial", fontsize=10)
annotate!(2008, 0.5, "Adjustment ex. petroleum", fontfamily="Arial", fontsize=10)
# Setting axis labels and title
xlabel!("Year", fontfamily="Arial", fontsize=12)
ylabel!("share of business-sector value added (percent)", fontfamily="Arial", fontsize=10)
title!("Replicated Figure 3B", fontfamily="Arial", fontsize=14, fontweight="bold")

Plots.savefig("ReplicationFiles/4-figures/adjustments_nopetro.pdf")
end

plot3()

###################################-----5A-----------------------

Plots.plot(public.year, public.tradebal ./public.gdpn, color= :black, linewidth=2.25, label = "unadjusted")
Plots.plot!(public.year, (public.tradebal .- adj_agg.adjearn3s_cca) ./ (public.gdpn .- adj_agg.adjearn3s_cca), 
    color= :blue, linewidth=2.25, label = "adjusted", linestyle = :dash)
#insert black horizontal line at 0
Plots.plot!(public.year, zeros(length(public.year)), color= :black, linewidth=2, label = :none)
ylims!(-0.06, 0.01)
xlims!(1980, 2018)
xlabel!("Year", fontfamily="Arial", fontsize=12)
ylabel!("share of GDP", fontfamily="Arial", fontsize=12)
title!("Replicated Figure 5A", fontfamily="Arial", fontsize=14, fontweight="bold")

annotate!(1997, -0.05, "Unadjusted", fontfamily="Arial", fontsize=10)
annotate!(2006, -0.014, "Adjusted", fontfamily="Arial", fontsize=10)

Plots.savefig("ReplicationFiles/4-figures/trade_balance.pdf")

### 5B
Plots.plot(public.year, public.goodbal ./public.gdpn, color= :black, linewidth=2.25, label = "unadjusted goods")
Plots.plot!(public.year, public.servbal ./ public.gdpn, color = :black, linewidth=2.25, label = "adjusted goods")

Plots.plot!(public.year, (public.servbal .- adj_agg.adjearn3s_cca) ./ (public.gdpn .- adj_agg.adjearn3s_cca), 
    color= :blue, linewidth=2.25, label = "adjusted services", linestyle = :dash)
#insert black horizontal line at 0
Plots.plot!(public.year, zeros(length(public.year)), color= :black, linewidth=2, label = :none)
ylims!(-0.08, 0.04)
xlims!(1980, 2018)
xlabel!("Year", fontfamily="Arial", fontsize=12)
ylabel!("share of GDP", fontfamily="Arial", fontsize=12)
title!("Replicated Figure 5B", fontfamily="Arial", fontsize=14, fontweight="bold")

public.adj_goodbal = (public.goodbal) ./ (public.gdpn -adj_agg.adjearn3s_cca)
Plots.scatter!(public.year, public.adj_goodbal, color = :blue, marker = :Circle)



#translate python to julia
#python:
ax.text(1997, -0.05, 'Unadjusted')
#julia:





ax.set_xlim(1981, 2017)

ax.text(2006, -0.014, 'Adjusted')
ax.set_ylabel('share of GDP')

