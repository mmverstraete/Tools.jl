"""
    misrhr_fspec = make_misrhr_fspec_tst_L2LAND()

# Purpose(s):
* Generate the output of `make_misrhr_fspec.jl` for testing purposes. Test L2LAND: For the map of a MISR L2LAND product.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misrhr_fspec::AbstractString`: The specification of the MISRHR output file.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "make_misrhr_fspec_tst_L2LAND.jl")
make_misrhr_fspec_tst_L2LAND

julia> misrhr_fspec = make_misrhr_fspec_tst_L2LAND();

julia> @test misrhr_fspec == "/Users/michel/Projects/MISR/Scrap/MMV/Explore/P192-P194+O080000-O082000+B056-B058/make_misrhr_fpath/L2LAND/Map/Map_L2LAND_Bidirectional-Reflectance-Factor_main_R1100_P192-P194+O080000-O082000+B056-B058_2015-01-01+2015-05-19+2023-08-03_F08-0023+v3.0.0.png"
Test Passed
```
"""
function make_misrhr_fspec_tst_L2LAND(
    )::AbstractString

    set_mroots("Reset");

    ftype = "Map"
    prdct = "L2LAND"
    subprdct = "Bidirectional_Reflectance_Factor"
    user = "MMV"
    project = "Explore"
    misr_path1 = 192
    misr_path2 = 194
    misr_orbit1 = 80000
    misr_orbit2 = 82000
    misr_block1 = 56
    misr_block2 = 58
    misrhr_fspec = make_misrhr_fspec(ftype, prdct, subprdct;
        user = user, project = project,
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2)

    return misrhr_fspec

end
