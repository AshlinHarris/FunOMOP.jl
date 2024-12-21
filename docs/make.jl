using Documenter
using FunOMOP

makedocs(
    sitename = "FunOMOP",
    format = Documenter.HTML(),
    modules = [FunOMOP],
    #doctest = :fix,
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/AshlinHarris/FunOMOP.jl.git",
)
