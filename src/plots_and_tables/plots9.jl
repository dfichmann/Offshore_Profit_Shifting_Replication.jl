"""
This function replicates a figure 9, which consists of two subplots. The figure is saved in the folder "ReplicationFiles/figures" as a pdf file.

    # Usage
```julia
plots9()
```

No arguments are needed for this function
"""
function plots9()
    gr()
    p = Plots.plot(size=(500, 400), margins = 10Plots.mm)

    Plots.plot!(p, inds.year, 100 .* inds.rd_prod_adj_cgr, color=:blue, label="adjusted")
    Plots.plot!(p, inds.year, 100 .* inds.rd_prod_unadj_cgr, color=:blue, linestyle=:dash, label="unadjusted")
    
    Plots.plot!(p, inds.year, 100 .* inds.nrd_prod_adj_cgr, color=:red, label="adjusted")
    Plots.plot!(p, inds.year, 100 .* inds.nrd_prod_unadj_cgr, color=:red, linestyle=:dash, label="unadjusted")

    annotate!(p, 1990, 100, "R&D Intensive", fontfamily="Arial", annotationfontsize=8)
    annotate!(p, 2000, 48, "non-R&D Intensive", fontfamily="Arial", annotationfontsize=8)
    title!(p, "Replicated Figure 9", fontfamily="Arial", fontsize=14, fontweight="bold")

    Plots.savefig(p, "ReplicationFiles/figures/Figure9.pdf")
    Plots.savefig(p, "ReplicationFiles/figures/Figure9.png")
end
