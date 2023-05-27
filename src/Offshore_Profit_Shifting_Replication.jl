module Offshore_Profit_Shifting_Replication

# Write your package code here.

### include the testcode.jl file:

include("makeplotdata.jl")

makeplotdata()

include("allplots.jl")
plot1()
plot2()
plot3()

end