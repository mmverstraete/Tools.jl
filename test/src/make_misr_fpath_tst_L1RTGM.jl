"""
    misr_fpath = make_misr_fpath_tst_L1RTGM()

# Purpose(s):
* Generate the output of `make_misr_fpath.jl` for testing purposes. Test L1RTGM: For a MISR L1RTGM file.

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

julia> include(Tools_test * "make_misr_fpath_tst_L1RTGM.jl")
make_misr_fpath_tst_L1RTGM

julia> misr_fpath = make_misr_fpath_tst_L1RTGM();

julia> @test misr_fpath == "/Volumes/MISR_Data0/P168/L1RTGM/"
Test Passed
```
"""
function make_misr_fpath_tst_L1RTGM(
    )::AbstractString

    misr_prdct = "L1RTGM"
    misr_path = 168

    set_mroots("Reset");
    misr_fpath = make_misr_fpath(misr_prdct, misr_path)

    return misr_fpath

end
