module Offshore_Profit_Shifting_Replication
    using Markdown, DataFrames, Plots, Statistics, CSV, DataFrames, XLSX, Missings, Interpolations, Impute, DataFramesMeta

    # DATA WRANGLING IN JULIA
        # Main dataframes for plots
            include("wrangle_data/makeplotdata.jl")
            # Read Excel file
            public = CSV.read("ReplicationFiles/data/aggregate.csv", DataFrame)
            adj_agg = DataFrame(XLSX.readtable("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNet.xlsx", "ADJNETSCALE"))
            adj_ind = DataFrame(XLSX.readtable("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetIndustry.xlsx", "ADJINDSCALE"))
            adj_tax = DataFrame(XLSX.readtable("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetHaven.xlsx", "ADJHVNSCALE"))
            
            #run function that creates the main dataframes
            public, adj_agg, adj_ind, adj_tax = makeplotdata(public, adj_agg, adj_ind, adj_tax)
        
        # Additional data adjustments for certain plots and tables
            include("wrangle_data/makedataplot2.jl")
            # Read Excel file
            boot = DataFrame(XLSX.readtable("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAggStdError.xlsx", "STACKAGGADJ"))
            # Run function
            panel_stats = makedataforplot2(boot)

        # Further editing of loaded data
            include("wrangle_data/makedataplot7.jl")
            # Run function:
            prod = makedataforplot7(public)

        # Final data wrangling:
            include("wrangle_data/makedataplot8.jl")
            # Read excel data
            files_and_sheets = [("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetITP.xlsx", "ADJITPSCALE"),
                                        ("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetITU.xlsx", "ADJITUSCALE"),
                                        ("ReplicationFiles/0-confidential-data-replication-files/USDIA/OutputAdjNetRD.xlsx", "ADJRDSCALE")]
            # Run function
            inds = makedataforplot8(files_and_sheets)


    # LOADING FUNCTIONS TO MAKE THE PLOTS AND TABLES  
        # plots
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

        # tables
        include("plots_and_tables/table1.jl")
        include("plots_and_tables/table2.jl")
        include("plots_and_tables/table5.jl")
        include("plots_and_tables/table6.jl")

end