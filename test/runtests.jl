using Offshore_Profit_Shifting_Replication
using Test
using DataFrames

@testset "Offshore_Profit_Shifting_Replication.jl" begin
    public, adj_agg, adj_ind, adj_tax = Offshore_Profit_Shifting_Replication.makeplotdata()

    # Test the types of the outputs
    @test isa(public, DataFrame)
    @test isa(adj_agg, DataFrame)
    @test isa(adj_ind, DataFrame)
    @test isa(adj_tax, DataFrame)

    panel_stats = Offshore_Profit_Shifting_Replication.makedataforplot2()
    @test isa(panel_stats, DataFrame)

    prod = Offshore_Profit_Shifting_Replication.makedataforplot7()
    @test isa(prod, DataFrame)

    inds = Offshore_Profit_Shifting_Replication.makedataforplot8()
    @test isa(inds, DataFrame)
end
