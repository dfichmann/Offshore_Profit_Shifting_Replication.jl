using Plots
using Statistics

function makedataforf2()
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
    end




savefolder = "ReplicationFiles/4-figures"

############# FIGURE 1 ###################
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

############# FIGURE 2 ###################
using Impute 

function plots2()
# Set the GR backend
gr()
# Creating a layout with 1 row and 2 columns
layout = @layout([a b])
# Creating a new plot with the specified layout
p = Plots.plot(layout=layout, size=(1000, 400), margins = 10Plots.mm)

# Plotting the data with customized aesthetics
Plots.plot!(p[1], public[!, :year],public[!, :usdiaincn] ./ public[!, :gva_deflator], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(p[1], public[!, :year], -1 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gva_deflator], color=:blue, label="Weighted", linewidth=3)
Plots.plot!(p[1], public[!, :year], -1 * adj_agg[!, :adjearncomps_cca] ./ public[!, :gva_deflator], color=:red, linestyle=:dash, label="Compensation", linewidth=3)
Plots.plot!(p[1], public[!, :year], -1 * adj_agg[!, :adjearnppes_cca] ./ public[!, :gva_deflator], color=:black, linestyle=:dashdotdot, label="PPE", linewidth=3)
Plots.plot!(p[1], public[!, :year], -1 * adj_agg[!, :adjearnrdstks_cca] ./ public[!, :gva_deflator], color=:green, linestyle=:dot, label="R&D", linewidth=3)

# Setting x-axis and y-axis limits
xlims!(p[1], 1980, 2018)

# Adding text annotations
annotate!(p[1], 2001, 375, "USDIA Income", fontfamily="Arial", annotationfontsize=8)

# Setting axis labels and title
xlabel!(p[1], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[1], "Billions of dollars", fontfamily="Arial", fontsize=12)
title!(p[1], "Replicated Figure 2A", fontfamily="Arial", fontsize=14, fontweight="bold")


##################
makedataforf2()  #
##################
# Plotting the data with customized aesthetics
Plots.plot!(p[2], public.year, public.usdiaincn ./ public.gva_deflator,
    color = :black, label = "USDIA Income", legend = :topleft, linewidth = 3)

# Plotting boot data with +/- 2 standard deviations
Plots.plot!(p[2], panel_stats.Year, panel_stats.mean__adjustment .- panel_stats.std__adjustment .* 2,
    fillrange = panel_stats.mean__adjustment .+ panel_stats.std__adjustment .* 2,
    fillcolor = :lightblue, alpha = 0.3, linecolor = :white, label = "+/-2 s.d.") #remove line 

Plots.plot!(p[2], public.year, -1*adj_agg.adjearn3s_cca ./public.gva_deflator,
    color = :blue, label = "Weighted", linewidth = 3)

Plots.plot!(p[2], public.year, panel_stats.q25__adjustment, color= :black, linestyle = :dash, alpha = 0.3, label = "25/75 percentiles") #label "25/75 percentiles"
Plots.plot!(p[2], public.year, panel_stats.q75__adjustment, color= :black, linestyle = :dash, alpha = 0.3, label = :false)


# Setting x-axis and y-axis limits
xlims!(p[2], 1980, 2018)

# Adding text annotations
annotate!(p[2], 2001, 375, "USDIA Income", fontfamily="Arial", annotationfontsize=8)

# Setting axis labels and title
xlabel!(p[2], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[2], "Billions of dollars (2009 base year)", fontfamily="Arial", fontsize=12)
title!(p[2], "Replicated Figure 2A", fontfamily="Arial", fontsize=12, fontweight="bold")

# Saving the figure with higher resolution
Plots.savefig(p, "ReplicationFiles/4-figures/Figure2.pdf")
end 

plots2()

############# FIGURE 3 ###################

function plots3()
# Set the GR backend
gr()
# Creating a layout with 1 row and 2 columns
layout = @layout([a b])
# Creating a new plot with the specified layout
p = Plots.plot(layout=layout, size=(1000, 400), margins = 10Plots.mm)

Plots.plot!(p[1], public.year, public.poil, color= :black, linewidth=2.25, label = :none)
xlabel!(p[1], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[1], "dollars per barrel", fontfamily="Arial", fontsize=12)
xlims!(p[1], 1980, 2018)
title!(p[1], "Replicated Figure 3A", fontfamily="Arial", fontsize=14, fontweight="bold")

#### 3B
Plots.plot!(p[2], public.year, -100*adj_agg.adjearn3s_cca ./ public.gvabusn,
    color = :blue, label = "Weighted", legend = :topleft, linewidth = 3)
adjwt3s_3240 = adj_ind[adj_ind.IEDindPar .== 3240, "adjwt3s"]
# Calculate the numerator
numerator = (adj_agg.adjearn3s_cca .* (-1) .- adjwt3s_3240 .* (-1) .* public.income_adj_factor)
# Calculate the denominator
denominator = public.gvabusn
# Calculate the final expression
expression = numerator ./ denominator .* 100
# Plotting the expression
Plots.plot!(p[2], public.year, expression,
    color = :red, linestyle = :dash)

# Setting x-axis and y-axis limits
xlims!(p[2], 1980, 2018)

# Adding text annotations
annotate!(p[2], 1995, 1.25, "Adjustment all industries", fontfamily="Arial", annotationfontsize=8)
annotate!(p[2], 2008, 0.5, "Adjustment ex. petroleum", fontfamily="Arial", annotationfontsize=8)
# Setting axis labels and title
xlabel!(p[2], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[2], "share of business-sector value added (percent)", fontfamily="Arial", fontsize=10)
title!(p[2], "Replicated Figure 3B", fontfamily="Arial", fontsize=14, fontweight="bold")

Plots.savefig(p, "ReplicationFiles/4-figures/Figure3.pdf")
end

plots3()

############# FIGURE 4 ###################

# Set the GR backend
function plots4()
gr()
# Creating a layout with 1 row and 2 columns
layout = @layout([a b])
# Creating a new plot with the specified layout
p = Plots.plot(layout=layout, size=(1000, 400), margins = 10Plots.mm)

Plots.plot!(p[1], public.year, public.tradebal ./public.gdpn, color= :black, linewidth=2.25, label = "unadjusted")
Plots.plot!(p[1], public.year, (public.tradebal .- adj_agg.adjearn3s_cca) ./ (public.gdpn .- adj_agg.adjearn3s_cca), 
    color= :blue, linewidth=2.25, label = "adjusted", linestyle = :dash)
#insert black horizontal line at 0
Plots.plot!(p[1], public.year, zeros(length(public.year)), color= :black, linewidth=2, label = :none)
ylims!(p[1], -0.06, 0.01)
xlims!(p[1], 1980, 2018)
xlabel!(p[1], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[1], "share of GDP", fontfamily="Arial", fontsize=12)
title!(p[1], "Replicated Figure 5A", fontfamily="Arial", fontsize=14, fontweight="bold")

annotate!(p[1], 1997, -0.05, "Unadjusted", fontfamily="Arial", annotationfontsize=8)
annotate!(p[1], 2006, -0.014, "Adjusted", fontfamily="Arial", annotationfontsize=8)

### 5B
Plots.plot!(p[2], public.year, public.goodbal ./public.gdpn, color = :darkred, linewidth=1.5, label = "unadjusted goods")
Plots.plot!(p[2], public.year, public.servbal ./ public.gdpn, color= :black, linewidth=2.25, label = "adjusted goods")

Plots.plot!(p[2], public.year, (public.servbal .- adj_agg.adjearn3s_cca) ./ (public.gdpn .- adj_agg.adjearn3s_cca), 
    color= :blue, linewidth=2.25, label = "adjusted services", linestyle = :dash)
#insert black horizontal line at 0
Plots.plot!(p[2], public.year, zeros(length(public.year)), color= :black, linewidth=2, label = :none, legend=:bottomleft)
ylims!(p[2], -0.08, 0.04)
xlims!(p[2], 1980, 2018)
xlabel!(p[2], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[2], "share of GDP", fontfamily="Arial", fontsize=12)
title!(p[2], "Replicated Figure 5B", fontfamily="Arial", fontsize=14, fontweight="bold")

public.adj_goodbal = (public.goodbal) ./ (public.gdpn -adj_agg.adjearn3s_cca)
Plots.scatter!(p[2], public.year[2:2:end], public.adj_goodbal[2:2:end], color = :darkred, marker = :Circle, label = :none)

Plots.savefig(p, "ReplicationFiles/4-figures/Figure4.pdf")

end 

plots4()

############# FIGURE 6 ###################
function plots6()
gr()
# Creating a layout with 1 row and 2 columns
layout = @layout([a b])
# Creating a new plot with the specified layout
p = Plots.plot(layout=layout, size=(1000, 400), margins = 10Plots.mm)

Plots.plot!(p[1], public.year, public.fdiusinc ./ (0.5 .* public.fdiusstks .+ 0.5 .* [NaN; public.fdiusstks[1:end-1]]) .* 100, color = :black, label = :none, linewidth=2)
Plots.plot!(p[1], public.year, public.usdiainc ./ (0.5 .* public.usdiastks .+ 0.5 .* [NaN; public.usdiastks[1:end-1]]) .* 100, color = :black, label = :none, linewidth=2)
Plots.plot!(p[1], public.year, (public.usdiainc .+ adj_agg.adjwt3s) ./ (0.5.*public.usdiastks .+ 0.5 .* [NaN; public.usdiastks[1:end-1]]) .* 100, color = :blue, linestyle = :dash, label = :none,linewidth=2)

annotate!(p[1], 2008, 14, "Unadjusted USDIA", fontfamily="Arial", annotationfontsize=8)
annotate!(p[1], 2004, 0, "Unadjusted USDIA", fontfamily="Arial", annotationfontsize=8)
annotate!(p[1], 1990, 6, "Unadjusted USDIA", fontfamily="Arial", annotationfontsize=8)

ylims!(p[1], -2, 20)
xlims!(p[1], 1980, 2018)
xlabel!(p[1], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[1], "annual return (percent)", fontfamily="Arial", fontsize=12)
title!(p[1], "Replicated Figure 6A", fontfamily="Arial", fontsize=12, fontweight="bold")

Plots.plot!(p[2], public.year, public.usdiainc_nhavens ./ (0.5 .* public.usdia_nhavens 
            .+ 0.5 .* [NaN; public.usdia_nhavens[1:end-1]]) .* 100, 
            color = :black, label = "Unadjusted Non-Havens", linewidth=2)

Plots.plot!(p[2], public.year, (public.usdiainc_nhavens .+ adj_tax[adj_tax.Haven .== 0, "adjwt3s"]) 
                ./ (0.5.*public.usdia_nhavens .+ 0.5 .* [NaN; public.usdia_nhavens[1:end-1]]) 
                .* 100, color = :black, linestyle = :dash, label = "Adjusted Non-Havens",linewidth=2)

Plots.plot!(p[2], public.year, public.usdiainc_havens ./ (0.5 .* public.usdia_havens .+ 0.5 .* [NaN; public.usdia_havens[1:end-1]]) .* 100, color = :red, label = "Unadjusted Havens", linewidth=2)

Plots.plot!(p[2], public.year, (public.usdiainc_havens .+ adj_tax[adj_tax.Haven .== 1, "adjwt3s"])./ (0.5.*public.usdia_havens .+ 0.5 .* [NaN; public.usdia_havens[1:end-1]]) .* 100, color = :red, linestyle = :dash, label = "Adjusted Havens",linewidth=2)

#horizontal line at 0
Plots.plot!(p[2], public.year, zeros(length(public.year)), color= :black, linewidth=1, label = :none, legend=:topright)

ylims!(p[2], -2, 22)
xlims!(p[2], 1980, 2018)
xlabel!(p[2], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[2], "annual return (percent)", fontfamily="Arial", fontsize=12)
title!(p[2], "Replicated Figure 6B", fontfamily="Arial", fontsize=12, fontweight="bold")

Plots.savefig(p, "ReplicationFiles/4-figures/Figure6.pdf")

end
plots6()

############# FIGURE 7 ###################

















### Translate PYTHON to JULIA
### here is the PYTHON code:
public['gdibusn'] = public['gdin'] - (public['gdpn']-public['gvabusn'])
public['gdibusr'] = public['gdibusn'] / public['gva_deflator']

prod=pd.DataFrame()
prod['uprod_log'] = np.log((public['gvabusr']*public['gdibusr'] )**(1/2)/public['hrs'])
prod['uprod_gr'] = prod['uprod_log'].diff()*100
prod['uprod_cum'] = (prod['uprod_log'] - prod.loc[1982,'uprod_log'])*100

prod['gvabusr_adj'] = (public['gvabusn']-adj_agg['adjearn3s_cca'])/public['gva_deflator']
prod['gdibusr_adj'] = (public['gdibusn']-adj_agg['adjearn3s_cca'])/public['gva_deflator']
prod['aprod_log'] = np.log((prod['gvabusr_adj']*prod['gdibusr_adj'] )**(1/2)/public['hrs'])
prod['aprod_gr'] = prod['aprod_log'].diff()*100
prod['aprod_cum'] = (prod['aprod_log'] - prod.loc[1982,'aprod_log'])*100

### JULIA code 
public.gdibusn = public.gdin - (public.gdpn .- public.gvabusn)
public.gdibusr = public.gdibusn ./ public.gva_deflator

prod = DataFrame()
prod.uprod_log = log.((public.gvabusr .* public.gdibusr).^(1/2) ./ public.hrs)
uprod_gr = diff(prod.uprod_log) .* 100
prod.uprod_cum = (prod.uprod_log .- prod.uprod_log[1982]) .* 100

prod.gvabusr_adj = (public.gvabusn .- adj_agg.adjearn3s_cca) ./ public.gva_deflator
prod.gdibusr_adj = (public.gdibusn .- adj_agg.adjearn3s_cca) ./ public.gva_deflator
prod.aprod_log = log.((prod.gvabusr_adj .* prod.gdibusr_adj).^(1/2) ./ public.hrs)
prod.aprod_gr = diff(prod.aprod_log) .* 100

prod.aprod_cum = (prod.aprod_log .- prod.aprod_log[1982]) .* 100 ????




