"""
    misr_fspec = make_misr_fspec_tst_L1RTGM2()

# Purpose(s):
* Generate the output of `make_misr_fpath.jl` for testing purposes. Test L1RTGM2: For a MISR L1RTGM file, with an alternate root directory `misr_fpath`.

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

julia> include(Tools_test * "make_misr_fspec_tst_L1RTGM2.jl")
make_misr_fspec_tst_L1RTGM2

julia> misr_fspec = make_misr_fspec_tst_L1RTGM2();

julia> @test misr_fspec[1] == "my_path/MISR_AM1_GRP_TERRAIN_GM_P168_O068050_AN_F03_0024.hdf"
Test Passed
```
"""
function make_misr_fspec_tst_L1RTGM2(
    )::Vector{AbstractString}

    set_mroots("Reset");
    misr_fspec = make_misr_fspec("L1RTGM", 168;
        misr_orbit = 68050, misr_camera = "AN", misr_fpath = "my_path")

    return misr_fspec

end
