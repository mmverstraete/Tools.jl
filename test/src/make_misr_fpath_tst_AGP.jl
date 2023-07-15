"""
    misr_fpath = make_misr_fpath_tst_AGP()

# Purpose(s):
* Generate the output of `make_misr_fpath.jl` for testing purposes. Test AGP: For a MISR AGP file.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misr_fpath::AbstractString`: The full name of the directory containing MISR data file(s) for the specified product acronym and Path number.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "make_misr_fpath_tst_AGP.jl")
make_misr_fpath_tst_AGP

julia> misr_fpath = make_misr_fpath_tst_AGP();

julia> @test misr_fpath == "~/P168/AGP/"
Test Passed
```
"""
function make_misr_fpath_tst_AGP(
    )::AbstractString

    misr_prdct = "AGP"
    misr_path = 168

    set_mroots("Unset");
    misr_fpath = make_misr_fpath(misr_prdct, misr_path)
    set_mroots("Reset");

    return misr_fpath

end
