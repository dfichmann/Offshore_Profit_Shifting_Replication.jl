"""
This function replicates a figure 8, which consists of two subplots. The figure is saved in the folder "ReplicationFiles/figures" as a pdf file.

    # Usage
```julia
plots8()

No arguments are needed for this function
"""
function plots8()
    gr()
    # Creating a layout with 1 row and 2 columns
    layout = @layout([a b])
    # Creating a new plot with the specified layout
    p = Plots.plot(layout=layout, size=(1000, 400), margins = 10Plots.mm)
    
    Plots.plot!(p[1], inds.year, (-100)*inds.rd ./ inds.rd_nva, color= :blue, linewidth=2, label = :none)
    Plots.plot!(p[1], inds.year, (-100)*inds.nrd ./ inds.nrd_nva, color= :blue, linewidth=2, label = :none)

    xlabel!(p[1], "Year")
    ylabel!(p[1], "Share of group's unadjusted value added")
    xlims!(p[1], 1993, 2017)
    ylims!(p[1], 0, 7)

    annotate!(p[1], 2000, 5, "R&D Intensive", fontfamily="Arial", annotationfontsize=8)
    annotate!(p[1], 2007, 1, "non-R&D Intensive", fontfamily="Arial", annotationfontsize=8)
    title!(p[1], "Replicated Figure 8A", fontfamily="Arial", fontsize=14, fontweight="bold")

    inds_1994_2016 = inds[inds[!, :year] .>= 1994 .& inds[!, :year] .<= 2016, :]

    # Get the value for the year 1994 for each group
    rd_1994_val = inds[inds[!, :year] .== 1994, :rd_prod_adj_cgr_dif][1]
    nrd_1994_val = inds[inds[!, :year] .== 1994, :nrd_prod_adj_cgr_dif][1]

    # Subtract the value for the year 1994 from the values
    rd_values = 100 .* inds_1994_2016.rd_prod_adj_cgr_dif .- 100 * rd_1994_val
    nrd_values = 100 .* inds_1994_2016.nrd_prod_adj_cgr_dif .- 100 * nrd_1994_val

    # Create the plot
    Plots.plot!(p[2], inds_1994_2016.year, rd_values, color= :blue, linewidth=2, label = :none)
    Plots.plot!(p[2], inds_1994_2016.year, nrd_values, color= :blue, linewidth=2, label = :none)
    ylabel!(p[2], "log percent")
    xlims!(p[2], 1994, 2017)
    ylims!(p[2], -0.1, 5)

    annotate!(p[2], 2000, 3.5, "R&D Intensive", fontfamily="Arial", annotationfontsize=8)
    annotate!(p[2], 2006, 1, "non-R&D Intensive", fontfamily="Arial", annotationfontsize=8)

    # Add vertical line
    vline!(p[2], [2004], color=:black, lw=1.0, label = :none)

    title!(p[2], "Replicated Figure 8B", fontfamily="Arial", fontsize=14, fontweight="bold")

    Plots.savefig(p, "ReplicationFiles/figures/Figure8.pdf")
    Plots.savefig(p, "ReplicationFiles/figures/Figure8.png")


end




    
