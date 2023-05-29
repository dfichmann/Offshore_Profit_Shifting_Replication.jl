# Offshore_Profit_Shifting_Replication

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://dfichmann.github.io/Offshore_Profit_Shifting_Replication.jl/dev/)
[![Build Status](https://github.com/dfichmann/Offshore_Profit_Shifting_Replication.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/dfichmann/Offshore_Profit_Shifting_Replication.jl/actions/workflows/CI.yml?query=branch%3Amain)

# Offshore Profit Shifting Replication

This repository contains the Julia replication package for the paper:

Guvenen, Fatih, Raymond J. Mataloni Jr., Dylan G. Rassier, and Kim J. Ruhl. 2022. "Offshore Profit Shifting and Aggregate Measurement: Balance of Payments, Foreign Investment, Productivity, and the Labor Share." American Economic Review, 112 (6): 1848-84.
[DOI: 10.1257/aer.20190285](https://www.aeaweb.org/articles?id=10.1257/aer.20190285)

I downloaded the original python replication package from the [AER website](https://www.aeaweb.org/articles?id=10.1257/aer.20190285)

## Abstract

The paper shows how offshore profit shifting by US multinational enterprises affects several key measures of the US economy. Profits shifted out of the United States grew rapidly from the mid-1990s to 2010 and have since waned. From 1982–2016, on average, 38 percent of income attributed to US direct investment abroad is reattributable to the United States. The paper finds that adjusting for profit shifting shrinks the trade deficit, decreases the return on US foreign direct investment abroad, boosts productivity growth rates in the late 1990s and early 2000s, and lowers labor's share of income.

## Repository Contents

- **src**: Julia code for replicating the results presented in the paper.
- **data**: Data required for the replication.
- **figures**: Generated figures in PDF format.
- **tables**: Generated tables in Markdown format.

## Requirements

- Julia 1.8.5 or later
- Required Julia packages: DataFrames, Plots, Statistics, CSV, XLSX, Missings, Interpolations, Impute, DataFramesMeta

## How to Run

1. Clone this repository to your local machine.
2. Open Julia and navigate to the repository's directory.
3. Run the following commands:

```julia
using Offshore_Profit_Shifting_Replication

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

Offshore_Profit_Shifting_Replication.table1()
Offshore_Profit_Shifting_Replication.table2()
Offshore_Profit_Shifting_Replication.table5()
Offshore_Profit_Shifting_Replication.table6()
