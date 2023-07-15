"""
    misr_fspec = make_misr_fspec_tst_L1RTGM1()

# Purpose(s):
* Generate the output of `make_misr_fpath.jl` for testing purposes. Test L1RTGM1: For a MISR L1RTGM file, with the default root directory.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misr_fspec::Vector{AbstractString}`: The specification(s) (path(s) and name(s)) of the MISR data file(s) correponding to the input arguments.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "make_misr_fspec_tst_L1RTGM1.jl")
make_misr_fspec_tst_L1RTGM1

julia> misr_fspec = make_misr_fspec_tst_L1RTGM1();

julia> @test misr_fspec[1] == "/Volumes/MISR_Data0/P168/L1RTGM/MISR_AM1_GRP_TERRAIN_GM_P168_O068050_AN_F03_0024.hdf"
Test Passed
```
"""
function make_misr_fspec_tst_L1RTGM1(
    )::Vector{AbstractString}

    set_mroots("Reset");
    misr_fspec = make_misr_fspec("L1RTGM", 168;
        misr_orbit = 68050, misr_camera = "AN", misr_site = "", misr_version = "")

    return misr_fspec

end
