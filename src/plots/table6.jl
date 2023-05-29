

function table6()

intervals = [(1982, 1994), (1994, 2016), (1994,2004), (2004,2016), (2004,2008), (2008,2016)]

rda, rdu, nrda, nrdu = [], [], [], [] 
for i in intervals
    push!(rda, inds[inds.year .== i[2], :rd_prod_adj_cgr][1] - inds[inds.year .== i[1], :rd_prod_adj_cgr][1])
    push!(rdu, inds[inds.year .== i[2], :rd_prod_unadj_cgr][1] - inds[inds.year .== i[1], :rd_prod_unadj_cgr][1])
    push!(nrda, inds[inds.year .== i[2], :nrd_prod_adj_cgr][1] - inds[inds.year .== i[1], :nrd_prod_adj_cgr][1])
    push!(nrdu, inds[inds.year .== i[2], :nrd_prod_unadj_cgr][1] - inds[inds.year .== i[1], :nrd_prod_unadj_cgr][1])
end

indext = [string(i[1]) * "--" * string(i[2]) for i in intervals]
    
t6 = DataFrame(RD_Adjusted = rda, RD_Unadjusted = rdu, NRD_Adjusted = nrda, NRD_Unadjusted = nrdu)
t6 = transform!(t6, names(t6) .=> (x -> x*100) .=> names(t6))

# Converting DataFrame to an array and transposing it
t6_array = Array(t6)
t6_transposed = transpose(t6_array)

# Converting the transposed array back to a DataFrame
t6_transposed_df = DataFrame(t6_transposed, :auto)

# Assign new column names
rename!(t6_transposed_df, ["82-94", "94-16", "94-04", "04-16", "04-08", "08-16"])

# Add a new column with row names
t6_transposed_df[!, :RowNames] = ["R&D intensive adjusted", "R&D intensive unadjusted", "non-R&D intensive adjusted", "non-R&D intensive unadjusted"]

# Reorder the columns so that the row names column is first
t6_final = t6_transposed_df[:, ["RowNames", "82-94", "94-16", "94-04", "04-16", "04-08", "08-16"]]

# Open the file in write mode
file = open("ReplicationFiles/4-tables/Table6.md", "w")

# Write the table header to the file
write(file, "| RowNames | 82-94 | 94-16 | 94-04 | 04-16 | 04-08 | 08-16 |\n")
write(file, "| --- | --- | --- | --- | --- | --- | --- |\n")

# Write the rounded table rows to the file
for i in 1:size(t6_final, 1)
    row_name = t6_final[i, :RowNames]
    rd_82_94 = round(t6_final[i, Symbol("82-94")], digits=1)
    rd_94_16 = round(t6_final[i, Symbol("94-16")], digits=1)
    rd_94_04 = round(t6_final[i, Symbol("94-04")], digits=1)
    rd_04_16 = round(t6_final[i, Symbol("04-16")], digits=1)
    rd_04_08 = round(t6_final[i, Symbol("04-08")], digits=1)
    rd_08_16 = round(t6_final[i, Symbol("08-16")], digits=1)

    write(file, "| $row_name | $rd_82_94 | $rd_94_16 | $rd_94_04 | $rd_04_16 | $rd_04_08 | $rd_08_16 |\n")
end

# Close the file
close(file)
end
