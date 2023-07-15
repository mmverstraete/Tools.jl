"""
    misr_fname = make_misr_fname_tst_AGP2()

# Purpose(s):
* Generate the output of `make_misr_fname.jl` for testing purposes. Test AGP2: For a MISR AGP file, mentioning also the unnecessary keyword arguments.

# Positional argument(s): None.

# Keyword argument(s): None.
    
# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "make_misr_fname_tst_AGP2.jl")
make_misr_fname_tst_AGP2

julia> misr_fname = make_misr_fname_tst_AGP2();
"MISR_AM1_AGP_P168_F01_24.hdf"

julia> @test misr_fname == ["MISR_AM1_AGP_P168_F01_24.hdf"]
Test Passed
```
"""
function make_misr_fname_tst_AGP2()
    misr_prdct = "AGP"
    misr_path = 168
    misr_fname = make_misr_fname(misr_prdct, misr_path; misr_orbit = 12345,
        misr_camera = "xy", misr_site = nothing, misr_version = "")

    return misr_fname

end
