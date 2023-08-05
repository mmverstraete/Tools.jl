"""
    misrhr_fpath = make_misrhr_fpath_tst_L1RCCMmvrMap()

# Purpose(s):
* Generate the output of `make_misrhr_fpath.jl` for testing purposes. Test L1RCCMmvrMap: For a map of the `L1RCCMmvr` product.

# Positional argument(s): None.

# Keyword argument(s): None:

# Return value(s):
* `misrhr_fpath::AbstractString`: The full name of the directory containing the MISRHR file(s) for the specified arguments.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "make_misrhr_fpath_tst_L1RCCMmvrMap.jl")
make_misrhr_fpath_tst_L1RCCMmvrMap

julia> misrhr_fpath = make_misrhr_fpath_tst_L1RCCMmvrMap();

julia> @test misrhr_fpath == "/Users/michel/Projects/MISR/Scrap/John/Test/P168-P170+O068000-O072000+SITE-SKUKUZA/make_misrhr_fpath/L1RCCMmvr/Map/"
Test Passed
```
"""
function make_misrhr_fpath_tst_L1RCCMmvrMap(
    )::AbstractString

    set_mroots("Reset")

    user = "John"
    project = "Test"
    misr_path1 = 168
    misr_path2 = 170
    misr_orbit1 = 68000
    misr_orbit2 = 72000
    misr_site = "Skukuza"
    prdct = "L1RCCMmvr"
    ftype = "Map"
    misrhr_fpath = make_misrhr_fpath(; user = user, project = project,
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_site = misr_site, prdct = prdct, ftype = ftype)

    return misrhr_fpath

end
