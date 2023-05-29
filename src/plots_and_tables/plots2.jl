"""
    plots2()

Generates a two-panel figure which displays the USDIA Income and its Weighted Adjustment, along with the Compensation, PPE, and R&D adjustments in billions of dollars from 1980 to 2018. 

Each panel represents a distinct subplot:

- **Panel A**: Illustrates the USDIA Income, Weighted Adjustment, Compensation, PPE, and R&D adjustments over the specified period. The USDIA Income is shown as a black line, the Weighted Adjustment is depicted in blue, the Compensation adjustment in a dashed red line, the PPE adjustment in a dash-dotted black line, and the R&D adjustment in a dotted green line.

- **Panel B**: Displays the USDIA Income and Weighted Adjustment, with additional statistical information like +/-2 standard deviations range shown in light blue, and the 25th and 75th percentiles shown with dashed black lines.

The figure is saved as a PDF in the folder "ReplicationFiles/figures" with the name "Figure2.pdf".

This function uses the GR backend for generating plots and the Plots.jl package for constructing the multi-panel figure.

# Usage
```julia
plots2()

No arguments needed for this function
"""
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
Plots.savefig(p, "ReplicationFiles/figures/Figure2.pdf")
Plots.savefig(p, "ReplicationFiles/figures/Figure2.png")

end 