function plots7() 
    gr()
    # Creating a layout with 1 row and 2 columns
    layout = @layout([a b])
    # Creating a new plot with the specified layout
    p = Plots.plot(layout=layout, size=(1000, 400), margins = 10Plots.mm)
    
    Plots.plot!(p[1], prod.Year, prod.uprod_cum, color = :black, label = "Unadjusted", linewidth=2)
    Plots.plot!(p[1], prod.Year, prod.aprod_cum, color = :blue, label = "Adjusted", linewidth=2)
    
    xlims!(p[1], 1981, 2017)
    ylims!(p[1], -2, 75)
    xlabel!(p[1], "Year", fontfamily="Arial", fontsize=12)
    ylabel!(p[1], "log percent", fontfamily="Arial", fontsize=12)
    title!(p[1], "Replicated Figure 7A", fontfamily="Arial", fontsize=12, fontweight="bold")
    
    #add two vertical lines at year 1994 and 2004
    vline!(p[1], [1994, 2004], color = :black, linewidth = 2, label = :none) 
    
    Plots.plot!(p[2], prod.Year, prod.aprod_cum .- prod.uprod_cum, color = :blue, label = "Adjusted", linewidth=2)
    
    xlims!(p[2], 1981, 2017)
    ylims!(p[2], -0.25, 1.25)
    xlabel!(p[2], "Year", fontfamily="Arial", fontsize=12)
    ylabel!(p[2], "log percent", fontfamily="Arial", fontsize=12)
    title!(p[2], "Replicated Figure 7B", fontfamily="Arial", fontsize=12, fontweight="bold")
    
    #add two vertical lines at year 1994 and 2004
    vline!(p[2], [1994, 2004], color = :black, linewidth = 2, label = :none)
    
    Plots.savefig(p, "ReplicationFiles/figures/Figure7.pdf")
    end
    
    