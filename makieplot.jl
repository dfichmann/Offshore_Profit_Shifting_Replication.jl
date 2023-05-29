coast!(region=(-130, -65, 24, 50), proj=:merc, land=:grey, water=:lightblue, figsize=15, par=(FONT_ANNOT_PRIMARY=5,))

c1 = (country=:US, pen=(0.1, :darkgreen), fill=:green)  # United States
c2 = (country=:CH, pen=(0.1, :red), fill=:red)          # Switzerland
c3 = (country=:NL, pen=(0.1, :red), fill=:red)          # Netherlands
c4 = (country=:LU, pen=(0.1, :red), fill=:red)          # Luxembourg
c5 = (country=:IE, pen=(0.1, :red), fill=:red)          # Ireland
c6 = (country=:BM, pen=(0.1, :red), fill=:red)          # Bermuda

countries = tuple(c1, c2, c3, c4, c5, c6)

coast!(DCW=countries, fmt=:png, show=true)
Plots.savefig("map.png")





using GMT

# Define the coast
fig <- coast(region=(-110, 25, 0, 60), proj=:merc, land=:grey, water=:lightblue, figsize=15, frame=:a)
fig
# Draw countries with different colors
Plots.plot!(fig, DCW=:US, fill=:green)
plot!(fig, DCW=:CH, fill=:red)
plot!(fig, DCW=:NL, fill=:red)
plot!(fig, DCW=:LU, fill=:red)
plot!(fig, DCW=:IE, fill=:red)
plot!(fig, DCW=:BM, fill=:red)

# Add labels to countries (you may need to adjust coordinates)
text!(fig, [-100, 45], "US", fontsize=12, fontcolor=:black)
text!(fig, [8, 46.8], "CH", fontsize=12, fontcolor=:black)
text!(fig, [5.3, 52.2], "NL", fontsize=12, fontcolor=:black)
text!(fig, [6.1, 49.6], "LU", fontsize=12, fontcolor=:black)
text!(fig, [-8, 53], "IE", fontsize=12, fontcolor=:black)
text!(fig, [-64.7, 32.3], "BM", fontsize=12, fontcolor=:black)

# Save the figure to your repository
Plots.savefig(fig, "myfigure.png")
