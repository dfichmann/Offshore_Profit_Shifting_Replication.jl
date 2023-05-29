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
    
    Plots.savefig(p, "ReplicationFiles/4-figures/Figure10.pdf")
end