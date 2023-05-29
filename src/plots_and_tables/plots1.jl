############# FIGURE 1 ###################
"""
This function replicates a figure 1, which consists of two subplots. The figure is saved in the folder "ReplicationFiles/figures" as a pdf file.
"""
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
    Plots.savefig(p, "ReplicationFiles/figures/Figure1.pdf")
    end
    plots1()