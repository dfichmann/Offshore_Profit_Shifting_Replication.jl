module Offshore_Profit_Shifting_Replication

# Write your package code here.
using Markdown, DataFrames, Plots, Statistics, CSV, DataFrames, XLSX, Missings, Interpolations, Impute



include("wrangle_data/makeplotdata.jl")

public, adj_agg, adj_ind, adj_tax = makeplotdata()

include("wrangle_data/makedataplot2.jl")
panel_stats = makedataforplot2()

include("wrangle_data/makedataplot7.jl")
prod = makedataforplot7()

include("wrangle_data/makedataplot8.jl")
inds = makedataforplot8()

include("plots_and_tables/plots1.jl")
include("plots_and_tables/plots2.jl")
include("plots_and_tables/plots3.jl")
include("plots_and_tables/plots4.jl")
include("plots_and_tables/plots6.jl")
include("plots_and_tables/plots7.jl")
include("plots_and_tables/plots8.jl")
include("plots_and_tables/plots9.jl")
include("plots_and_tables/plots10.jl")
include("plots_and_tables/plots11.jl")

include("plots_and_tables/table1.jl")
include("plots_and_tables/table2.jl")
include("plots_and_tables/table5.jl")
include("plots_and_tables/table6.jl")

### include the testcode.jl file:
#include("testcode.jl")

end