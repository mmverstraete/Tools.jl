using Tools
using Documenter

DocMeta.setdocmeta!(Tools, :DocTestSetup, :(using Tools); recursive=true)

makedocs(;
    modules=[Tools],
    authors="Michel Verstraete <MMVerstraete@gmail.com> and contributors",
    repo="https://github.com/mmverstraete/Tools.jl/blob/{commit}{path}#{line}",
    sitename="Tools.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
