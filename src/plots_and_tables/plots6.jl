"""
This function replicates a figure 6, which consists of two subplots. The figure is saved in the folder "ReplicationFiles/figures" as a pdf file.
"""
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
    
    Plots.savefig(p, "ReplicationFiles/figures/Figure6.pdf")
    
end