module Offshore_Profit_Shifting_Replication

# Write your package code here.

using Markdown
using PDFIO
using GeoJSON
using Plots
using Statistics
using CSV
using DataFrames

include("makeplotdata.jl")

public, adj_agg, adj_ind, adj_tax = makeplotdata()

include("makedataplot2.jl")
panel_stats = makedataforplot2()

include("makedataplot7.jl")
prod = makedataforplot7()

include("makedataplot8.jl")
inds = makedataforplot8()

include("plots/plots1.jl")
include("plots/plots2.jl")
include("plots/plots3.jl")
include("plots/plots4.jl")
include("plots/plots6.jl")
include("plots/plots7.jl")
include("plots/plots8.jl")
include("plots/plots9.jl")
include("plots/plots10.jl")
include("plots/plots11.jl")
include("plots/table1.jl")
include("plots/table5.jl")
include("plots/table6.jl")

plots1()
plots2()
plots3()
plots4()
plots6()
plots7()
plots8()
plots9()
plots10()

table1()
table5()
table6()



### include the testcode.jl file:
#include("testcode.jl")

end