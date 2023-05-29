function plots11()
    fdius12 = CSV.read("ReplicationFiles/0-confidential-data-replication-files/FDIUS/FigureForPaper2012.csv", DataFrame)
    
    fdius12 = sort!(fdius12, :WtdShrEmpCompPPE)
    
    gr()
    # Creating a new plot with the specified layout
    layout = @layout [a b]
    p = Plots.plot(layout=layout, size=(800, 400), margins = 10Plots.mm)
    
    Plots.plot!(p[1], fdius12.WtdShrEmpCompPPE, fdius12.LowessFitted, color = :blue, label = :none, linewidth=2)
    
    Plots.plot!(p[1], fdius12.WtdShrEmpCompPPE, fdius12.RegFitted, color = :red, label = :none, linewidth=2, linestyle=:dash)
    
    #add 45 degree line
    Plots.plot!(p[1], [0, 1], [0, 1], color = :black, label = :none, linewidth=2, linestyle=:dash)
    
    xlims!(p[1], 0, 0.75)
    ylims!(p[1], 0, 0.75)
    
    xlabel!(p[1], "U.S. apportionment weight", fontfamily="Arial", fontsize=12)
    ylabel!(p[1], "U.S. share of worldwide profit", fontfamily="Arial", fontsize=12)
    
    annotate!(p[1], 0.4, 0.6, "45- degree line", fontfamily="Arial", annotationfontsize=8)
    annotate!(p[1], 0.47, 0.4, "OLS\nfitted value", fontfamily="Arial", annotationfontsize=8)
    annotate!(p[1], 0.55, 0.2, "Lowess\nsmoothed value", fontfamily="Arial", annotationfontsize=8)
    
    
    fdius15 = CSV.read("ReplicationFiles/0-confidential-data-replication-files/FDIUS/FigureForPaper2015.csv", DataFrame)
    fdius15 = sort!(fdius15, :WtdShrEmpCompPPE)
    
    Plots.plot!(p[2], fdius15.WtdShrEmpCompPPE, fdius15.LowessFitted, color = :blue, label = :none, linewidth=2)
    
    Plots.plot!(p[2], fdius15.WtdShrEmpCompPPE, fdius15.RegFitted, color = :red, label = :none, linewidth=2, linestyle=:dash)
    
    #add 45 degree line
    Plots.plot!(p[2], [0, 1], [0, 1], color = :black, label = :none, linewidth=2, linestyle=:dash)
    
    xlims!(p[2], 0, 0.75)
    ylims!(p[2], 0, 0.75)
    
    xlabel!(p[2], "U.S. apportionment weight", fontfamily="Arial", fontsize=12)
    ylabel!(p[2], "U.S. share of worldwide profit", fontfamily="Arial", fontsize=12)
    
    annotate!(p[2], 0.4, 0.6, "45- degree line", fontfamily="Arial", annotationfontsize=8)
    annotate!(p[2], 0.47, 0.4, "OLS\nfitted value", fontfamily="Arial", annotationfontsize=8)
    annotate!(p[2], 0.55, 0.2, "Lowess\nsmoothed value", fontfamily="Arial", annotationfontsize=8)
    
    Plots.savefig(p, "ReplicationFiles/4-figures/Figure11.pdf")
end