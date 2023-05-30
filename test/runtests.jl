using Offshore_Profit_Shifting_Replication
using Test
using Markdown, DataFrames, Plots, Statistics, CSV, DataFrames, XLSX, Missings, Interpolations, Impute, DataFramesMeta

    public = CSV.read(joinpath(@__DIR__, "..", "ReplicationFiles/data/aggregate.csv"), DataFrame)
    adj_agg = DataFrame(XLSX.readtable(joinpath(@__DIR__, "..", "ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNet.xlsx"), "ADJNETSCALE"))
    adj_ind = DataFrame(XLSX.readtable(joinpath(@__DIR__, "..", "ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetIndustry.xlsx"), "ADJINDSCALE"))
    adj_tax = DataFrame(XLSX.readtable(joinpath(@__DIR__, "..", "ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetHaven.xlsx"), "ADJHVNSCALE"))

@testset "Offshore_Profit_Shifting_Replication.jl" begin

# Run the makeplotdata function
public_out, adj_agg_out, adj_ind_out, adj_tax_out = Offshore_Profit_Shifting_Replication.makeplotdata(public, adj_agg, adj_ind, adj_tax)

# Check the integrity of the output data
@test isa(public_out, DataFrame)
@test isa(adj_agg_out, DataFrame)
@test isa(adj_ind_out, DataFrame)
@test isa(adj_tax_out, DataFrame)

# Run the plots
Offshore_Profit_Shifting_Replication.plots1()
Offshore_Profit_Shifting_Replication.plots2()
Offshore_Profit_Shifting_Replication.plots3()
Offshore_Profit_Shifting_Replication.plots4()
Offshore_Profit_Shifting_Replication.plots6()
Offshore_Profit_Shifting_Replication.plots7()
Offshore_Profit_Shifting_Replication.plots8()
Offshore_Profit_Shifting_Replication.plots9()
Offshore_Profit_Shifting_Replication.plots10()
Offshore_Profit_Shifting_Replication.plots11()

# Check if the output files exist in the correct directory
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure1.pdf"))
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure2.pdf"))
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure3.pdf"))
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure4.pdf"))
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure6.pdf"))
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure7.pdf"))
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure8.pdf"))
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure9.pdf"))
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure10.pdf"))
@test isfile(joinpath(@__DIR__, "..", "ReplicationFiles/figures/Figure11.pdf"))
end
