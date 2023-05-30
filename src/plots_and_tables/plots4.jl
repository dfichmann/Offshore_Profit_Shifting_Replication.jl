"""
This function replicates a figure 4, which consists of two subplots. The figure is saved in the folder "ReplicationFiles/figures" as a pdf file.

    # Usage
    ```julia
    plots4()
    ```
    
    No arguments are needed for this function
    """
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
    
    Plots.savefig(p, "ReplicationFiles/figures/Figure4.pdf")
    Plots.savefig(p, "ReplicationFiles/figures/Figure4.png")
    
    end 
    