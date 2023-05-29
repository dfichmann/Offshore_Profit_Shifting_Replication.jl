


############# FIGURE 1 ###################
function plots1()
# Set the GR backend
gr()
# Creating a layout with 1 row and 2 columns
layout = @layout([a b])
# Creating a new plot with the specified layout
p = Plots.plot(layout=layout, size=(1000, 400), margins = 10Plots.mm)

# Plotting the first figure in the left subplot
Plots.plot!(p[1], public[!, :year], 100 * public[!, :usdiaincn] ./ public[!, :gvabusn], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(p[1], public[!, :year], -100 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gvabusn], color=:blue, label="Weighted", linewidth=3)
xlims!(p[1], 1980, 2018)
ylims!(p[1], 0, 4.0)
annotate!(p[1], 2000, 3, "USDIA Income", fontfamily="Arial", annotationfontsize=8)
annotate!(p[1], 2008, 1.9, "Weighted\nAdjustment", fontfamily="Arial", annotationfontsize=8)
xlabel!(p[1], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[1], "Share of business-sector value added (percent)", fontfamily="Arial", fontsize=12)
title!(p[1], "Replicated Figure 1A", fontfamily="Arial", fontsize=14, fontweight="bold")

# Plotting the second figure in the right subplot
Plots.plot!(p[2], public[!, :year], public[!, :usdiaincn] ./ public[!, :gva_deflator], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(p[2], public[!, :year], -1 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gva_deflator], color=:blue, label="Weighted", linewidth=3)
xlims!(p[2], 1980, 2018)
annotate!(p[2], 2001, 375, "USDIA Income", fontfamily="Arial", annotationfontsize=8)
annotate!(p[2], 2010, 230, "Weighted\nAdjustment", fontfamily="Arial", annotationfontsize=8)
xlabel!(p[2], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[2], "Billions of dollars", fontfamily="Arial", fontsize=12)
title!(p[2], "Replicated Figure 1B", fontfamily="Arial", fontsize=14, fontweight="bold")

# Saving the panel figure with higher resolution
Plots.savefig(p, "ReplicationFiles/4-figures/Figure1.pdf")
end
plots1()

############# FIGURE 2 ###################
using Impute 

function plots2()
# Set the GR backend
gr()
# Creating a layout with 1 row and 2 columns
layout = @layout([a b])
# Creating a new plot with the specified layout
p = Plots.plot(layout=layout, size=(1000, 400), margins = 10Plots.mm)

# Plotting the data with customized aesthetics
Plots.plot!(p[1], public[!, :year],public[!, :usdiaincn] ./ public[!, :gva_deflator], color=:black, label="USDIA Income", legend=:topleft, linewidth=3)
Plots.plot!(p[1], public[!, :year], -1 * adj_agg[!, :adjearn3s_cca] ./ public[!, :gva_deflator], color=:blue, label="Weighted", linewidth=3)
Plots.plot!(p[1], public[!, :year], -1 * adj_agg[!, :adjearncomps_cca] ./ public[!, :gva_deflator], color=:red, linestyle=:dash, label="Compensation", linewidth=3)
Plots.plot!(p[1], public[!, :year], -1 * adj_agg[!, :adjearnppes_cca] ./ public[!, :gva_deflator], color=:black, linestyle=:dashdotdot, label="PPE", linewidth=3)
Plots.plot!(p[1], public[!, :year], -1 * adj_agg[!, :adjearnrdstks_cca] ./ public[!, :gva_deflator], color=:green, linestyle=:dot, label="R&D", linewidth=3)

# Setting x-axis and y-axis limits
xlims!(p[1], 1980, 2018)

# Adding text annotations
annotate!(p[1], 2001, 375, "USDIA Income", fontfamily="Arial", annotationfontsize=8)

# Setting axis labels and title
xlabel!(p[1], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[1], "Billions of dollars", fontfamily="Arial", fontsize=12)
title!(p[1], "Replicated Figure 2A", fontfamily="Arial", fontsize=14, fontweight="bold")

# Plotting the data with customized aesthetics
Plots.plot!(p[2], public.year, public.usdiaincn ./ public.gva_deflator,
    color = :black, label = "USDIA Income", legend = :topleft, linewidth = 3)

# Plotting boot data with +/- 2 standard deviations
Plots.plot!(p[2], panel_stats.Year, panel_stats.mean__adjustment .- panel_stats.std__adjustment .* 2,
    fillrange = panel_stats.mean__adjustment .+ panel_stats.std__adjustment .* 2,
    fillcolor = :lightblue, alpha = 0.3, linecolor = :white, label = "+/-2 s.d.") #remove line 

Plots.plot!(p[2], public.year, -1*adj_agg.adjearn3s_cca ./public.gva_deflator,
    color = :blue, label = "Weighted", linewidth = 3)

Plots.plot!(p[2], public.year, panel_stats.q25__adjustment, color= :black, linestyle = :dash, alpha = 0.3, label = "25/75 percentiles") #label "25/75 percentiles"
Plots.plot!(p[2], public.year, panel_stats.q75__adjustment, color= :black, linestyle = :dash, alpha = 0.3, label = :false)


# Setting x-axis and y-axis limits
xlims!(p[2], 1980, 2018)

# Adding text annotations
annotate!(p[2], 2001, 375, "USDIA Income", fontfamily="Arial", annotationfontsize=8)

# Setting axis labels and title
xlabel!(p[2], "Year", fontfamily="Arial", fontsize=12)
ylabel!(p[2], "Billions of dollars (2009 base year)", fontfamily="Arial", fontsize=12)
title!(p[2], "Replicated Figure 2A", fontfamily="Arial", fontsize=12, fontweight="bold")

# Saving the figure with higher resolution
Plots.savefig(p, "ReplicationFiles/4-figures/Figure2.pdf")
end 

plots2()

############# FIGURE 3 ###################

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

Plots.savefig(p, "ReplicationFiles/4-figures/Figure3.pdf")
end

plots3()

############# FIGURE 4 ###################


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

Plots.savefig(p, "ReplicationFiles/4-figures/Figure4.pdf")

end 

plots4()

############# FIGURE 6 ###################
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

Plots.savefig(p, "ReplicationFiles/4-figures/Figure6.pdf")

end
plots6()

############# FIGURE 7 ###################

function plots7()
public.gdibusn = public.gdin - (public.gdpn .- public.gvabusn)
public.gdibusr = public.gdibusn ./ public.gva_deflator

prod = DataFrame(Year = public.year)
prod.uprod_log = log.((public.gvabusr .* public.gdibusr).^(1/2) ./ public.hrs)

prod.uprod_gr = [missing;diff(prod.uprod_log) .* 100]
prod.uprod_cum = (prod.uprod_log .- prod.uprod_log[1]) .* 100

prod.gvabusr_adj = (public.gvabusn .- adj_agg.adjearn3s_cca) ./ public.gva_deflator
prod.gdibusr_adj = (public.gdibusn .- adj_agg.adjearn3s_cca) ./ public.gva_deflator
prod.aprod_log = log.((prod.gvabusr_adj .* prod.gdibusr_adj).^(1/2) ./ public.hrs)
prod.aprod_gr = [missing; diff(prod.aprod_log) .* 100]
prod.aprod_cum = (prod.aprod_log .- prod.aprod_log[1]) .* 100 

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

Plots.savefig(p, "ReplicationFiles/4-figures/Figure7.pdf")
end

############# Table 5 ###################
function table5()
intervals = [(1982, 2016), (1982,1994), (1994,2004), (2004,2016), (2004,2010),(2010,2016)]

uc, ac, ua, aa = [], [], [], []
for i in intervals
    push!(uc, prod[prod.Year .== i[1], :uprod_cum][1] - prod[prod.Year .== i[2], :uprod_cum][1])
    push!(ac, prod[prod.Year .== i[1], :aprod_cum][1] - prod[prod.Year .== i[2], :aprod_cum][1])
    push!(ua, (prod[prod.Year .== i[1], :uprod_cum][1] - prod[prod.Year .== i[2], :uprod_cum][1]) / (i[1]-i[2]))
    push!(aa, (prod[prod.Year .== i[1], :aprod_cum][1] - prod[prod.Year .== i[2], :aprod_cum][1]) / (i[1]-i[2]))
end

indext = [string(i[1]) * "--" * string(i[2]) for i in intervals]

t5 = DataFrame()
t5.Cumulative_growth_rate_unadjusted = uc
t5.Cumulative_growth_rate_adjusted = ac
t5.Average_annual_growth_rate_unadjusted = ua
t5.Average_annual_growth_rate_adjusted = aa

print(t5)

# Open the file in write mode
file = open("Table5.md", "w")

# Write the table header to the file
write(file, "| Intervals | Cumulative Growth Rate (Unadjusted) | Cumulative Growth Rate (Adjusted) | Average Annual Growth Rate (Unadjusted) | Average Annual Growth Rate (Adjusted) |\n")
write(file, "| --- | --- | --- | --- | --- |\n")

# Write the rounded table rows to the file
for i in 1:size(t5, 1)
    cumulative_growth_rate_unadjusted = round(t5.Cumulative_growth_rate_unadjusted[i], digits=1)
    cumulative_growth_rate_adjusted = round(t5.Cumulative_growth_rate_adjusted[i], digits=1)
    average_annual_growth_rate_unadjusted = round(t5.Average_annual_growth_rate_unadjusted[i], digits=1)
    average_annual_growth_rate_adjusted = round(t5.Average_annual_growth_rate_adjusted[i], digits=1)

    write(file, "| $(indext[i]) | $cumulative_growth_rate_unadjusted | $cumulative_growth_rate_adjusted | $average_annual_growth_rate_unadjusted | $average_annual_growth_rate_adjusted |\n")
end

# Close the file
close(file)
end


############# FIGURE 10 ###################
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


############# FIGURE 11 ###################
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


############# FIGURE 4 ###################
