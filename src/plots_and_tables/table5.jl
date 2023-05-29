"""
This function replicates table 5. The Table is saved in the folder "ReplicationFiles/tables" as a markdown file.
"""
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
    file = open("ReplicationFiles/tables/Table5.md", "w")
    
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