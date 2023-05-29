import Pkg; Pkg.add("Plots")
import Pkg; Pkg.add("Statistics")
import Pkg; Pkg.add("CSV")
import Pkg; Pkg.add("DataFrames")
import Pkg; Pkg.add("XLSX")
import Pkg; Pkg.add("Impute")
import Pkg; Pkg.add("Missings")
import Pkg; Pkg.add("Interpolations")
using DataFrames, Plots, Seaborn, Statistics, CSV, DataFrames, XLSX, Missings, Interpolations
using Impute


###################################################

weighdata()


using Plots

# Set the GR backend or use pyplot() for the PyPlot backend if available
gr()

# Plotting the data with customized aesthetics
Plots.plot(public[!, :year], 100 * public[!, :usdiaincn] ./ public[!, :gvabusn], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(public[!, :year], -100 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gvabusn], color=:blue, label="Weighted", linewidth=3)

# Setting x-axis and y-axis limits
xlims!(1980, 2018)
ylims!(0, 4.0)

# Adding text annotations
annotate!(2002.5, 3.75, "USDIA Income", fontfamily="Arial", fontsize=12)
annotate!(2008, 1.9, "Weighted\nAdjustment", fontfamily="Arial", fontsize=12)

# Setting axis labels and title
xlabel!("Year", fontfamily="Arial", fontsize=12)
ylabel!("Share of business-sector value added (percent)", fontfamily="Arial", fontsize=12)
title!("Replicated Figure 1A", fontfamily="Arial", fontsize=14, fontweight="bold")

# Saving the figure with higher resolution
Plots.savefig("ReplicationFiles/4-figures/agg_adj_share.pdf")

###########################






#git push -u origin main