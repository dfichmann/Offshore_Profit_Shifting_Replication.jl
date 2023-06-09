"""
    plots3()

Generates a two-panel figure, each panel representing a distinct subplot related to the petroleum industry and its impact on the business-sector value.

- **Panel A**: Displays the petroleum prices over the years from 1980 to 2018. The petroleum prices are depicted as a black line in dollars per barrel. 

- **Panel B**: Illustrates two distinct measures over the same period: The Weighted Adjustment of all industries (blue line) and the adjustment excluding petroleum industry (red dashed line). Both are represented as a share of the business-sector value added, in percent.

The figure is saved as a PDF in the folder "ReplicationFiles/figures" with the name "Figure3.pdf".

This function uses the GR backend for generating plots and the Plots.jl package for constructing the multi-panel figure.

# Usage
```julia
plots3()
```

No arguments are needed for this function

"""
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
    
    Plots.savefig(p, "ReplicationFiles/figures/Figure3.pdf")
    Plots.savefig(p, "ReplicationFiles/figures/Figure3.png")

    end