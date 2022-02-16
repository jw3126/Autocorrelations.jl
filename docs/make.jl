using Autocorrelations
using Documenter

DocMeta.setdocmeta!(Autocorrelations, :DocTestSetup, :(using Autocorrelations); recursive=true)

makedocs(;
    modules=[Autocorrelations],
    authors="Jan Weidner <jw3126@gmail.com> and contributors",
    repo="https://github.com/jw3126/Autocorrelations.jl/blob/{commit}{path}#{line}",
    sitename="Autocorrelations.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jw3126.github.io/Autocorrelations.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jw3126/Autocorrelations.jl",
)
