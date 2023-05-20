using Offshore_Profit_Shifting_Replication
using Documenter

DocMeta.setdocmeta!(Offshore_Profit_Shifting_Replication, :DocTestSetup, :(using Offshore_Profit_Shifting_Replication); recursive=true)

makedocs(;
    modules=[Offshore_Profit_Shifting_Replication],
    authors="Daniel Fichmann <daniel.fichmann@icloud.com> and contributors",
    repo="https://github.com/dfichmann/Offshore_Profit_Shifting_Replication.jl/blob/{commit}{path}#{line}",
    sitename="Offshore_Profit_Shifting_Replication.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://dfichmann.github.io/Offshore_Profit_Shifting_Replication.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/dfichmann/Offshore_Profit_Shifting_Replication.jl",
    devbranch="main",
)
