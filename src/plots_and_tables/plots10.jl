"""
This function replicates a figure 10, which consists of two subplots. The figure is saved in the folder "ReplicationFiles/figures" as a pdf file.

    # Usage
```julia
plots10()
```
No arguments are needed for this function
"""
function plots10()
    gr()
    # Creating a new plot with the specified layout
    p = Plots.plot(size=(400, 400), margins = 10Plots.mm)
    
    Plots.plot!(p, public.year, public.compn ./ (public.corpincn .+ public.cfcn), color = :black, label = "Unadjusted", linewidth=2)
    
    Plots.plot!(p, public.year, public.compn ./ (public.corpincn .+ public.cfcn .- adj_agg.adjearn3s_cca), color = :blue, label = "Adjusted", linewidth=2)
    
    xlims!(p, 1981, 2017)
    ylims!(p, 0.54, 0.66)
    
    xlabel!(p, "Year", fontfamily="Arial", fontsize=12)
    ylabel!(p, "Share of income", fontfamily="Arial", fontsize=12)
    title!(p, "Replicated Figure 10", fontfamily="Arial", fontsize=12, fontweight="bold")
    
    Plots.savefig(p, "ReplicationFiles/figures/Figure10.pdf")
    Plots.savefig(p, "ReplicationFiles/figures/Figure10.png")

end